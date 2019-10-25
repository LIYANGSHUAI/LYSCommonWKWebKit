//
//  LYSCommonWKWebUI.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebUI.h"

@interface LYSCommonWKWebUI ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@end

@implementation LYSCommonWKWebUI

- (WKWebViewConfiguration *)webConfig
{
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        _webConfig.userContentController = wkUController;
        [_webConfig.userContentController addScriptMessageHandler:self  name:@"commonCallback"];
        NSString *jsCode = [NSString stringWithFormat:@"window.%@ = {};window.%@.%@ = function (obj) {window.webkit.messageHandlers.commonCallback.postMessage(obj);}",self.globalObjectSting,self.globalObjectSting,self.globalCallString];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:jsCode injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [_webConfig.userContentController addUserScript:script];
    }
    return _webConfig;
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:self.webConfig];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.globalCallString = @"callNativeBridgeApi";
        self.globalPushString = @"JsBridgeInvoke";
        self.globalObjectSting = @"dx";
    }
    return self;
}
- (void)ly_loadUrl:(NSString *)urlStr
{
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *w = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webView]|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_webView)];
    NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_webView)];
    [self addConstraints:w];
    [self addConstraints:h];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSString *jsString = [NSString stringWithFormat:@"ready()"];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {}];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {}
@end
