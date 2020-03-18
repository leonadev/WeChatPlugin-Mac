//
//  WeChatPlugin.h
//  WeChatPlugin
//
//  Created by leonadev on 2018/8/28.
//  Copyright © 2018年 leonadev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for WeChatPlugin.
FOUNDATION_EXPORT double WeChatPluginVersionNumber;

//! Project version string for WeChatPlugin.
FOUNDATION_EXPORT const unsigned char WeChatPluginVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WeChatPlugin/PublicHeader.h>
#import "AddMsg.h"

@interface MessageData : NSObject
- (id)initWithMsgType:(long long)arg1;
@property(retain, nonatomic) NSString *fromUsrName;
@property(retain, nonatomic) NSString *toUsrName;
@property(retain, nonatomic) NSString *msgContent;
@property(retain, nonatomic) NSString *msgPushContent;
@property(nonatomic) int messageType;
@property(nonatomic) int msgStatus;
@property(nonatomic) int msgCreateTime;
@property(nonatomic) int mesLocalID;
@property(nonatomic) long long mesSvrID;
@property(retain, nonatomic) NSString *msgVoiceText;
@property(copy, nonatomic) NSString *m_nsEmoticonMD5;
- (BOOL)isChatRoomMessage;
- (NSString *)groupChatSenderDisplayName;
- (id)getRealMessageContent;
- (id)getChatRoomUsrName;
- (BOOL)isSendFromSelf;
- (BOOL)isCustomEmojiMsg;
- (BOOL)isImgMsg;
- (BOOL)isVideoMsg;
- (BOOL)isVoiceMsg;
- (BOOL)canForward;
- (BOOL)IsPlayingSound;
- (id)summaryString:(BOOL)arg1;
- (BOOL)isEmojiAppMsg;
- (BOOL)isAppBrandMsg;
- (BOOL)IsUnPlayed;
- (void)SetPlayed;
@property(retain, nonatomic) NSString *m_nsTitle;
- (id)originalImageFilePath;
@property(retain, nonatomic) NSString *m_nsVideoPath;
@property(retain, nonatomic) NSString *m_nsFilePath;
@property(retain, nonatomic) NSString *m_nsAppMediaUrl;
@property(nonatomic) MessageData *m_refMessageData;
@property(nonatomic) unsigned int m_uiDownloadStatus;
- (void)SetPlayingSoundStatus:(BOOL)arg1;
@end

@interface MessageService : NSObject
- (void)onAddMsg:(id)arg1 msgData:(id)arg2;
- (void)notifyAddMsgOnMainThread:(id)arg1 msgData:(id)arg2;
- (void)onRevokeMsg:(id)arg1;
- (void)FFToNameFavChatZZ:(id)arg1;
- (void)FFToNameFavChatZZ:(id)arg1 sessionMsgList:(id)arg2;
- (void)OnSyncBatchAddMsgs:(NSArray *)arg1 isFirstSync:(BOOL)arg2;
- (void)OnSyncBatchAddFunctionMsgs:(id)arg1 isFirstSync:(BOOL)arg2;
- (void)FFImgToOnFavInfoInfoVCZZ:(id)arg1 isFirstSync:(BOOL)arg2;
- (id)GetMsgListWithChatName:(id)arg1 fromCreateTime:(unsigned int)arg2 limitCnt:(NSInteger)arg3 hasMore:(char *)arg4 sortAscend:(BOOL)arg5;
- (id)SendTextMessage:(id)arg1 toUsrName:(id)arg2 msgText:(id)arg3 atUserList:(id)arg4;
- (id)SendImgMessage:(id)arg1 toUsrName:(id)arg2 thumbImgData:(id)arg3 midImgData:(id)arg4 imgData:(id)arg5 imgInfo:(id)arg6;
- (id)SendVideoMessage:(id)arg1 toUsrName:(id)arg2 videoInfo:(id)arg3 msgType:(unsigned int)arg4 refMesageData:(id)arg5;
- (id)SendLocationMsgFromUser:(id)arg1 toUser:(id)arg2 withLatitude:(double)arg3 longitude:(double)arg4 poiName:(id)arg5 label:(id)arg6;
- (id)SendNamecardMsgFromUser:(id)arg1 toUser:(id)arg2 containingContact:(id)arg3;
- (id)SendEmoticonMsgFromUsr:(id)arg1 toUsrName:(id)arg2 md5:(id)arg3 emoticonType:(unsigned int)arg4;
- (id)SendAppURLMessageFromUser:(id)arg1 toUsrName:(id)arg2 withTitle:(id)arg3 url:(id)arg4 description:(id)arg5 thumbnailData:(id)arg6;

- (id)GetMsgData:(id)arg1 svrId:(long)arg2;
- (void)AddLocalMsg:(id)arg1 msgData:(id)arg2;
- (void)TranscribeVoiceMessage:(id)arg1 completion:(void (^)(void))arg2;
- (BOOL)ClearUnRead:(id)arg1 FromID:(unsigned int)arg2 ToID:(unsigned int)arg3;
- (BOOL)ClearUnRead:(id)arg1 FromCreateTime:(unsigned int)arg2 ToCreateTime:(unsigned int)arg3;
- (BOOL)hasMsgInChat:(id)arg1;
- (id)GetMsgListWithChatName:(id)arg1 fromLocalId:(unsigned int)arg2 limitCnt:(NSInteger)arg3 hasMore:(char *)arg4 sortAscend:(BOOL)arg5;
- (id)GetMsgListWithChatName:(id)arg1 fromMinCreateTime:(unsigned int)arg2 localId:(unsigned long long)arg3 limitCnt:(unsigned int)arg4 hasMore:(char *)arg5;
- (id)GetMsgListWithChatName:(id)arg1 fromCreateTime:(unsigned int)arg2 localId:(unsigned long long)arg3 limitCnt:(unsigned int)arg4 hasMore:(char *)arg5 sortAscend:(BOOL)arg6;

- (id)ForwardMessage:(id)arg1 toUser:(id)arg2 errMsg:(id *)arg3;
@end

@interface MMServiceCenter : NSObject
+ (id)defaultCenter;
- (id)getService:(Class)arg1;
@end
