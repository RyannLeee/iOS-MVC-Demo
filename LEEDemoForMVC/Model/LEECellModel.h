//
//  LEECellModel.h
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEECellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgName;

- (instancetype)initWithTitle:(NSString *)title
                      imgName:(NSString *)imgName;
@end

NS_ASSUME_NONNULL_END
