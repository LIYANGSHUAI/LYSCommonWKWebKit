//
//  LYSCommonWKWebLife.h
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebUI.h"

NS_ASSUME_NONNULL_BEGIN

@class LYSCommonWKWeb;

@protocol LYSCommonWKWebAPIDelegate <NSObject>

@optional
- (void)webView:(LYSCommonWKWeb *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
- (void)webView:(LYSCommonWKWeb *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;

@end

@protocol LYSCommonWKWebLifeDelegate <NSObject>

@optional
- (void)webView:(LYSCommonWKWeb *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
- (void)webView:(LYSCommonWKWeb *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error;
- (void)webView:(LYSCommonWKWeb *)webView didFinishNavigation:(WKNavigation *)navigation;

@end

@interface LYSCommonWKWebLife : LYSCommonWKWebUI
@property (nonatomic, assign) id<LYSCommonWKWebAPIDelegate> jsDelegate;
@property (nonatomic, assign) id<LYSCommonWKWebLifeDelegate> lifeDelegate;
@end

NS_ASSUME_NONNULL_END
