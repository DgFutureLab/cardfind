//
//  ETBeaconDetailViewController.m
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/26.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "ETBeaconDetailViewController.h"
#import <ESTBeaconManager.h>

@interface ETBeaconDetailViewController () <ESTBeaconManagerDelegate>

@end

@implementation ETBeaconDetailViewController

- (id)initWithBeacon:(ESTBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view reloadInputViews];
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"EstimoteSampleRegion"];
    //self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID major:[self.beacon.major unsignedIntegerValue] minor:[self.beacon.minor unsignedIntegerValue] identifier:@"RegionIdentifier"];

    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion];
    
    self.beaconDotImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width /2)-25.0, self.view.frame.size.height /2, 50.0, 50.0)];
    self.beaconDotImageView.image = [UIImage imageNamed:@"yellowlight.png"];
    [self.view addSubview:self.beaconDotImageView];
    [self blinkAnimation:@"blinkAnimation" finished:YES target:self.beaconDotImageView];

    self.beaconMinorDict = [[NSDictionary alloc]
                            initWithObjects:@[[UIImage imageNamed:@"chrono.png"], [UIImage imageNamed:@"lucca.gif"], [UIImage imageNamed:@"marle.png"], [UIImage imageNamed:@"magus.gif"], [UIImage imageNamed:@"chrono.png"], [UIImage imageNamed:@"magus.gif"], [UIImage imageNamed:@"magus.gif"]] forKeys:@[@"63236", @"29190", @"14135", @"1639", @"-2300", @"-29738", @"35798"]];
    self.iconImageView.image = self.beaconMinorDict[[self.beacon.minor stringValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    for (int i = 0; i < [beacons count]; i++) {
        ESTBeacon *thisBeacon = [[ESTBeacon alloc] init];
        thisBeacon = beacons[i];
        if ([thisBeacon.minor integerValue] == [self.beacon.minor integerValue]) {
            float distanceFloatValue = [thisBeacon.distance floatValue];
            float distanceValueForView = 430 - (200 * distanceFloatValue);
            if ( distanceValueForView < 0){
                distanceValueForView = 20;
            }
            self.distanceLabel.text = [NSString stringWithFormat:@"%.02f", distanceFloatValue];
            [self.beaconDotImageView setFrame:CGRectMake((self.view.frame.size.width / 2)-25.0, distanceValueForView, 50.0, 50.0)];
        }
    }
}

-(void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
}

-(void)pushInfoToView:(NSString *) distanceString
{
    self.distanceLabel.text = distanceString;
}

- (void)blinkAnimation:(NSString *)animationId finished:(BOOL)finished target:(UIView *)target
{
    [UIView beginAnimations:animationId context:(__bridge void *)(target)];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
    if ([target alpha] == 1.0f) {
        [target setAlpha:0.0f];
    }
    else {
        [target setAlpha:1.0f];
    }
    [UIView commitAnimations];
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
