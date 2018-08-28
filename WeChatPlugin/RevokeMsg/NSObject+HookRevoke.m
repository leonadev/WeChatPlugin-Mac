//
//  NSObject+HookRevoke.m
//  WeChatPlugin
//
//  Created by Leon on 2018/8/28.
//  Copyright © 2018年 leonadev. All rights reserved.
//

#import "NSObject+HookRevoke.h"
#import "WeChatPlugin.h"
#import <objc/message.h>
#import "XMLReader.h"

@implementation NSObject (HookRevoke)

#pragma mark - Public
+ (void)hookRevoke
{
    Method oriMethod = class_getInstanceMethod(objc_getClass("MessageService"), @selector(onRevokeMsg:));
    Method swzMethod = class_getInstanceMethod([self class], @selector(_hook_onRevokeMsg:));
    if (oriMethod && swzMethod) {
        method_exchangeImplementations(oriMethod, swzMethod);
    }
}

#pragma mark - Private
- (void)_hook_onRevokeMsg:(id)msg
{
    NSRange contentRange = [msg rangeOfString:@"<sysmsg"];
    if (contentRange.length <= 0) {
        // 消息协议不符
        return;
    }
    NSString *msgContent = [msg substringFromIndex:contentRange.location];
    
    // 将msg从xml转换为dict
    NSError *error;
    NSDictionary *msgDict = [XMLReader dictionaryForXMLString:msgContent error:&error];
    NSDictionary *revokeMsgDict = msgDict[@"sysmsg"][@"revokemsg"];
    if (error == nil && revokeMsgDict != nil) {
        NSString *newmsgid = revokeMsgDict[@"newmsgid"][@"text"];
        NSString *session = revokeMsgDict[@"session"][@"text"];
        msgDict = nil;
        revokeMsgDict = nil;
        if (newmsgid == nil || session == nil) {
            return;
        }
        
        // 通过从dict中解析的msgid和session，从微信消息服务中获取messageData
        MessageService *msgService = [[objc_getClass("MMServiceCenter") defaultCenter] getService:objc_getClass("MessageService")];
        MessageData *revokeMsgData = [msgService GetMsgData:session svrId:[newmsgid integerValue]];
        if ([revokeMsgData isSendFromSelf]) {
            // 如果是自己撤回的消息，直接调用原方法进行撤回
            [self _hook_onRevokeMsg:msg];
            return;
        }
        
        // 他人撤回的消息，在本地生成并插入一条本地通知
        NSString *msgContent = [self messageContentWithData:revokeMsgData];
        NSString *msgSenderName = [self messageGroupSenderNameWithData:revokeMsgData].length > 0 ? [NSString stringWithFormat:@"\"%@\"", [self messageGroupSenderNameWithData:revokeMsgData]] : @"对方";
        NSString *hookedContent = [NSString stringWithFormat:@"%@撤回消息：%@", msgSenderName, msgContent];
        
        // 构造新的messageData
        MessageData *hookedMsgData = [[objc_getClass("MessageData") alloc] initWithMsgType:0x2710];
        [hookedMsgData setFromUsrName:revokeMsgData.toUsrName];
        [hookedMsgData setToUsrName:revokeMsgData.fromUsrName];
        [hookedMsgData setMsgStatus:4];
        [hookedMsgData setMsgContent:hookedContent];
        [hookedMsgData setMsgCreateTime:[revokeMsgData msgCreateTime]];
        
        [msgService AddLocalMsg:session msgData:hookedMsgData];
    }
}

// 获取消息内容
- (NSString *)messageContentWithData:(MessageData *)msgData
{
    if (msgData == nil) {
        return @"";
    }
    NSString *msgContent = [msgData summaryString:NO] ? : @"";
    if (msgData.m_nsTitle && (msgData.isAppBrandMsg || [msgContent isEqualToString:[[NSBundle mainBundle] localizedStringForKey:@"Message_type_unsupport" value:@"" table:nil]])) {
        msgContent = [msgContent stringByAppendingString:msgData.m_nsTitle ? : @""];
    }
    return msgContent;
}

// 获取群聊发送者昵称
- (NSString *)messageGroupSenderNameWithData:(MessageData *)msgData
{
    if (msgData == nil) {
        return @"";
    }
    if ([msgData respondsToSelector:@selector(isChatRoomMessage)] && msgData.isChatRoomMessage && msgData.groupChatSenderDisplayName.length > 0) {
        return [msgData.groupChatSenderDisplayName copy];
    }
    return @"";
}

@end
