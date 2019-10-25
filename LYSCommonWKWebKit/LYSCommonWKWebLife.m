//
//  LYSCommonWKWebLife.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebLife.h"

@interface LYSCommonWKWebLife ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation LYSCommonWKWebLife

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    if (self.jsDelegate && [self.jsDelegate respondsToSelector:@selector(webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.jsDelegate webView:(LYSCommonWKWeb *)self runJavaScriptAlertPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    } else {
        completionHandler();
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    if (self.jsDelegate && [self.jsDelegate respondsToSelector:@selector(webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.jsDelegate webView:(LYSCommonWKWeb *)self runJavaScriptConfirmPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    } else {
        completionHandler(YES);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if (self.lifeDelegate && [self.lifeDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [self.lifeDelegate webView:(LYSCommonWKWeb *)self didStartProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (self.lifeDelegate && [self.lifeDelegate respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
        [self.lifeDelegate webView:(LYSCommonWKWeb *)self didFailProvisionalNavigation:navigation withError:error];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if (self.lifeDelegate && [self.lifeDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [self.lifeDelegate webView:(LYSCommonWKWeb *)self didFinishNavigation:navigation];
    }
}

@end
