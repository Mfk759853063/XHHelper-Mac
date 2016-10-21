//
//  XHNetworkManager.m
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "XHNetworkManager.h"

@implementation XHNetworkManager

+ (instancetype)sharedInstance {
    static XHNetworkManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XHNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://wp.bsbce.com/"]];
        [_sharedClient.requestSerializer setTimeoutInterval:60.0f];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet
                                                                   setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
        
        
    });
    
    return _sharedClient;
}

@end
