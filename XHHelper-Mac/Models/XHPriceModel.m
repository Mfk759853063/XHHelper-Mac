//
//  XHPriceModel.m
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "XHPriceModel.h"

@implementation XHPriceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"oilPrice":@[@"oil_price"],
             @"oldOilPrice":@[@"last_oil_price"],
             @"agPrice":@[@"ag_price"],
             @"oldAgPrice":@[@"last_ag_price"]};
}

- (NSColor *)getCurrentAgColor {
    if (self.agPrice < self.oldAgPrice ) {
        return [NSColor greenColor];
    } else if (self.agPrice > self.oldAgPrice ) {
        return [NSColor redColor];
    }
    return [NSColor redColor];
}

- (NSColor *)getCurrentOilColor {
    if (self.oilPrice < self.oldOilPrice ) {
        return [NSColor greenColor];
    } else if (self.oilPrice > self.oldOilPrice ) {
        return [NSColor redColor];
    }
    return [NSColor redColor];
}


@end
