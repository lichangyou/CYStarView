//
//  ViewController.m
//  CYStarView
//
//  Created by 李长友 on 2017/3/27.
//  Copyright © 2017年 李长友. All rights reserved.
//

#import "ViewController.h"
#import "CYStarView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CYStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.starView.completionBlock = ^(NSInteger currentValue) {
        self.showLabel.text = [NSString stringWithFormat:@"感谢您给我评了%zd分", currentValue];
    };
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    self.starView.clickable = sender.on;
}

- (IBAction)segControlValueChanged:(UISegmentedControl *)sender {
    self.starView.numberOfStars = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex].integerValue;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.starView.lengthOfSide = self.starView.frame.size.width / self.starView.numberOfStars * sender.value;
}

@end
