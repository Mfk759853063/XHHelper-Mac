//
//  ViewController.m
//  XHHelper-Mac
//
//  Created by vbn on 16/10/20.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "ViewController.h"
#import "XHPriceModel.h"
#import "XHPricePullService.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<XHPriceModel *> *priceList;

@property (strong, nonatomic) XHPriceModel *currentPrice;

@property (assign, nonatomic) BOOL oilCanNotification;

@property (assign, nonatomic) BOOL agCanNotification;
// 首页url
@property (strong, nonatomic) NSURL *indexUrl;

@property (strong, nonatomic) NSURL *loginUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setup];
}

- (void)setup {
    self.title = @"呦，你说我帅不帅";
    self.oilEnableButton.state = 0;
    self.agEnableButton.state = 0;
    self.priceList = @[].mutableCopy;

    self.loginUrl = [NSURL URLWithString:@"http://wp.bsbce.com/login_and.php?password=0c909a141f1f2c0a1cb602b0b2d7d050&mobile=35566543706&sign=440c3b774a8aac838022d8e4d59ce287"];
    self.indexUrl = [NSURL URLWithString:@"http://wp.bsbce.com/index.php"];
    
    XHPricePullService *service = [[XHPricePullService alloc] init];
    [service setFetchDataCallback:^(XHPriceModel *price,NSError *error) {
        if (!error) {
            self.currentPrice = price;
            CGFloat oilDiff = fabs(self.currentPrice.oilPrice - [self.oilTargetTextField.stringValue floatValue]);
            CGFloat agDiff = fabs(self.currentPrice.agPrice - [self.agTargetTextField.stringValue floatValue]);
            if (self.oilCanNotification && oilDiff <= 0.2) {
                NSString *message = [NSString stringWithFormat:@"油已到达目标点位%@",self.oilTargetTextField.stringValue];
                [self scheduleLocalNotificationWithMes:message];
                self.oilCanNotification = NO;
                self.oilTargetTextField.enabled = YES;
                self.oilEnableButton.state = 0;
            }
            if (self.agCanNotification && agDiff <= 0.002) {
                NSString *message = [NSString stringWithFormat:@"银已到达目标点位%@",self.agTargetTextField.stringValue];
                [self scheduleLocalNotificationWithMes:message];
                self.agCanNotification = NO;
                self.agTargetTextField.enabled = YES;
                self.agEnableButton.state = 0;
            }
            
            [self.priceList insertObject:price atIndex:0];
            if (self.priceList.count >= 99999) {
                [self.priceList removeLastObject];
            }
            [self renderUI];
        } else {
            
        }
    }];
    [service startService];
    [self loadWebViewWithRequest:self.loginUrl];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadWebViewWithRequest:self.indexUrl];
    });
    
}

- (void)renderUI {
    self.oilCurrentPriceLabel.stringValue = [NSString stringWithFormat:@"%.2f",self.currentPrice.oilPrice];
    NSColor *color = [self.currentPrice getCurrentOilColor];
    if (color) {
        self.oilCurrentPriceLabel.textColor = color;
    }
    
    self.agCurrentPriceLabel.stringValue = [NSString stringWithFormat:@"%.3f",self.currentPrice.agPrice];
    color = [self.currentPrice getCurrentAgColor];
    if (color) {
        self.agCurrentPriceLabel.textColor = color;
    }
}

- (void)loadWebViewWithRequest:(NSURL *)url {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView.mainFrame loadRequest:request];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)oilCheckAction:(NSButton *)sender {
    if (sender.state == 1 && [self.oilTargetTextField.stringValue floatValue] != 0) {
        self.oilCanNotification = YES;
    } else {
        self.oilCanNotification = NO;
        [self removeAllLocalNotifications];
    }
}

- (IBAction)agCheckAction:(NSButton *)sender {
    if (sender.state == 1 && [self.agTargetTextField.stringValue floatValue] != 0) {
        self.agCanNotification = YES;
    } else {
        self.agCanNotification = NO;
        [self removeAllLocalNotifications];
    }
}

- (void)scheduleLocalNotificationWithMes:(NSString *)mes {
    //Initalize new notification
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    //Set the title of the notification
    [notification setTitle:@"你说我到底帅不帅"];
    //Set the text of the notification
    [notification setInformativeText:mes];
    //Set the time and date on which the nofication will be deliverd (for example 20 secons later than the current date and time)
    [notification setDeliveryDate:[NSDate dateWithTimeInterval:2 sinceDate:[NSDate date]]];
    //Set the sound, this can be either nil for no sound, NSUserNotificationDefaultSoundName for the default sound (tri-tone) and a string of a .caf file that is in the bundle (filname and extension)
    [notification setSoundName:NSUserNotificationDefaultSoundName];
    
    //Get the default notification center
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    //Scheldule our NSUserNotification
    [center scheduleNotification:notification];
    
}

- (void)removeAllLocalNotifications {
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center.scheduledNotifications enumerateObjectsUsingBlock:^(NSUserNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [center removeScheduledNotification:obj];
    }];
}
@end
