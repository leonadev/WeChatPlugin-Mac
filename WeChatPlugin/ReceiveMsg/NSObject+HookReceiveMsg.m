//
//  NSObject+HookReceiveMsg.m
//  WeChatPlugin
//
//  Created by leonadev on 2018/10/22.
//  Copyright © 2018年 leonadev. All rights reserved.
//

#import "NSObject+HookReceiveMsg.h"
#import "WeChatPlugin.h"
#import <objc/message.h>

@implementation NSObject (HookReceiveMsg)

+ (void)hookRecevieMsg
{
    Method oriMethod = class_getInstanceMethod(objc_getClass("MessageService"), @selector(OnSyncBatchAddMsgs:isFirstSync:));
    Method swzMethod = class_getInstanceMethod([self class], @selector(_hook_onSyncBatchAddMsgs:isFirstSync:));
    if (oriMethod && swzMethod) {
        method_exchangeImplementations(oriMethod, swzMethod);
    }
}

#pragma mark - Private
- (void)_hook_onSyncBatchAddMsgs:(NSArray *)msgs isFirstSync:(BOOL)isFirstSync
{
    for (id msg in msgs) {
        if ([msg isKindOfClass:objc_getClass("AddMsg")]) {
            AddMsg *addMsg = msg;
            if (addMsg.msgType == 49) {
                if ([addMsg.content.string containsString:@"[微信红包]"]) {
                    NSUserNotification *notification = [[NSUserNotification alloc] init];
                    [notification setTitle:@"微信"];
                    [notification setSubtitle:@"红包来啦！"];
                    [notification setSoundName:@"alert"];
                    NSUserNotificationCenter *userNotificationCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
                    [userNotificationCenter scheduleNotification:notification];
                }
            }
        }
    }
    
    [self _hook_onSyncBatchAddMsgs:msgs isFirstSync:isFirstSync];
}

@end
