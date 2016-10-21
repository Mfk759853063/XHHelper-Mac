//
//  ViewController.h
//  XHHelper-Mac
//
//  Created by vbn on 16/10/20.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak, nonatomic) IBOutlet NSTextField *oilCurrentPriceLabel;

@property (weak, nonatomic) IBOutlet NSTextField *agCurrentPriceLabel;

@property (weak, nonatomic) IBOutlet NSTextField *oilTargetTextField;

@property (weak, nonatomic) IBOutlet NSTextField *agTargetTextField;

@property (weak) IBOutlet NSButton *oilEnableButton;

@property (weak) IBOutlet NSButton *agEnableButton;

- (IBAction)oilCheckAction:(id)sender;

- (IBAction)agCheckAction:(id)sender;

@end

