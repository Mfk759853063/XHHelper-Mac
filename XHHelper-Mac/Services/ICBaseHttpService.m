//
//  HZBaseHttpService.m
//  HZDLHuiXianXia
//
//  Created by hzdlapple2 on 15/10/24.
//  Copyright (c) 2015年 hzdlapple2. All rights reserved.
//

#import "ICBaseHttpService.h"

const NSString *ICInterfaceErrorDescription = @"interfaceErrorKey";
const NSString *ICInterfaceErrorCodeDescription = @"interfaceErrorCode";
const NSInteger ICInterfaceErrorCode = 1024;


@implementation ICBaseHttpService

+ (NSError *)haveError:(id)response {
    NSDictionary *result=(id)response;
    NSInteger state=[[result objectForKey:@"state"] integerValue];
    if (state == 0) {
        return nil;
    } else {
        return [[self class] generateErrorWithCode:state];
    }
}

+ (NSError *)generateErrorWithCode:(NSInteger)code {
    NSDictionary *userInfo = @{ICInterfaceErrorDescription:@"接口错误",
                               ICInterfaceErrorCodeDescription:@(code)};
    
    NSLog(@"%@",userInfo);
    return [NSError errorWithDomain:@"domain" code:ICInterfaceErrorCode userInfo:userInfo];
}

@end
