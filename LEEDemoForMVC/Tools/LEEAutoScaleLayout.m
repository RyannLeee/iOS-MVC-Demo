//
//  LEEAutoScaleLayout.m
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/25.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#define LEEWidth [UIScreen mainScreen].bounds.size.width
#define LEEHeight [UIScreen mainScreen].bounds.size.height

#import "LEEAutoScaleLayout.h"

@interface LEEAutoScaleLayout ()

/** 当前设计界面的机型 */
@property (nonatomic, assign) LEEScreenBasic basic;
/** 水平放大系数 */
@property (nonatomic, assign) CGFloat scaleH;
/** 垂直放大系数 */
@property (nonatomic, assign) CGFloat scaleV;
/** 文字放大系数 */
@property (nonatomic, assign) CGFloat scaleF;

@end

@implementation LEEAutoScaleLayout

static LEEAutoScaleLayout *shareInstance;
+ (LEEAutoScaleLayout *)shareInstanceWithBasic:(LEEScreenBasic)basic {
    @synchronized (shareInstance) {
        if (shareInstance == nil) {
            shareInstance = [[LEEAutoScaleLayout alloc] init];
            shareInstance.basic = basic;
            [shareInstance setScaleValue];
        }
    }
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (shareInstance) {
        if (shareInstance == nil) {
            shareInstance = [super allocWithZone:zone];
        }
    }
    return shareInstance;
}

+ (CGFloat)autoScaleH:(CGFloat)h {
    return h*shareInstance.scaleH;
}

+ (CGFloat)autoScaleV:(CGFloat)v {
    return v*shareInstance.scaleV;
}

+ (CGFloat)autoScaleFont:(CGFloat)f {
    return f*shareInstance.scaleF;
}

- (void)setScaleValue {
    CGFloat basicW = 320;
    CGFloat basicH = 568;
    shareInstance.scaleF = 1.0;
    switch (shareInstance.basic) {
        case LEEIPhone320_568:{
            basicW = 320;
            basicH = 568;
            break;
        }
        case LEEIPhone375_667:{
            basicW = 375;
            basicH = 667;
            break;
        }
        case LEEIPhone414_736:{
            basicW = 414;
            basicH = 736;
            break;
        }
        case LEEIPhone375_812: {
            basicW = 375;
            basicH = 812;
            break;
        }
        case LEEIPhone414_896: {
            basicW = 414;
            basicH = 896;
            break;
        }
        case LEEIPad768_1024: {
            basicW = 768;
            basicH = 1024;
            break;
        }
        case LEEIPad1024_1366: {
            basicW = 1024;
            basicH = 1366;
            break;
        }
    }
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait
        || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        // 正向或倒立
        shareInstance.scaleF = LEEWidth/basicW;
        shareInstance.scaleH = LEEWidth/basicW;
        shareInstance.scaleV = LEEHeight/basicH;
    }else {
        // 左转或右转
        shareInstance.scaleF = LEEWidth/basicH;
        shareInstance.scaleH = LEEWidth/basicH;
        shareInstance.scaleV = LEEHeight/basicW;
    }
}
@end
