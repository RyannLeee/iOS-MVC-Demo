//
//  ViewController.m
//  LEEDemoForMVC
//
//  Created by iOS on 2019/3/13.
//  Copyright © 2019 YuanLee. All rights reserved.
//

#import "MJRefresh.h"
#import "LEEDetailVC.h"
#import "LEECellModel.h"
#import "UIImage+Color.h"
#import "LEETableViewCell.h"
#import "MainViewController.h"
#import "LEEDemoForMVC-Swift.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutView];
    [self initDataSource];
}

#pragma mark -- TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = self.dataSource[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerIdentifier = @"headerView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
        //headerView.backgroundColor = LEEHexColor(0xeeeeee, 1.0);
        headerView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:LEEHexColor(0xeeeeee, 1.0)]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, LEESWidth - 30, 35)];
        label.tag = 1001;
        label.textColor = LEEHexColor(0x333333, 1.0);
        label.font = [UIFont systemFontOfSize:autoScaleF(16)];
        label.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:label];
    }
    
    UILabel *label = (UILabel *)[headerView viewWithTag:1001];
    label.text = self.titleArray[section];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LEETableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LEETableViewCell class])];
    if (!cell) {
        cell = [[LEETableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LEETableViewCell class])];
    }
    LEECellModel *model;
    
    if (self.dataSource.count) {
        NSDictionary *dic = self.dataSource[indexPath.section][indexPath.row];
        if (dic[@"model"]) {
            model = dic[@"model"];
        }
    }
    [cell setModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < 3) {
        LEEDetailVC *detailVC = [[LEEDetailVC alloc] init];
        if (self.dataSource.count) {
            NSDictionary *dic = self.dataSource[indexPath.section][indexPath.row];
            if (dic[@"imgName"]) {
                detailVC.imgName = dic[@"imgName"];
            }
            if (dic[@"imgKey"]) {
                detailVC.imgKey = dic[@"imgKey"];
            }
            if (dic[@"imgURL"]) {
                detailVC.imgURL = dic[@"imgURL"];
            }
        }
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        LEESwiftVC *swift = [[LEESwiftVC alloc] init];
        [self.navigationController pushViewController:swift animated:YES];
    }
}

- (void)initDataSource {
    [_dataSource removeAllObjects];
    
    // 三个网络大图 Section 0
    LEECellModel *model01 = [[LEECellModel alloc] initWithTitle:@"NetImg 1" imgName:@"pic1"];
    NSString *imgURL01 = @"http://www.wanwenku.com/uploadfile/2016/0616/20160616111704532.jpg";
    NSDictionary *dic01 = @{@"model":model01, @"imgKey":@"NetImg 1", @"imgURL":imgURL01, @"imgName":@""};
    
    LEECellModel *model02 = [[LEECellModel alloc] initWithTitle:@"NetImg 2" imgName:@"pic2"];
    NSString *imgURL02 = @"http://www.wanwenku.com/uploadfile/2016/0528/20160528125916910.jpg";
    NSDictionary *dic02 = @{@"model":model02, @"imgKey":@"NetImg 2", @"imgURL":imgURL02, @"imgName":@""};
    
    LEECellModel *model03 = [[LEECellModel alloc] initWithTitle:@"NetImg 3" imgName:@"pic3"];
    NSString *imgURL03 = @"http://www.wanwenku.com/uploadfile/2016/0514/20160514120203208.jpg";
    NSDictionary *dic03 = @{@"model":model03, @"imgKey":@"NetImg 3", @"imgURL":imgURL03, @"imgName":@""};
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:dic01, dic02, dic03, nil];
    
    // 两个本地大图 Section 1
    LEECellModel *model11 = [[LEECellModel alloc] initWithTitle:@"LocalImg 1" imgName:@"pic4"];
    NSDictionary *dic11 = @{@"model":model11, @"imgKey":@"LocalImg 1", @"imgURL":@"", @"imgName":@"BigPic1"}; // 这张图片10M, 加载起来很慢
    
    LEECellModel *model12 = [[LEECellModel alloc] initWithTitle:@"LocalImg 2" imgName:@"pic5"];
    NSDictionary *dic12 = @{@"model":model12, @"imgKey":@"LocalImg 2", @"imgURL":@"", @"imgName":@"BigPic2"}; // 这张图片5M, 加载起来速度尚可
    NSMutableArray *array2 = [NSMutableArray arrayWithObjects:dic11, dic12, nil];
    
    // 网络长图 Section 2
    LEECellModel *model31 = [[LEECellModel alloc] initWithTitle:@"NetLongImg" imgName:@"pic6"];
    NSDictionary *dic31 = @{@"model":model31, @"imgKey":@"LongImg", @"imgURL":@"http://ww2.sinaimg.cn/large/bd2fd49bgw1e26kv4tyqwj.jpg", @"imgName":@""};
    NSMutableArray *array3 = [NSMutableArray arrayWithObjects:dic31, nil];
    
    // Swift Section 3
    LEECellModel *model41 = [[LEECellModel alloc] initWithTitle:@"Swift" imgName:@"swift"];
    NSDictionary *dic41 = @{@"model":model41, @"imgKey":@"", @"imgURL":@"", @"imgName":@""};
    NSMutableArray *array4 = [NSMutableArray arrayWithObjects:dic41, nil];
    
    [self.dataSource addObject:array1];
    [self.dataSource addObject:array2];
    [self.dataSource addObject:array3];
    [self.dataSource addObject:array4];
    
    [self.tableView reloadData];
}

#pragma mark -- 公有方法
- (void)layoutView {
    self.view.backgroundColor = LEEHexColor(0xffffff, 1.0);
    self.navigationItem.title = @"YuanLee";
    
    //UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    //backBtn.title = @"返回";
    // 修改导航栏上返回按钮上的文字，注意这里的self是父ViewController,不是即将显示的子ViewController
    //self.navigationItem.backBarButtonItem = backBtn;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    // 消除 cell 的线与屏幕边缘的距离
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.backgroundColor = LEEHexColor(0xffffff, 1.0);
    tableView.separatorColor = LEEHexColor(0xcccccc, 1.0);
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    // 使用 MJRefresh 实现 TableView 的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    //提示内容
    [header setTitle:@"Pull Down To Refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release To Refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Refreshing" forState:MJRefreshStateRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    self.tableView.mj_header = header;
}

- (void)viewUpdate {
    [_tableView reloadData];
    [(MJRefreshNormalHeader *)_tableView.mj_header setTitle:@"Pull Down To Refresh" forState:MJRefreshStateIdle];
    [(MJRefreshNormalHeader *)_tableView.mj_header setTitle:@"Release To Refresh" forState:MJRefreshStatePulling];
    [(MJRefreshNormalHeader *)_tableView.mj_header setTitle:@"Refreshing" forState:MJRefreshStateRefreshing];
}

- (void)refreshData
{
    [self showHudWithText:@"Loading..."];
    //[self showHudInWindowWithText:@"Loading..."];
    
    //1秒后刷新表格UI
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //[MBProgressHUD hideHUDForView:self.view.window animated:YES];
        //[hud hideAnimated:YES afterDelay:0.5];
        [self.hud hideAnimated:YES afterDelay:0.5];
        
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"网络大图", @"本地大图", @"网络长图", @"Swift"];
    }
    return _titleArray;
}

@end
