//
//  NSObject+HookUpgrade.m
//  WeChatPlugin
//
//  Created by leonadev on 2018/10/26.
//  Copyright © 2018年 leonadev. All rights reserved.
//

#import "NSObject+HookUpgrade.h"
#import "WeChatPlugin.h"
#import <objc/message.h>
#import "PluginUtils.h"

@implementation NSObject (HookUpgrade)

+ (void)hookUpgrade {
    hookMethod(objc_getClass("WeChat"),
               @selector(checkForUpdates),
               [self class],
               @selector(_hook_checkForUpdates)
               );
    
    if ([PluginUtils isVersionNewerThan:@"2.3.24"]) {
        hookMethod(objc_getClass("WeChat"),
                   @selector(setupCheckUpdateIfNeeded),
                   [self class],
                   @selector(_hook_checkForUpdatesInBackground)
                   );
        hookMethod(objc_getClass("MMUpdateMgr"),
                   @selector(sparkleUpdater),
                   [self class],
                   @selector(_hook_sparkleUpdater)
                   );
    } else {
        hookMethod(objc_getClass("WeChat"),
                   @selector(checkForUpdatesInBackground),
                   [self class],
                   @selector(_hook_checkForUpdatesInBackground)
                   );
    }
}

#pragma mark - Private
- (void)_hook_checkForUpdates {
    NSLog(@"[WeChatPlugin] hooked: %@", NSStringFromSelector(_cmd));
}

- (void)_hook_checkForUpdatesInBackground {
    NSLog(@"[WeChatPlugin] hooked: %@", NSStringFromSelector(_cmd));
}

- (id)_hook_sparkleUpdater {
    NSLog(@"[WeChatPlugin] hooked: %@", NSStringFromSelector(_cmd));
    return nil;
}

@end
