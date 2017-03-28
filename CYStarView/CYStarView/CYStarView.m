//
//  CYStarView.m
//  CYStarView
//
//  Created by 李长友 on 2017/3/27.
//  Copyright © 2017年 李长友. All rights reserved.
//

#import "CYStarView.h"

@interface CYStarView ()

/** 星星间隔 */
@property (assign, nonatomic) CGFloat spacing;

@end


@implementation CYStarView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:5 lengthOfSide:frame.size.width / self.numberOfStars];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.numberOfStars = 5;
        self.lengthOfSide = self.frame.size.width / self.numberOfStars;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSUInteger)numberOfStars lengthOfSide:(CGFloat)lengthOfSide {
    if (self = [super initWithFrame:frame]) {
        self.numberOfStars = numberOfStars;
        self.lengthOfSide = lengthOfSide;
    }
    return self;
}

#pragma mark - setter
- (void)setClickable:(BOOL)clickable {
    
    _clickable = clickable;
    self.userInteractionEnabled = _clickable;
}

- (void)setLengthOfSide:(CGFloat)lengthOfSide {
    
    // 超过控件高度
    if (lengthOfSide > self.frame.size.height) {
        lengthOfSide = self.frame.size.height;
    }
    
    // 超过控件宽度
    if (lengthOfSide > self.frame.size.width / _numberOfStars) {
        lengthOfSide = self.frame.size.width / _numberOfStars;
    }
    
    _lengthOfSide = lengthOfSide;
    _spacing = (self.frame.size.width - lengthOfSide * _numberOfStars) / _numberOfStars;
    
    [self setNeedsDisplay];
}

- (void)setNumberOfStars:(NSInteger)numberOfStars {
    
    if (numberOfStars <= 0) {
        numberOfStars = 5;
    }
    
    _numberOfStars = numberOfStars;
    self.lengthOfSide = self.lengthOfSide;
    
    [self setNeedsDisplay];
}

#pragma mark - drawRect
- (void)drawRect:(CGRect)rect {
    
    UIImage *lightImage = [UIImage imageNamed:@"star_light"];
    UIImage *darkImage = [UIImage imageNamed:@"star_dark"];
    
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < self.numberOfStars; i ++) {
        // 根据 currentValue 选择是画亮的还是暗的星星
        UIImage *image = i >= self.currentValue ? darkImage : lightImage;
        CGRect imageRect = CGRectMake(self.spacing / 2 + (self.lengthOfSide + self.spacing) * i, (self.frame.size.height - self.lengthOfSide) / 2, self.lengthOfSide, self.lengthOfSide);
        
        CGContextSaveGState(context);
        
        // 坐标系Y轴是相反的，进行翻转
        CGContextScaleCTM(context, 1.0, - 1.0);
        CGContextTranslateCTM(context, 0, - rect.origin.y * 2 - rect.size.height);
        
        CGContextDrawImage(context, imageRect, image.CGImage);
        CGContextRestoreGState(context);
    }
}

#pragma mark - touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGFloat x = [touch locationInView:self].x;
    self.currentValue = x / (self.frame.size.width / self.numberOfStars) + 1;
    
    [self setNeedsDisplay];
    
    if (self.completionBlock) {
        self.completionBlock(self.currentValue);
    }
}

@end
