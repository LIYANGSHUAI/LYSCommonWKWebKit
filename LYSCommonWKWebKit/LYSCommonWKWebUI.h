//
//  LYSCommonWKWebUI.h
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSCommonWKWebUI : UIView

// 默认是 callNativeBridgeApi,主要是用于JSBridge文件
@property (nonatomic, copy) NSString *globalCallString;
// 默认是 JsBridgeInvoke,主要是用于JSBridge文件
@property (nonatomic, copy) NSString *globalPushString;
// 默认是 dx,window调用oc方法: window.dx.callNativeBridgeApi()
@property (nonatomic, copy) NSString *globalObjectSting;

@property (nonatomic, strong) WKWebViewConfiguration *webConfig;
@property (nonatomic, strong) WKWebView *webView;

- (void)ly_loadUrl:(NSString *)urlStr;
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
@end

NS_ASSUME_NONNULL_END
