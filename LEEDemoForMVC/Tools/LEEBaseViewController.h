//
//  LEEBaseViewController.h
//  LEEDemoForMVC
//
//  Created by yuanlee on 2019/9/7.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import <RTRootNavigationController/RTRootNavigationController.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEEBaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *hud;

- (void)showHud;
- (void)showHudInWindow;
- (void)showHudWithText:(NSString *)text;
- (void)showHudInWindowWithText:(NSString *)text;

- (void)hidHud;

@end

NS_ASSUME_NONNULL_END
