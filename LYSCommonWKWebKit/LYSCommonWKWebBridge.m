//
//  LYSCommonWKWebBridge.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebBridge.h"

@interface LYSCommonWKWebBridge ()
@property (nonatomic, strong) NSMutableDictionary *actionDict;
@end

@implementation LYSCommonWKWebBridge

- (NSMutableDictionary *)actionDict
{
    if (!_actionDict) {
        _actionDict = [NSMutableDictionary dictionary];
    }
    return _actionDict;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [super userContentController:userContentController didReceiveScriptMessage:message];
    if([message.name isEqualToString:@"commonCallback"]){
        if ([message.body isKindOfClass:[NSString class]]) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[message.body dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
            NSString *bridgeName = dict[@"bridgeName"];
            NSString *callbackId = dict[@"callbackId"];
            id data = dict[@"data"];
            LYSBridgeInfo *model = [[LYSBridgeInfo alloc] initWithBridgeName:bridgeName callbackId:callbackId parms:data];
            [self addBridge:model];
            [self didCallNativeBridgeApi:model];
        }
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = message.body;
            NSString *bridgeName = dict[@"bridgeName"];
            NSString *callbackId = dict[@"callbackId"];
            id data = dict[@"data"];
            LYSBridgeInfo *model = [[LYSBridgeInfo alloc] initWithBridgeName:bridgeName callbackId:callbackId parms:data];
            [self addBridge:model];
            [self didCallNativeBridgeApi:model];
        }
    }
}

- (void)didCallNativeBridgeApi:(LYSBridgeInfo *)bridge
{
    NSInvocation *invocation = [self.actionDict objectForKey:bridge.bridgeName];
    [invocation setArgument:&bridge atIndex:2];
    [invocation invoke];
}

- (void)ly_addAsynAction:(SEL)action target:(id)target name:(NSString *)name
{
    NSMethodSignature *signature = [target methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = action;
    [self.actionDict setObject:invocation forKey:name];
}

- (void)ly_removeAsynActionWithName:(NSString *)name
{
    if ([[self.actionDict allKeys] containsObject:name]) {
        [self.actionDict removeObjectForKey:name];
    }
}

- (void)ly_evaluateResponse:(NSDictionary *)response success:(BOOL)success message:(NSString *)message bridge:(LYSBridgeInfo *)bridge
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<LYSBridgeInfo *> *tempAry = [self getBridgesWith:bridge.bridgeName];
        for (LYSBridgeInfo *model in tempAry)
        {
            NSData *dictData = [NSJSONSerialization dataWithJSONObject:@{
                                                                         @"bridgeName":model.bridgeName,
                                                                         @"message":message,
                                                                         @"success":@(success),
                                                                         @"data":response,
                                                                         @"callbackId":model.callbackId
                                                                         } options:(NSJSONWritingPrettyPrinted) error:nil];
            NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
            NSString *jsString = [NSString stringWithFormat:@"%@(%@)",self.globalPushString,dictStr];
            [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {}];
            [self removeBridge:model];
        }
    });
}

@end
