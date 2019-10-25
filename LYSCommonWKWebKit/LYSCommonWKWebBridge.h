//
//  LYSCommonWKWebBridge.h
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSCommonWKWebBridge : LYSCommonWKWebAPI
- (void)ly_addAsynAction:(SEL)action target:(id)target name:(NSString *)name;
- (void)ly_removeAsynActionWithName:(NSString *)name;
- (void)ly_evaluateResponse:(NSDictionary *)response success:(BOOL)success message:(NSString *)message bridge:(LYSBridgeInfo *)bridge;
@end

NS_ASSUME_NONNULL_END
