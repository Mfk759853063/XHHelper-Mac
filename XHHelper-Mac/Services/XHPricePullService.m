//
//  XHPricePullService.m
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "XHPricePullService.h"

@interface XHPricePullService ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation XHPricePullService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeLoop = 2;
    }
    return self;
}

- (void)startService {
    // 创建
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeLoop
                                                    target:self
                                                selector:@selector(fetchData:)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)stopService{
    [self.timer invalidate];
}

- (void)fetchData:(NSTimer *)timer {
    [[XHNetworkManager sharedInstance] POST:@"/getapi.php" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XHPriceModel *priceModel = [XHPriceModel mj_objectWithKeyValues:responseObject];
        self.fetchDataCallback?self.fetchDataCallback(priceModel,nil):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.fetchDataCallback?self.fetchDataCallback(nil,error):nil;
    }];
}



@end
