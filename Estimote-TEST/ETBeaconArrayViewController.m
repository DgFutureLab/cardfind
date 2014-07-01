//
//  ETBeaconArrayViewController.m
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/26.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "ETBeaconArrayViewController.h"
#import "ETBeaconDetailViewController.h"

@interface ETBeaconArrayViewController () <ESTBeaconManagerDelegate>

@end

@implementation ETBeaconArrayViewController

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion
{
    self = [super init];
    if (self) {
        self.scanType = scanType;
        self.completion = [completion copy];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"EstimoteSampleRegion"];
    
    [self.beaconManager startRangingBeaconsInRegion:self.region];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.region];
    
    self.beaconMajorDict = [[NSDictionary alloc]
                            initWithObjects:@[[UIImage imageNamed:@"chrono.png"], [UIImage imageNamed:@"lucca.gif"], [UIImage imageNamed:@"marle.png"], [UIImage imageNamed:@"magus.gif"]]
                            forKeys:@[@"41374", @"26751", @"20826", @"1639"]];
    
    self.labelArray   = @[self.label1, self.label2, self.label3, self.label4];
    self.imgViewArray = @[self.imgView1, self.imgView2, self.imgView3, self.imgView4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    NSLog(@"%@", segue.identifier);
    if ([segue.destinationViewController isKindOfClass:[ETBeaconDetailViewController class]]) {
        ETBeaconDetailViewController *targetViewController = segue.destinationViewController;
        ESTBeacon *selectedBeacon = [[ESTBeacon alloc] init];
        if ([segue.identifier isEqualToString:@"segue1"])
        {
            selectedBeacon = self.beaconsArray[0];
        }
        else if ([segue.identifier isEqualToString:@"segue2"])
        {
            selectedBeacon = self.beaconsArray[1];
        }
        else if ([segue.identifier isEqualToString:@"segue3"])
        {
            selectedBeacon = self.beaconsArray[2];
        }
        else if ([segue.identifier isEqualToString:@"segue4"])
        {
            selectedBeacon = self.beaconsArray[3];
        }
        
        targetViewController.beacon = selectedBeacon;
    }
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    [self pushBeaconInfoToView];
}

-(void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    [self pushBeaconInfoToView];
}

- (void)pushBeaconInfoToView
{
    for (int i = 0; i < self.beaconsArray.count; i++) {
        NSNumber *beaconDist = ((ESTBeacon *) self.beaconsArray[i]).distance;
        if ((beaconDist) && (![[beaconDist stringValue] isEqualToString:@"-1"])) {
            ((UILabel *) self.labelArray[i]).text = [NSString stringWithFormat:@"%.02f", [beaconDist floatValue]];
        }
        NSString *major = [((ESTBeacon *) self.beaconsArray[i]).major stringValue];
        ((UIImageView *) self.imgViewArray[i]).image = (UIImage *) self.beaconMajorDict[major];
    }
}

- (IBAction)hiddenButton1Pressed:(UIButton *)sender
{}

- (IBAction)hiddenButton2Pressed:(UIButton *)sender
{}

- (IBAction)hiddenButton3Pressed:(UIButton *)sender
{}

- (IBAction)hiddenButton4Pressed:(UIButton *)sender
{}

@end
