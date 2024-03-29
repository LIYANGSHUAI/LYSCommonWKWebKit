//
//  LYSCommonWKWebAPI.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/24.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebAPI.h"

@implementation LYSBridgeInfo

- (instancetype)initWithBridgeName:(NSString *)bridgeName callbackId:(NSString *)callbackId parms:(id)parms
{
    if (self = [super init]) {
        self.bridgeName = bridgeName;
        self.callbackId = callbackId;
        self.parms = parms;
    }
    return self;
}

- (NSDictionary *)allParms
{
    return @{
             @"bridgeName": self.bridgeName,
             @"callbackId": self.callbackId,
             @"parms": self.parms
             };
}

@end

@interface LYSCommonWKWebAPI ()

@end

@implementation LYSCommonWKWebAPI

- (NSMutableDictionary *)bridgeDict
{
    if (!_bridgeDict) {
        _bridgeDict = [NSMutableDictionary dictionary];
    }
    return _bridgeDict;
}

- (void)addBridge:(LYSBridgeInfo *)bridge
{
    if ([[self.bridgeDict allKeys] containsObject:bridge.bridgeName]) {
        NSMutableArray *ary = [NSMutableArray arrayWithArray:[self.bridgeDict objectForKey:bridge.bridgeName]];
        [ary addObject:bridge];
        [self.bridgeDict setObject:ary forKey:bridge.bridgeName];
    } else {
        NSMutableArray *ary = [NSMutableArray array];
        [ary addObject:bridge];
        [self.bridgeDict setObject:ary forKey:bridge.bridgeName];
    }
}

- (NSArray<LYSBridgeInfo *> *)getBridgesWith:(NSString *)bridgeName
{
    if ([[self.bridgeDict allKeys] containsObject:bridgeName]) {
        return [NSArray arrayWithArray:[self.bridgeDict objectForKey:bridgeName]];
    } else {
        return @[];
    }
}

- (void)removeBridge:(LYSBridgeInfo *)bridge
{
    if ([[self.bridgeDict allKeys] containsObject:bridge.bridgeName])
    {
        NSMutableArray *ary = [NSMutableArray arrayWithArray:[self.bridgeDict objectForKey:bridge.bridgeName]];
        [ary removeObject:bridge];
        if ([ary count] == 0) {
            [self.bridgeDict removeObjectForKey:bridge.bridgeName];
        } else {
            [self.bridgeDict setObject:ary forKey:bridge.bridgeName];
        }
    }
}

@end
