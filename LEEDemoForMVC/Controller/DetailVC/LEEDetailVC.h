//
//  LEEDetailVC.h
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEEDetailVC : LEEBaseViewController
@property (nonatomic, copy) NSString *imgURL; //image的URL字符串
@property (nonatomic, copy) NSString *imgKey; //SDWebImage对image进行缓存所需的key
@property (nonatomic, copy) NSString *imgName; //加载本地大图的图片名称
@end

NS_ASSUME_NONNULL_END
