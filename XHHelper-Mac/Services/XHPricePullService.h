//
//  XHPricePullService.h
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "ICBaseHttpService.h"
#import "XHPriceModel.h"

typedef void(^FetchDataCallback)(id object,NSError *error);

@interface XHPricePullService : ICBaseHttpService

// default is 2
@property (assign, nonatomic) NSInteger timeLoop;

@property (copy, nonatomic) FetchDataCallback fetchDataCallback;

- (void)startService;

- (void)stopService;

@end
