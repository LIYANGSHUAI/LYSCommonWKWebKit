//
//  LYSCommonWKWebAPI.h
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebLife.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSBridgeInfo : NSObject

@property (nonatomic, copy)NSString *bridgeName;
@property (nonatomic, copy)NSString *callbackId;
@property (nonatomic, strong)id parms;

@property (nonatomic, strong, readonly)NSDictionary *allParms;

- (instancetype)initWithBridgeName:(NSString *)bridgeName callbackId:(NSString *)callbackId parms:(id)parms;

@end;

@interface LYSCommonWKWebAPI : LYSCommonWKWebLife

@property (nonatomic, strong) NSMutableDictionary *bridgeDict;
- (void)addBridge:(LYSBridgeInfo *)bridge;
- (NSArray<LYSBridgeInfo *> *)getBridgesWith:(NSString *)bridgeName;
- (void)removeBridge:(LYSBridgeInfo *)bridge;

@end

NS_ASSUME_NONNULL_END
