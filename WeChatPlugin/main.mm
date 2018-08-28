//
//  main.mm
//  WeChatPlugin
//
//  Created by Leon on 2018/8/28.
//  Copyright © 2018年 leonadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+HookRevoke.h"

// 初始化入口，所有hook的方法都加在这里
static void __attribute__((constructor)) initialize(void) {
    NSLog(@"******** WeChatPlugin loaded ********");
    [NSObject hookRevoke];
}
