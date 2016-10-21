//
//  HZBaseHttpService.h
//  HZDLHuiXianXia
//
//  Created by hzdlapple2 on 15/10/24.
//  Copyright (c) 2015年 hzdlapple2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "XHNetworkManager.h"

// 接口错误的描述,使用于error.userInfo[KNInterfaceErrorDescription]
extern const NSString *ICInterfaceErrorDescription;
// 接口错误的代码,使用于error.userInfo[KNInterfaceErrorCodeDescription]
extern const NSString *ICInterfaceErrorCodeDescription;
// 如果错误代码等于KNInterfaceErrorCode说明是接口错误
extern const NSInteger ICInterfaceErrorCode;

@interface ICBaseHttpService : NSObject

+ (NSError *)haveError:(id)response;


@end
