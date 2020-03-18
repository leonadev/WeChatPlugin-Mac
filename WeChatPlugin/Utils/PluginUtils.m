//
//  PluginUtils.m
//  WeChatPlugin
//
//  Created by leonadev on 2020/3/4.
//  Copyright © 2020 leonadev. All rights reserved.
//

#import "PluginUtils.h"
#import <objc/runtime.h>

@implementation PluginUtils

+ (BOOL)isVersionNewerThan:(NSString *)compareVersion {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    return ([dict[@"CFBundleShortVersionString"] compare:compareVersion options:NSNumericSearch] != NSOrderedAscending);
}

void hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method oriMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swzMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    if (oriMethod && swzMethod) {
        method_exchangeImplementations(oriMethod, swzMethod);
    }
}

void hookClassMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method oriMethod = class_getClassMethod(originalClass, originalSelector);
    Method swzMethod = class_getClassMethod(swizzledClass, swizzledSelector);
    if (oriMethod && swzMethod) {
        method_exchangeImplementations(oriMethod, swzMethod);
    }
}

@end
