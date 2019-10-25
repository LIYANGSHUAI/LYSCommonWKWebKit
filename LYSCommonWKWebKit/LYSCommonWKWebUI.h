//
//  LYSCommonWKWebUI.h
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "LYSCommonWKWebStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSCommonWKWebUI : UIView<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

// 默认是 callNativeBridgeApi,主要是用于JSBridge文件
@property (nonatomic, copy) NSString *globalCallString;
// 默认是 JsBridgeInvoke,主要是用于JSBridge文件
@property (nonatomic, copy) NSString *globalPushString;
// 默认是 dx,window调用oc方法: window.dx.callNativeBridgeApi()
@property (nonatomic, copy) NSString *globalObjectSting;

// 提示信息
@property (nonatomic, strong) UILabel * __nullable stateLabel;
// 加载圈容器
@property (nonatomic, strong) UIView  * __nullable hudView;
// 加载圈
@property (nonatomic, strong) UIActivityIndicatorView * __nullable indicatorView;

// WKWebView配置信息
@property (nonatomic, strong) WKWebViewConfiguration *webConfig;
// WKWebView JavaScript配置对象
@property (nonatomic, strong) WKUserContentController *userContentController;
// 使用的网页展示容器WKWebView
@property (nonatomic, strong) WKWebView * __nullable webView;

// 是否默认显示加载圈及加载信息,默认是显示 YES
@property (nonatomic, assign) BOOL autoShowHudEnable;

// 加载状态组件
@property (nonatomic, strong) LYSCommonWKWebStatus * __nullable webStatusView;
// 是否默认显示加载状态组件,默认是显示 YES
@property (nonatomic, assign) BOOL autoShowStatusEnable;

// 加载状态组件是否显示错误信息,默认是显示 YES
@property (nonatomic, assign) BOOL statuAutoShowErrorDes;
// 状态组件是否显示图片
@property (nonatomic, assign) BOOL showNetIcon;
// 状态组件是否显示描述信息
@property (nonatomic, assign) BOOL showNetDesLabel;
// 状态组件是否显示刷新按钮
@property (nonatomic, assign) BOOL showNetRefreshBtn;

// 加载网页地址,如果你有设置以上几个或者多个属性,建议加载网页方法放到最后执行,具体原因看代码逻辑
- (void)ly_loadUrl:(NSString *)urlStr;
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

// 当然加载圈的显示和隐藏, 你也可以自己设计
- (void)showHUD;
- (void)hiddenHUD;
- (void)showText:(NSString *)text time:(NSInteger)time;
@end

NS_ASSUME_NONNULL_END
