//
//  LEEBaseViewController.m
//  LEEDemoForMVC
//
//  Created by yuanlee on 2019/9/7.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import "LEEBaseViewController.h"

@interface LEEBaseViewController ()

@end

@implementation LEEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hud = [[MBProgressHUD alloc] init];
    self.hud.removeFromSuperViewOnHide = YES;
    
    self.navigationController.navigationBar.barTintColor = LEEHexColor(0x98CB00, 1.0);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:17]}];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navigate_back_white"] forState:UIControlStateNormal]; //navigate_back
    [button sizeToFit];
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)showHud {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hidHud {
    [self.hud hideAnimated:YES];
}

- (void)showHudInWindow {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    self.hud = hud;
}

- (void)showHudWithText:(NSString *)text {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.label.text = text;
}

- (void)showHudInWindowWithText:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.label.text = text;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.3f];
    self.hud = hud;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
//    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigate_back"] style:UIBarButtonItemStylePlain target:target action:action];
//    //return [[UIBarButtonItem alloc] initWithTitle:@"bbback" style:UIBarButtonItemStylePlain target:target action:action];
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.navigationBar.translucent = YES;
//
//    //    UIColor *fTextColor = [UIColor blackColor];
//    // 自定义导航
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    appearance.barTintColor = [UIColor whiteColor];
//    //    [appearance setBackgroundImage:[UIImage imageNamed:@"icon_topbar_64"]
//    //                     forBarMetrics:UIBarMetricsDefault];
//    //    [appearance setShadowImage:[UIImage new]];
//
//
//    //    NSDictionary *attributeName = @{NSForegroundColorAttributeName : fTextColor,
//    //                                    NSFontAttributeName : SYSTEMFONT(19)};
//    NSDictionary *attributeName = @{NSForegroundColorAttributeName:[UIColor blackColor],
//                                    NSFontAttributeName : [UIFont systemFontOfSize:autoScaleF(18)]};
//    // 3.标题
//    [appearance setTitleTextAttributes:attributeName];
//    [appearance setTintColor:LEEHexColor(0x484848, 1.0)];
//
//    //self.interactivePopGestureRecognizer.delegate = (id)self;
//    self.interactivePopGestureRecognizer.enabled = YES;
//}
//
///*
// + (void)initialize
// {
// [BMLNavigationController setAppearanceBar];
// }
// */
//
//- (void)popUpCovtroller
//{
//    [self popViewControllerAnimated:YES];
//}
//
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    UIViewController *returnController = [super popViewControllerAnimated:animated];
//    return returnController;
//}
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//    if (self.childViewControllers.count) {
//        viewController.hidesBottomBarWhenPushed = YES;
//        UIButton *letfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
//        [letfButton setImage:[UIImage imageNamed:@"navigate_back"] forState:UIControlStateNormal];
//
//        [letfButton addTarget:self action:@selector(popUpCovtroller) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:letfButton];
//        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
//    }
//    [super pushViewController:viewController animated:animated];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
