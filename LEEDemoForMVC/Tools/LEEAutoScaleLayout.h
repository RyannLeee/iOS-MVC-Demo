//
//  LEEAutoScaleLayout.h
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/25.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define autoScaleH(h) [LEEAutoScaleLayout autoScaleH:h] // 水平
#define autoScaleV(v) [LEEAutoScaleLayout autoScaleV:v] // 垂直
#define autoScaleF(f) [LEEAutoScaleLayout autoScaleFont:f]
#define LEECGRectMake(x, y, w, h) CGRectMake(autoScaleH(x), autoScaleV(y), autoScaleH(w), autoScaleV(h))
#define LEECGPoint(x, y) CGPoint(autoScaleW(x), autoScaleH(y))

NS_ASSUME_NONNULL_BEGIN

// UI 设计基于的屏幕宽高点
typedef enum {
    LEEIPhone320_568,
    LEEIPhone375_667,
    LEEIPhone414_736,
    LEEIPhone375_812,
    LEEIPhone414_896,
    LEEIPad768_1024,
    LEEIPad1024_1366,
}LEEScreenBasic;

@interface LEEAutoScaleLayout : NSObject

/** 水平放大系数 */
@property (nonatomic, assign, readonly) CGFloat scaleH;
/** 垂直放大系数 */
@property (nonatomic, assign, readonly) CGFloat scaleV;
/** 文字放大系数 */
@property (nonatomic, assign, readonly) CGFloat scaleF;

/**
 单例
 @pragma basic: 当前基于什么机型设计界面
 */
+ (LEEAutoScaleLayout *)shareInstanceWithBasic:(LEEScreenBasic)basic;

/**
 适配后水平与垂直缩放值
 */
+ (CGFloat)autoScaleH:(CGFloat)h;
+ (CGFloat)autoScaleV:(CGFloat)v;
/**
 适配后文字缩放值
 */
+ (CGFloat)autoScaleFont:(CGFloat)f;

@end

NS_ASSUME_NONNULL_END

