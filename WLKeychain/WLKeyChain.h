//
//  WLKeyChain.h
//  PIFlow
//
//  Created by WangXingNeng on 15/3/16.
//  Copyright (c) 2015年 Inveno. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Security/Security.h>

#if Hotoday==2
/********************Hotoday********************/
#define KEY_USERNAME_URL_LTK        @"com.inveno.hotoday.india.usernameurlltk"
#define KEY_USERNAME                @"com.inveno.hotoday.india.username"
#define KEY_USERHEADURL             @"com.inveno.hotoday.india.userheadurl"
#define KEY_USERLTK                 @"com.inveno.hotoday.india.userltk"
#define KEY_USERID                  @"com.inveno.hotoday.india.userid"
#define KEY_USERYJURL               @"com.inveno.hotoday.india.useryjurl"//小知印记
#define KEY_CFUUID                  @"com.inveno.hotoday.india.cfuuid"


#elif YouthFeed==1
/******************YouthFeed********************/
#define KEY_USERNAME_URL_LTK        @"com.inveno.xiaozhi.usernameurlltk"
#define KEY_USERNAME                @"com.inveno.xiaozhi.username"
#define KEY_USERHEADURL             @"com.inveno.xiaozhi.userheadurl"
#define KEY_USERLTK                 @"com.inveno.xiaozhi.userltk"
#define KEY_USERID                  @"com.inveno.xiaozhi.userid"
#define KEY_USERYJURL               @"com.inveno.xiaozhi.useryjurl"//小知印记
#define KEY_CFUUID                  @"com.inveno.xiaozhi.cfuuid"

#endif

@interface WLKeyChain : NSObject

+(void)saveObject:(id)data forServiceKey:(NSString *)service;

+(id)loadServiceForKey:(NSString *)service;

+(void)deleteServiceForKey:(NSString *)service;

/**
 *  获取用户数据（从Keychain中获取）
 **/
+ (NSString *)loadUserInfoForKey:(NSString *)key;

@end
