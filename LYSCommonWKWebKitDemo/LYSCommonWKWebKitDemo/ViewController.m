//
//  ViewController.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSCommonWKWeb.h"

@interface ViewController ()<LYSCommonWKWebAPIDelegate,LYSCommonWKWebLifeDelegate>
@property (nonatomic, strong) LYSCommonWKWeb *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[LYSCommonWKWeb alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.jsDelegate = self;
    self.webView.lifeDelegate = self;
//    self.webView.autoShowHudEnable = NO;
//    self.webView.statuAutoShowErrorDes = NO;
//    self.webView.showNetRefreshBtn = NO;
//    [self.webView ly_loadUrl:@"http://10.89.133.237:8080"];
        [self.webView ly_loadUrl:@"http://www.baidu.com"];
    [self.webView ly_addAsynAction:@selector(getUserInfo:) target:self name:@"getUserInfo"];
}

- (void)getUserInfo:(id)obj
{
    LYSBridgeInfo *info = (LYSBridgeInfo *)obj;
    NSLog(@"%@",info.allParms);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView ly_evaluateResponse:@{@"name":@"1121"} success:YES message:@"成功!" bridge:info];
    });
}

- (void)webView:(LYSCommonWKWeb *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    [self.webView showHUD];
    NSLog(@"开始");
}

- (void)webView:(LYSCommonWKWeb *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    [self.webView hiddenHUD];
    NSLog(@"完成");
}

- (void)webView:(LYSCommonWKWeb *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
//    [self.webView hiddenHUD];
//    [self.webView showText:error.localizedDescription time:1];
    NSLog(@"失败");
}


@end
