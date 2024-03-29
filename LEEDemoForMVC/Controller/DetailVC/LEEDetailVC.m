//
//  LEEDetailVC.m
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#define LEEContentHeight (LEESHeight - StatusBarAndNavigationBarHeight - TabbarSafeBottomMargin)

#import "LEEDetailVC.h"
#import "LargeImageView.h"

@interface LEEDetailVC () <UIScrollViewDelegate>
{
    UIScrollView *scrollV;
    LargeImageView *imgV;
    UIView *errorV;
    UILabel *loadingLab;
    UIActivityIndicatorView *activityIndicatorView;
    CGFloat currentScale;
}
@end

@implementation LEEDetailVC

//static BOOL SDImageCacheOldShouldDecompressImages = YES;
//static BOOL SDImagedownloderOldShouldDecompressImages = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutView];
    
//    [[SDWebImageManager sharedManager].imageCache setMaxMemoryCost:30*1024*1024]; // 设置图片总缓存 30M 大小，默认为0没有限制
//    [[SDWebImageManager sharedManager].imageCache.config setMaxCacheSize:3*1024*1024]; // 设置单个图片限制 3M 大小
//    [[SDWebImageManager sharedManager].imageCache.config setMaxCacheAge:60*60*24]; // 设置缓存保留时间为 1 天
//
//    SDImageCache *canche = [SDImageCache sharedImageCache];
//    SDImageCacheOldShouldDecompressImages = canche.config.shouldDecompressImages;
//    canche.config.shouldDecompressImages = NO;
//
//    SDWebImageDownloader *sdDownloder = [SDWebImageDownloader sharedDownloader];
//    SDImagedownloderOldShouldDecompressImages = sdDownloder.shouldDecompressImages;
//    sdDownloder.shouldDecompressImages = NO;
    
}

- (void)didReceiveMemoryWarning {
    // 清除缓存
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeAll completion:nil];
    [[SDImageCache sharedImageCache] setValue:nil forKey:_imgKey];
}

#pragma mark -- UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imgV;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGRect frame = imgV.frame;
    frame.origin.x = (scrollView.frame.size.width - imgV.frame.size.width) > 0 ? (scrollView.frame.size.width - imgV.frame.size.width) * 0.5 : 0;
    frame.origin.y = (scrollView.frame.size.height - imgV.frame.size.height) > 0 ? (scrollView.frame.size.height - imgV.frame.size.height) * 0.5 : 0;
    imgV.frame = frame;
    scrollV.contentSize = CGSizeMake(imgV.frame.size.width, imgV.frame.size.height);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    currentScale = scale;
}

#pragma mark -- 其他方法
- (CGFloat)imageContentHeight:(UIImage *)image {
    CGFloat imgHeight = image.size.height;
    CGFloat imgWidth = image.size.width;
    CGFloat imgH = imgHeight * (LEESWidth / imgWidth);
    return imgH;
}

//双击放大图片
- (void)tapTwiceCallback:(UITapGestureRecognizer *)tapGesture {
    if (currentScale > 1.0) {
        [scrollV setZoomScale:1.0 animated:YES];
    } else {
        [scrollV setZoomScale:2.5 animated:YES];
    }
}

#pragma mark -- 公有方法
- (void)layoutView {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    self.title = _imgKey;
    self.view.backgroundColor = LEEHexColor(0xDBDBDB, 1.0);
    
    scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, LEESWidth, LEESHeight - 64)];
    [self.view addSubview:scrollV];
    // 使用 ScrollView 实现图片的放大缩小
    scrollV.minimumZoomScale = 1;  //最小倍数为一倍，即最小只显示原图
    scrollV.maximumZoomScale = 5;  //最大放大倍数为五倍
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.scrollEnabled = YES;
    scrollV.userInteractionEnabled = YES;
    scrollV.bounces = NO;
    scrollV.delegate = self;
    // 添加双击放大图片手势
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwiceCallback:)];
    tapTwice.numberOfTapsRequired = 2;
    [scrollV addGestureRecognizer:tapTwice];
	
    if (_imgName.length) {  // 加载本地图片
        UIImage *image = [UIImage imageNamed:_imgName];
        CGFloat imgH = [self imageContentHeight:image];
        scrollV.contentSize = CGSizeMake(LEESWidth, imgH);
        if (imgH < LEEContentHeight) {  // 不是长图片时，居中显示
            imgV = [[LargeImageView alloc] initWithFrame:CGRectMake(0, LEEContentHeight / 2 - imgH / 2, LEESWidth, imgH)];
        } else { // 长图片时铺满 scrollView
            imgV = [[LargeImageView alloc] initWithFrame:CGRectMake(0, 0, LEESWidth, imgH)];
        }
        [imgV setImage:image];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [scrollV addSubview:imgV];
        
        return;
    }
    
    //下载失败提示
    errorV = [[UIView alloc] init];
    [self.view addSubview:errorV];
    errorV.sd_layout.xIs(0).yIs(0).widthIs(LEESWidth).heightIs(self.view.height);
    errorV.hidden = YES;
    errorV.backgroundColor = [UIColor whiteColor];

    UIImageView *netErrorImgV = [[UIImageView alloc] init];
    [errorV addSubview:netErrorImgV];
    netErrorImgV.sd_layout.yIs(160).widthIs(LEESWidth - 100).heightIs(130);
    netErrorImgV.centerX = LEESWidth / 2.0;
    netErrorImgV.image = [UIImage imageNamed:@"NetError"];

    UILabel *errorLab = [[UILabel alloc] init];
    [errorV addSubview:errorLab];
    errorLab.sd_layout.topSpaceToView(netErrorImgV, 10).widthIs(LEESWidth).heightIs(25);
    errorLab.centerX = LEESWidth / 2.0;
    errorLab.text = @"Loading failed, please try again.";
    errorLab.textAlignment = NSTextAlignmentCenter;
    errorLab.textColor = LEEHexColor(0x999999, 1.0);
    errorLab.font = [UIFont systemFontOfSize:17];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [errorV addSubview:btn];
    btn.sd_layout.widthIs(200).heightIs(40).centerXEqualToView(netErrorImgV).topSpaceToView(errorLab, 15);
    [btn setTitle:@"Refresh" forState:UIControlStateNormal];
    [btn setTitleColor:LEEHexColor(0x2472B9, 1.0) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = LEEHexColor(0x2472B9, 1.0).CGColor;
    btn.layer.borderWidth = 1.0f;
    btn.layer.cornerRadius = 20;
    [btn addTarget:self action:@selector(viewUpdate) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:_imgKey];
    if (image) {
        CGFloat imgH = [self imageContentHeight:image];
        scrollV.contentSize = CGSizeMake(LEESWidth, imgH);
        if (imgH < LEEContentHeight) {  // 不是长图片时，居中显示
            imgV = [[LargeImageView alloc] initWithFrame:CGRectMake(0, LEEContentHeight / 2 - imgH / 2, LEESWidth, imgH)];
        } else { // 长图片时铺满 scrollView
            imgV = [[LargeImageView alloc] initWithFrame:CGRectMake(0, 0, LEESWidth, imgH)];
        }
        [imgV setImage:image];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [scrollV addSubview:imgV];
    } else {
        // 网络请求时状态栏转圈圈
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		
        /*
        // 屏幕中间转圈
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [scrollV addSubview:activityIndicatorView];
        activityIndicatorView.center = CGPointMake(LEESWidth / 2.0, LEEContentHeight / 2.0  - 50);
        CGAffineTransform transform =  CGAffineTransformMakeScale(1.5, 1.5);
        activityIndicatorView.transform = transform;
        [activityIndicatorView startAnimating];
        activityIndicatorView.hidesWhenStopped = YES;
        // 加载中
        loadingLab = [[UILabel alloc] initWithFrame:CGRectMake(0, LEEContentHeight / 2.0 - 20, LEESWidth, 20)];
        [scrollV addSubview:loadingLab];
        loadingLab.text = @"Loading";
        loadingLab.textColor = LEEHexColor(0xcccccc, 1.0);
        loadingLab.textAlignment = NSTextAlignmentCenter;
        loadingLab.font = [UIFont systemFontOfSize:18];
         */
        
        [self showHud];
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        downloader.config.downloadTimeout = 10.0;  //设置下载超时:10秒
        [downloader downloadImageWithURL:[NSURL URLWithString:_imgURL]
                                 options:0
                                progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                    // progression tracking code
                                }
                               completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                   [self hidHud];
                                   if(error) {
                                       //延迟 1秒 显示下载失败提示
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                           self->scrollV.hidden = YES;
                                           self->errorV.hidden = NO;
                                       });
                                   }
                                   if (image && finished) {
                                       [[SDImageCache sharedImageCache] storeImage:image forKey:self->_imgKey toDisk:NO completion:nil];
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                           //self->loadingLab.hidden = YES;
                                           //[self->activityIndicatorView stopAnimating];
                                           //[self->activityIndicatorView removeFromSuperview];
                                           CGFloat imgH = [self imageContentHeight:image];
                                           self->scrollV.contentSize = CGSizeMake(LEESWidth, imgH);
                                           if (imgH < LEEContentHeight) { // 不是长图片时，居中显示
                                               self->imgV = [[LargeImageView alloc] initWithFrame:CGRectMake(0, LEEContentHeight / 2 - imgH / 2, LEESWidth, imgH)];
                                           } else {  // 长图片时铺满 scrollView
                                               self->imgV = [[LargeImageView alloc] initWithFrame:CGRectMake(0, 0, LEESWidth, imgH)];
                                           }
                                           [self->imgV setImage:image];
                                           self->imgV.contentMode = UIViewContentModeScaleAspectFill;
                                           [self->scrollV addSubview:self->imgV];
                                       });
                                   }
                               }];
    }
}

- (void)viewUpdate {
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self layoutView];
    });
}

- (void)dealloc {
    NSLog(@"%@ 类 dealloc",[self class]);
    //SDImageCache *canche = [SDImageCache sharedImageCache];
    //canche.config.shouldDecompressImages = SDImageCacheOldShouldDecompressImages;
    
    //SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    //downloder.shouldDecompressImages = SDImagedownloderOldShouldDecompressImages;
}

@end
