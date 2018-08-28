//
//  NSObject+HookRevoke.h
//  WeChatPlugin
//
//  Created by Leon on 2018/8/28.
//  Copyright © 2018年 leonadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HookRevoke)

/**
 hook微信的消息撤回方法
 */
+ (void)hookRevoke;

@end
