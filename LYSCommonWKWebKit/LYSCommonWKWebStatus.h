//
//  LYSCommonWKWebStatus.h
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/25.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSCommonWKWebStatus : UIView
@property (nonatomic, strong) UIView * __nullable netContent;
@property (nonatomic, strong) UILabel * __nullable netDesLabel;
@property (nonatomic, strong) UIButton * __nullable netRefreshBtn;
@property (nonatomic, strong) UIImageView * __nullable netIcon;
@property (nonatomic, assign) BOOL showNetIcon;
@property (nonatomic, assign) BOOL showNetDesLabel;
@property (nonatomic, assign) BOOL showNetRefreshBtn;
@end

NS_ASSUME_NONNULL_END
