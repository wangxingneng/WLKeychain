//
//  WLKeyChain.m
//  PIFlow
//
//  Created by WangXingNeng on 15/3/16.
//  Copyright (c) 2015年 Inveno. All rights reserved.
//



#import "WLKeyChain.h"

@implementation WLKeyChain

+(NSMutableDictionary *)getKeyChainQuery:(NSString *)service {
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,service,(__bridge id)kSecAttrDescription,service,(__bridge id)kSecAttrAccount,(__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible, nil];
}

+(void)saveObject:(id)data forServiceKey:(NSString *)service {
    
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+(id)loadServiceForKey:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData);
    if (status == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
            NSLog(@"%@",ret);
        } @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", service, exception);
        } @finally {
            NSLog(@"finally+++++++++++++++++++");
        }
    } else {
        NSLog(@"keychain error  “service:%@ = %d”", service, (int)status);//目前遇到获取失败的error=-25300,原因未知。怀疑为从Keychain获取数据过于频繁，统一在systemManger里面获取一次.在即将进入后台时，统一存储到keychain
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+(void)deleteServiceForKey:(NSString *)service {
    
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

#pragma mark - 从Keychain中获取用户信息
/**
 *  获取用户数据
 **/
+ (NSString *)loadUserInfoForKey:(NSString *)key
{
    NSDictionary *tmp = [WLKeyChain loadServiceForKey:KEY_USERNAME_URL_LTK];
    return tmp[key];
}

@end
