//
//  CYStarView.h
//  CYStarView
//
//  Created by 李长友 on 2017/3/27.
//  Copyright © 2017年 李长友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYStarView : UIView

/** 完成后执行的block */
@property (copy, nonatomic) void(^completionBlock)(NSInteger);
/** 是否可以点击 */
@property (assign, nonatomic) BOOL clickable;
/** 星星个数 */
@property (assign, nonatomic) NSInteger numberOfStars;
/** 星星边长 */
@property (assign, nonatomic) CGFloat lengthOfSide;
/** 评价值 */
@property (assign, nonatomic) NSInteger currentValue;

/**
 *  初始化方法
 *
 *  param numberOfStars 星星个数
 *  param lengthOfSide 星星边长
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSUInteger)numberOfStars lengthOfSide:(CGFloat)lengthOfSide;

@end
