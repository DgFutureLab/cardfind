//
//  ETViewController.h
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/18.
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

@interface ETViewController : UIViewController

@property (nonatomic, copy) void (^completion)(ESTBeacon *);
@property (nonatomic, assign) ESTScanType scanType;

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (strong, nonatomic) NSArray *beaconsArray;

@property (strong, nonatomic) IBOutlet UIImageView *card1;
@property (strong, nonatomic) IBOutlet UIImageView *card2;
@property (strong, nonatomic) IBOutlet UIImageView *card3;
@property (strong, nonatomic) IBOutlet UIImageView *card4;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (strong, nonatomic) IBOutlet UILabel *major1;
@property (strong, nonatomic) IBOutlet UILabel *minor1;
@property (strong, nonatomic) IBOutlet UILabel *dist1;
@property (strong, nonatomic) IBOutlet UILabel *major2;
@property (strong, nonatomic) IBOutlet UILabel *minor2;
@property (strong, nonatomic) IBOutlet UILabel *dist2;
@property (strong, nonatomic) IBOutlet UILabel *major3;
@property (strong, nonatomic) IBOutlet UILabel *minor3;
@property (strong, nonatomic) IBOutlet UILabel *dist3;
@property (strong, nonatomic) IBOutlet UILabel *major4;
@property (strong, nonatomic) IBOutlet UILabel *minor4;
@property (strong, nonatomic) IBOutlet UILabel *dist4;

@property (strong, nonatomic) NSArray *majorArray;
@property (strong, nonatomic) NSArray *minorArray;
@property (strong, nonatomic) NSArray *distArray;
@property (strong, nonatomic) NSMutableArray *cardStatus;

@property (strong, nonatomic) NSMutableDictionary *existingBeacons;

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion;

@end
