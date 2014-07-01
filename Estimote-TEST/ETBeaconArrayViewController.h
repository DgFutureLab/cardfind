//
//  ETBeaconArrayViewController.h
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/26.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>
#import <ESTBeacon.h>

typedef enum : int
{
    ESTScanTypeBlueTooth,
    ESTScanTypeBeacon
} ESTScanType;

@interface ETBeaconArrayViewController : UIViewController

@property (strong, nonatomic) void (^completion)(ESTBeacon *);
@property (assign, nonatomic) ESTScanType scanType;

@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) ESTBeaconRegion *region;
@property (strong, nonatomic) NSArray *beaconsArray;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) NSArray *labelArray;

@property (strong, nonatomic) IBOutlet UIImageView *imgView1;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;
@property (strong, nonatomic) IBOutlet UIImageView *imgView3;
@property (strong, nonatomic) IBOutlet UIImageView *imgView4;
@property (strong, nonatomic) NSArray *imgViewArray;

@property (strong, nonatomic) NSDictionary *beaconMajorDict;

- (IBAction)hiddenButton1Pressed:(UIButton *)sender;
- (IBAction)hiddenButton2Pressed:(UIButton *)sender;
- (IBAction)hiddenButton3Pressed:(UIButton *)sender;
- (IBAction)hiddenButton4Pressed:(UIButton *)sender;

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion;

@end
