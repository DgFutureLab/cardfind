//
//  ETViewController.m
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/18.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "ETViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface ETViewController () <ESTBeaconManagerDelegate>

@end

@implementation ETViewController

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion
{
    self = [super init];
    if (self) {
        self.scanType = scanType;
        self.completion = [completion copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"EstimoteSampleRegion"];
    
    [self.beaconManager startRangingBeaconsInRegion:self.region];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.region];
    
    self.majorArray = @[self.major1, self.major2, self.major3, self.major4];
    self.minorArray = @[self.minor1, self.minor2, self.minor3, self.minor4];
    self.distArray  = @[self.dist1, self.dist2, self.dist3, self.dist4];
    
    [self.existingBeacons setObject:@"-2300" forKey:@"-24162"];
    [self.existingBeacons setObject:@"29190" forKey:@"26751"];
    [self.existingBeacons setObject:@"14135" forKey:@"20826"];
    [self.existingBeacons setObject:@"-29738" forKey:@"1639"];
    
    self.cardStatus = [[NSMutableArray alloc] initWithObjects:@"no", @"no", @"no", @"no", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    [self pushBeaconInfo];
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    [self pushBeaconInfo];
}

- (void)pushBeaconInfo
{
    for (int i = 0; i < self.beaconsArray.count; i++) {
        NSString *beaconMajorString = [((ESTBeacon *) self.beaconsArray[i]).major stringValue];
        NSString *beaconMinorString = [((ESTBeacon *) self.beaconsArray[i]).minor stringValue];
        
        NSNumber *beacondist = ((ESTBeacon *) self.beaconsArray[i]).distance;

        // Beacon Major
        ((UILabel *) self.majorArray[i]).text = beaconMajorString;
        
        // Beacon Minor
        ((UILabel *) self.minorArray[i]).text = beaconMinorString;
        
        // Beacon Distance
        if ( (beacondist) && (![[beacondist stringValue] isEqualToString: @"-1"]) ) {
            ((UILabel *) self.distArray[i]).text = [NSString stringWithFormat:@"%.02f", [beacondist floatValue]];
            if ([beacondist floatValue] < 2.0) {
                ((UILabel *) self.distArray[i]).backgroundColor = [UIColor colorWithRed:(2.0 - [beacondist floatValue])/2.0 green:0.0 blue:[beacondist floatValue]/2.0 alpha:1.0];
            }
        }
        
        if ((beacondist) && ([beacondist floatValue] < 0.5) && (![[beacondist stringValue] isEqualToString:@"-1"])) {
        
            // Flip card if estimote exists
            if (([beaconMajorString isEqualToString:@"41374"]) && ([self.cardStatus[0] isEqualToString:@"no"])) {
                // Card 1
                [UIView transitionWithView:self.card1 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{self.card1.image = [UIImage imageNamed:@"chrono.png"];} completion:nil];
                self.messageLabel.text = @"You found Chrono!";
                self.cardStatus[0] = @"yes";
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
                
            if (([beaconMajorString isEqualToString:@"26751"]) && ([self.cardStatus[1] isEqualToString:@"no"])) {
                // Card 2
                [UIView transitionWithView:self.card2 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{self.card2.image = [UIImage imageNamed:@"lucca.gif"];} completion:nil];
                self.messageLabel.text = @"You found Lucca!";
                self.cardStatus[1] = @"yes";
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            
            if (([beaconMajorString isEqualToString:@"20826"]) && ([self.cardStatus[2] isEqualToString:@"no"])) {
                // Card 3
                [UIView transitionWithView:self.card3 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{self.card3.image = [UIImage imageNamed:@"marle.png"];} completion:nil];
                self.messageLabel.text = @"You found Marle!";
                self.cardStatus[2] = @"yes";
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            
            if (([beaconMajorString isEqualToString:@"1639"]) && ([self.cardStatus[3] isEqualToString:@"no"])) {
                // Card 4
                [UIView transitionWithView:self.card4 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{self.card4.image = [UIImage imageNamed:@"magus.gif"];} completion:nil];
                self.messageLabel.text = @"You found Magus!";
                self.cardStatus[3] = @"yes";
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }
    }
}

@end
