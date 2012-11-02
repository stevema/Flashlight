//
//  ViewController.m
//  Light
//
//  Created by Steve on 11/1/12.
//  Copyright (c) 2012 Steve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL torchIsOn;
}
@end

@implementation ViewController

@synthesize lightView = _lightView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.view.backgroundColor = [UIColor blackColor];
	// Do any additional setup after loading the view, typically from a nib.
    _lightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
    _lightView.image = [UIImage imageNamed:@"nomorl"];
    torchIsOn = NO;
    [self Touch:self];
    _lightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Touch:)];
    [_lightView addGestureRecognizer:tap];
    [self.view addSubview:_lightView];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    _lightView = nil;
}

@end
