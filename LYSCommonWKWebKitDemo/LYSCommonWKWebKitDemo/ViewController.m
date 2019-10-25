//
//  ViewController.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSCommonWKWeb.h"

@interface ViewController ()<LYSCommonWKWebAPIDelegate>
@property (nonatomic, strong) LYSCommonWKWeb *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[LYSCommonWKWeb alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView ly_loadUrl:@"http://10.89.133.237:8080"];
    self.webView.jsDelegate = self;
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

- (void)webView:(LYSCommonWKWeb *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%@",message);
    completionHandler();
}

@end
