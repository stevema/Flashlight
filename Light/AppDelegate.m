//
//  AppDelegate.m
//  Light
//
//  Created by Steve on 11/1/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate
{
    BOOL torchIsOn;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //    self.window.rootViewController = self.viewController;
    self.window.backgroundColor = [UIColor blackColor];
	// Do any additional setup after loading the view, typically from a nib.
    _lightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
    _lightView.image = [UIImage imageNamed:@"nomorl"];
    torchIsOn = NO;
    [self Touch:self];
    _lightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Touch:)];
    [_lightView addGestureRecognizer:tap];
    [self.window addSubview:_lightView];
    [self.window makeKeyAndVisible];
    return YES;
}

- (IBAction)Touch:(id)sender {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!torchIsOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                _lightView.image = [UIImage imageNamed:@"selected"];
                torchIsOn = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                _lightView.image = [UIImage imageNamed:@"nomorl"];
                torchIsOn = NO;
            }
            [device unlockForConfiguration];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    torchIsOn = NO;
    [self Touch:self];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
