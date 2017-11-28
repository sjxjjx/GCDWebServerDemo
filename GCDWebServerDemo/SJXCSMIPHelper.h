//
//  SJXCSMIPHelper.h
//  LocalReader
//
//  Created by shapp on 2017/7/24.
//  Copyright © 2017年 sjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJXCSMIPHelper : NSObject

/** 获取ip地址 */
+ (NSString *)deviceIPAdress;

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
