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

@implementation NSObject (HookUpgrade)

+ (void)hookUpgrade
{
    Method oriMethod = class_getInstanceMethod(objc_getClass("WeChat"), @selector(checkForUpdates));
    Method swzMethod = class_getInstanceMethod([self class], @selector(_hook_checkForUpdates));
    if (oriMethod && swzMethod) {
        method_exchangeImplementations(oriMethod, swzMethod);
    }
    
    Method oriMethod1 = class_getInstanceMethod(objc_getClass("WeChat"), @selector(checkForUpdatesInBackground));
    Method swzMethod1 = class_getInstanceMethod([self class], @selector(_hook_checkForUpdatesInBackground));
    if (oriMethod1 && swzMethod1) {
        method_exchangeImplementations(oriMethod1, swzMethod1);
    }
}

#pragma mark - Private
- (void)_hook_checkForUpdates
{
    
}

- (void)_hook_checkForUpdatesInBackground
{
    
}

@end
