//
//  PluginUtils.h
//  WeChatPlugin
//
//  Created by leonadev on 2020/3/4.
//  Copyright © 2020 leonadev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PluginUtils : NSObject

+ (BOOL)isVersionNewerThan:(NSString *)compareVersion;

void hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector);

void hookClassMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector);

@end

NS_ASSUME_NONNULL_END
