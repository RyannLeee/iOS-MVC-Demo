//
//  LEETableViewCell.h
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEECellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LEETableViewCell : UITableViewCell
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *titleLabel;

/**
 界面布局
 */
- (void)layoutView;

/**
 设置模型
 */
- (void)setModel:(LEECellModel *)model;

@end

NS_ASSUME_NONNULL_END
