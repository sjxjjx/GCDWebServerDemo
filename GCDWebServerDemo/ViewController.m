//
//  ViewController.m
//  GCDWebServerDemo
//
//  Created by shapp on 2017/8/23.
//  Copyright © 2017年 shapp. All rights reserved.
//

#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "GCDWebUploader.h"
#import "SJXCSMIPHelper.h"

@interface ViewController () <GCDWebUploaderDelegate, UITableViewDelegate, UITableViewDataSource>
{
    GCDWebUploader * _webServer;
}

/* 显示ip地址 */
@property (nonatomic, weak) UILabel *showIpLabel;
/* fileTableView */
@property (nonatomic, weak) UITableView *fileTableView;
/* fileArray */
@property (nonatomic, strong) NSMutableArray *fileArray;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 文件存储位置
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"文件存储位置 : %@", documentsPath);
    
    // 创建webServer，设置根目录
    _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    // 设置代理
    _webServer.delegate = self;
    _webServer.allowHiddenItems = YES;
    
    // 限制文件上传类型
    _webServer.allowedFileExtensions = @[@"doc", @"docx", @"xls", @"xlsx", @"txt", @"pdf"];
    // 设置网页标题
    _webServer.title = @"兔·小白的demo";
    // 设置展示在网页上的文字(开场白)
    _webServer.prologue = @"欢迎使用兔·小白的WIFI管理平台";
    // 设置展示在网页上的文字(收场白)
    _webServer.epilogue = @"兔·小白制作";
    
    if ([_webServer start]) {
        self.showIpLabel.hidden = NO;
        self.showIpLabel.text = [NSString stringWithFormat:@"请在网页输入这个地址  http://%@:%zd/", [SJXCSMIPHelper deviceIPAdress], _webServer.port];
    } else {
        self.showIpLabel.text = NSLocalizedString(@"GCDWebServer not running!", nil);
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_webServer stop];
    _webServer = nil;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.fileArray[indexPath.row];
    return cell;
}

#pragma mark - <GCDWebUploaderDelegate>
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path {
    NSLog(@"[UPLOAD] %@", path);
    
    self.showIpLabel.hidden = YES;
    
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.fileArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:string error:nil]];
    
    [self.fileTableView reloadData];
}

- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    NSLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path {
    NSLog(@"[DELETE] %@", path);
    
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.fileArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:string error:nil]];
    
    [self.fileTableView reloadData];
}

- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path {
    NSLog(@"[CREATE] %@", path);
}

#pragma mark - <懒加载>
- (UILabel *)showIpLabel {
    if (!_showIpLabel) {
        UILabel *lb = [[UILabel alloc] init];
        
        lb.bounds = CGRectMake(0, 0, Screen_W, 200);
        lb.center = CGPointMake(Screen_W * 0.5, Screen_H * 0.5);
        lb.textColor = [UIColor darkGrayColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:13.0];
        lb.numberOfLines = 0;
        
        [self.view addSubview:lb];
        _showIpLabel = lb;
    }
    return _showIpLabel;
}
- (UITableView *)fileTableView {
    if (!_fileTableView) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H) style:UITableViewStylePlain];
        
        // 设置代理
        tv.delegate = self;
        // 设置数据源
        tv.dataSource = self;
        // 清除表格底部多余的cell
        tv.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.view addSubview:tv];
        _fileTableView = tv;
    }
    return _fileTableView;
}
- (NSMutableArray<NSString *> *)fileArray {
    if (!_fileArray) {
        _fileArray = [NSMutableArray array];
    }
    return _fileArray;
}

@end
