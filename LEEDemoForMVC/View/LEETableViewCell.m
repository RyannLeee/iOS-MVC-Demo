//
//  LEETableViewCell.m
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import "LEETableViewCell.h"

@implementation LEETableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutView];
    }
    return self;
}

- (void)layoutView {
    
    // titleLabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 45)];
    titleLabel.font = [UIFont systemFontOfSize:autoScaleF(17)];
    titleLabel.textColor = LEEHexColor(0x333333, 1.0);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    // imgV
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(LEESWidth - autoScaleH(50), 9, 27, 27);
    [self.contentView addSubview:imgView];
    _imgView = imgView;
}

- (void)setModel:(LEECellModel *)model {
    UIImage *image;
    if (model.imgName.length > 0) {
        image = [UIImage imageNamed:model.imgName];
    }
    _imgView.image = image;
    
    _titleLabel.text = model.title;
}

@end
