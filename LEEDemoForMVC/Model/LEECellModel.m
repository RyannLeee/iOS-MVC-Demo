//
//  LEECellModel.m
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import "LEECellModel.h"

@implementation LEECellModel
- (instancetype)initWithTitle:(NSString *)title
                      imgName:(NSString *)imgName {
    if (self = [super init]) {
        _title = title;
        _imgName = imgName;
    }
    return self;
}
@end
