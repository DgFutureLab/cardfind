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

-(void)viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
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
    
    self.beaconMinorDict = [[NSDictionary alloc]
                            initWithObjects:@[[UIImage imageNamed:@"chrono.png"], [UIImage imageNamed:@"lucca.gif"], [UIImage imageNamed:@"marle.png"], [UIImage imageNamed:@"magus.gif"], [UIImage imageNamed:@"chrono.png"], [UIImage imageNamed:@"magus.gif"], [UIImage imageNamed:@"magus.gif"]]
                            forKeys:@[@"63236", @"29190", @"14135", @"1639", @"-2300", @"-29738", @"35798"]];
    
    self.labelArray   = @[self.label1, self.label2, self.label3, self.label4];
    self.imgViewArray = @[self.imgView1, self.imgView2, self.imgView3, self.imgView4];
    NSLog(@"%@", self.beaconsArray);
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

    if ([segue.destinationViewController isKindOfClass:[ETBeaconDetailViewController class]]) {
        ETBeaconDetailViewController *destinationVC = segue.destinationViewController;
        
        if ([segue.identifier isEqualToString:@"buttonSegue1"])
        {
            destinationVC.beacon = self.beaconsArray[0];
        }
        else if ([segue.identifier isEqualToString:@"buttonSegue2"])
        {
            destinationVC.beacon = self.beaconsArray[1];
        }
        else if ([segue.identifier isEqualToString:@"buttonSegue3"])
        {
            destinationVC.beacon = self.beaconsArray[2];
        }
        else if ([segue.identifier isEqualToString:@"buttonSegue4"])
        {
            destinationVC.beacon = self.beaconsArray[3];
        }
    }
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
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
        //((UILabel *) self.labelArray[i]).text = [NSString stringWithFormat:@"%@", [((ESTBeacon *) self.beaconsArray[i]).minor stringValue]];
        if ((beaconDist) && (![[beaconDist stringValue] isEqualToString:@"-1"])) {
            ((UILabel *) self.labelArray[i]).text = [NSString stringWithFormat:@"%.02f", [beaconDist floatValue]];
            NSString *minor = [((ESTBeacon *) self.beaconsArray[i]).minor stringValue];
            ((UIImageView *) self.imgViewArray[i]).image = (UIImage *) self.beaconMinorDict[minor];
        }
    }
}

- (IBAction)hiddenButton1Pressed:(UIButton *)sender
{
}

- (IBAction)hiddenButton2Pressed:(UIButton *)sender
{
}

- (IBAction)hiddenButton3Pressed:(UIButton *)sender
{
}

- (IBAction)hiddenButton4Pressed:(UIButton *)sender
{
}

@end
