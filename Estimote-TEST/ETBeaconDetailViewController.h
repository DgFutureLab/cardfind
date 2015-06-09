//
//  ETBeaconDetailViewController.h
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/26.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>
#import <ESTBeacon.h>
#import "ETBeaconArrayViewController.h"

@interface ETBeaconDetailViewController : UIViewController

@property (strong, nonatomic) void (^completion)(ESTBeacon *);
@property (assign, nonatomic) ESTScanType scanType;

@property (strong, nonatomic) ESTBeacon *beacon;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) ESTBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSArray *beaconsArray;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) NSDictionary *beaconMinorDict;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) UIImageView *beaconDotImageView;
@property (nonatomic) BOOL beaconFlashing;

- (IBAction)backButtonPressed:(UIButton *)sender;

- (id)initWithBeacon:(ESTBeacon *)beacon;

@end
