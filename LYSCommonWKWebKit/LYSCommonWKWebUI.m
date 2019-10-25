//
//  LYSCommonWKWebUI.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebUI.h"

@interface LYSCommonWKWebUI ()
@property (nonatomic, assign) BOOL firstLoadUrl;

@property (nonatomic, copy) NSString *loadUrl;
@end

@implementation LYSCommonWKWebUI
- (WKUserContentController *)userContentController
{
    if (!_userContentController) {
        _userContentController = [[WKUserContentController alloc] init];
        [_userContentController addScriptMessageHandler:self name:@"commonCallback"];
        NSString *jsCode = [NSString stringWithFormat:@"window.%@ = {};window.%@.%@ = function (obj) {window.webkit.messageHandlers.commonCallback.postMessage(obj);}",self.globalObjectSting,self.globalObjectSting,self.globalCallString];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:jsCode injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [_userContentController addUserScript:script];
    }
    return _userContentController;
}
- (WKWebViewConfiguration *)webConfig
{
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc] init];
        _webConfig.userContentController = self.userContentController;
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
- (UIView *)hudView
{
    if (!_hudView) {
        _hudView = [[UIView alloc] init];
    }
    return _hudView;
}
- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.numberOfLines = 0;
        _stateLabel.layer.cornerRadius = 5;
        _stateLabel.layer.masksToBounds = YES;
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _stateLabel;
}
- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    }
    return _indicatorView;
}
- (LYSCommonWKWebStatus *)webStatusView
{
    if (!_webStatusView) {
        _webStatusView = [[LYSCommonWKWebStatus alloc] initWithFrame:self.bounds];
        _webStatusView.showNetRefreshBtn = self.showNetRefreshBtn;
        _webStatusView.showNetDesLabel = self.showNetDesLabel;
        _webStatusView.showNetIcon = self.showNetIcon;
    }
    return _webStatusView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.globalCallString = @"callNativeBridgeApi";
        self.globalPushString = @"JsBridgeInvoke";
        self.globalObjectSting = @"dx";
        self.autoShowHudEnable = YES;
        self.autoShowStatusEnable = NO;
        self.statuAutoShowErrorDes = YES;
        self.showNetRefreshBtn = YES;
        self.showNetDesLabel = YES;
        self.showNetIcon = YES;
    }
    return self;
}
- (void)ly_loadUrl:(NSString *)urlStr
{
    self.loadUrl = urlStr;
    self.firstLoadUrl = YES;
    if (self.webView) {
        [self.webView removeFromSuperview];
        self.webView = nil;
    }
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self addSubview:self.webView];
    if (self.autoShowStatusEnable) {
        if (self.webStatusView) {
            [self.webStatusView removeFromSuperview];
            self.webStatusView = nil;
        }
        [self addSubview:self.webStatusView];
        self.webStatusView.hidden = YES;
        [self.webStatusView.netRefreshBtn addTarget:self action:@selector(refreshBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *w = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webView]|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_webView)];
    NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_webView)];
    [self addConstraints:w];
    [self addConstraints:h];
}
- (void)refreshBtn:(UIButton *)sender
{
    [self ly_loadUrl:self.loadUrl];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if (self.firstLoadUrl && self.autoShowHudEnable) {
        [self showHUD];
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if (self.firstLoadUrl && self.autoShowHudEnable) {
        [self hiddenHUD];
    }
    if (self.firstLoadUrl) {
        NSString *jsString = [NSString stringWithFormat:@"ready()"];
        [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {}];
    }
    self.firstLoadUrl = NO;
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if ( self.firstLoadUrl && self.autoShowHudEnable) {
        [self hiddenHUD];
        [self showText:error.localizedDescription time:2];
    }
    if (self.firstLoadUrl && self.autoShowStatusEnable) {
        self.webStatusView.hidden = NO;
        if (self.statuAutoShowErrorDes) {
            self.webStatusView.netDesLabel.text = error.localizedDescription;
        }
    }
    self.firstLoadUrl = NO;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {}

- (void)showHUD
{
    if (self.hudView) {
        [self.hudView removeFromSuperview];
        self.hudView = nil;
    }
    self.hudView.alpha = 0;
    [self addSubview:self.hudView];
    [UIView animateWithDuration:0.5 animations:^{
        self.hudView.alpha = 1;
    }];
    self.hudView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    CGFloat hud_w = w / 375.0 * 50;
    CGFloat hud_h = w / 375.0 * 50;
    CGFloat top = (h - hud_h) / 2.0;
    CGFloat bottom = (h - hud_h) / 2.0;
    CGFloat left = (w - hud_w) / 2.0;
    CGFloat right = (w - hud_w) / 2.0;
    self.hudView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.hudView.layer.cornerRadius = w / 375.0 * 10;
    self.hudView.layer.masksToBounds = YES;
    NSArray *a = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[_hudView]-%f-|",left,right] options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_hudView)];
    NSArray *b = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_hudView]-%f-|",top,bottom] options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_hudView)];
    [self addConstraints:a];
    [self addConstraints:b];
    {
        if (self.indicatorView) {
            [self.indicatorView removeFromSuperview];
            self.indicatorView = nil;
        }
        [self.indicatorView startAnimating];
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.hudView addSubview:self.indicatorView];
        NSArray *a = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_indicatorView]-10-|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_indicatorView)];
        NSArray *b = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_indicatorView]-10-|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_indicatorView)];
        [self.hudView addConstraints:a];
        [self.hudView addConstraints:b];
    }
}

- (void)hiddenHUD
{
    [UIView animateWithDuration:0.5 animations:^{
        self.hudView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.hudView removeFromSuperview];
    }];
}

- (void)showText:(NSString *)text time:(NSInteger)time
{
    if (self.stateLabel) {
        [self.stateLabel removeFromSuperview];
        self.stateLabel = nil;
    }
    self.stateLabel.alpha = 0;
    [self addSubview:self.stateLabel];
    [UIView animateWithDuration:0.5 animations:^{
        self.stateLabel.alpha = 1;
    }];
    self.stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *stateStr = text;
    self.stateLabel.text = stateStr;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    CGSize size = [stateStr boundingRectWithSize:CGSizeMake(w-40, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    if (size.height < 40) {
        size.height = 40;
    }
    CGFloat bottom = h * .1;
    CGFloat top = h - size.height - bottom;
    NSArray *a = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_stateLabel]-20-|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_stateLabel)];
    NSArray *b = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_stateLabel]-%f-|",top,bottom] options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_stateLabel)];
    [self addConstraints:a];
    [self addConstraints:b];
    if (time != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.stateLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [self.stateLabel removeFromSuperview];
            }];
        });
    }
}
- (void)hiddenText
{
    [UIView animateWithDuration:0.5 animations:^{
        self.stateLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [self.stateLabel removeFromSuperview];
    }];
}
@end
