//
//  XHNetworkManager.h
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface XHNetworkManager : AFHTTPSessionManager

+ (instancetype )sharedInstance;

@end
