//
//  LYSCommonWKWebStatus.m
//  LYSCommonWKWebKitDemo
//
//  Created by 李阳帅 on 2019/10/25.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWKWebStatus.h"

#define NETWORDNOT @"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z7Mko9u3W7t/9Ed/9F+0qKxLkUm3Asy6PmmStcf1LJX2VtpbaW/xHo+SURa2w3bYLqNRdi/shb07d6od1A5qh+PHX/ZtXAGUcxTjFOMU4z76iBWTtELloN/gN/gtPl5VW1VbVdtyabC1X2q/1H558CDGYAzGbNtm8XEVg/Cm8Kbw5oIF5oX+DM4FzgXOBbNmyZvK7MEDUSfqRN2rK0yeEaiCwO6l3dxY+vEff6Rv6Vv6tmXLMuug6Bsm/2T+yfyTH37YaGejnY12Pnpk6XFJ2W3FEDFEDLl4kSW4UKks3e+zSMlhqQ/1oT7HjmEIhmBIs2asYlHJax6WWi5v9EbvwMCSVpLiCqCCIVU0KvAs8Czw/PRTsiM7svvsM/AET/B8cZpoM0VJUKkrdaWus2drqmiqaKps3ChXHQNWhLRFC8UhxSHFoV9+MWe/fU2RclCqM9QZ6oxpJfbA4AqggpMZnBmcGezgkD80f2j+0G7dIBZiIbZjRzKSkYyurvgIH+Ejk4ku0SW6lJaGj/ExPk5IUNmr7FX2p069aq05S6Nfp1+nX9etGwRAAATs2yfdz8stl7XAL/AL/GLDBtVa1VrV2g8/LK1C5gqAUy5JpVRKJR8fwSAYBIN0CyFVxqmA/A6/w+/ffZfeOb1zeueQkOIyFL0qXAFwyjWsFl7TpjSIBtGgnTvhHtyDe56ecstVWsyenrWhNtSeNo2Vhy97oyu/BeCUa1iNxStXCnYU7CjY0aoVS4Ipo39EaSnyLMTzeB7Pd+5sqYUvwXcAnAqJIc+QZ8jr3BnqQT2ot3w5HaNjdKxVK7nleo5USIXU3FwMwzAMW7r0cbPHzR43i4pityxPn1q6e64AOK8Fuvu6+7r7vXsLs4XZwuwJE6gKVaEqPXpYO5kndsAO2EGno1N0ik7FxoorxBXiim+/9Vzlucpz1V9/WXteuALgvJak9UzrmdbT1bWwa2HXwq6+vnANrsG1rl3xIT7Eh+3bl7hQyTyYB/P+/hu343bcfukSzISZMDMhASMwAiP277e1knFcAXA4/wXmd+DoqPxd+bvyd5XK1NHU0dTR2Vk4IZwQTlStChfhIlzMz8f+2B/7P3xo6mHqYeqRman11/pr/eWP0uRwOBwOh8PhcDgcDofD4XA4HA6Hw+FwOBwOh8PhcDgcDofD4XA4HA6Hw+FwOBWM/wdaadRUCP0C8wAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxOS0xMC0yNVQxMDo1MDo0MCswODowMLK2ALkAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTktMTAtMjVUMTA6NTA6NDArMDg6MDDD67gFAAAAUXRFWHRzdmc6YmFzZS11cmkAZmlsZTovLy9ob21lL2FkbWluL2ljb24tZm9udC90bXAvaWNvbl9wamIyenVibm1obi93YW5nbHVvZ3V6aGFuZy5zdmfPHnxIAAAAAElFTkSuQmCC"

@interface LYSCommonWKWebStatus ()

@end

@implementation LYSCommonWKWebStatus

- (UIImageView *)netIcon
{
    if (!_netIcon) {
        NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:NETWORDNOT options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        _netIcon = [[UIImageView alloc] initWithImage:[UIImage imageWithData:decodeData]];
    }
    return _netIcon;
}
- (UILabel *)netDesLabel
{
    if (!_netDesLabel) {
        _netDesLabel = [[UILabel alloc] init];
        _netDesLabel.text = @"加载失败,请稍等重试!";
        _netDesLabel.font = [UIFont systemFontOfSize:15];
        _netDesLabel.textColor = [UIColor grayColor];
        _netDesLabel.textAlignment = NSTextAlignmentCenter;
        _netDesLabel.numberOfLines = 3;
    }
    return _netDesLabel;
}
- (UIButton *)netRefreshBtn
{
    if (!_netRefreshBtn) {
        _netRefreshBtn = [[UIButton alloc] init];
        [_netRefreshBtn setTitle:@"点击刷新" forState:(UIControlStateNormal)];
        _netRefreshBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _netRefreshBtn.layer.borderWidth = 1;
        _netRefreshBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _netRefreshBtn.layer.masksToBounds = YES;
        _netRefreshBtn.layer.cornerRadius = 5;
        [_netRefreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _netRefreshBtn;
}
- (UIView *)netContent
{
    if (!_netContent) {
        _netContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        if (self.netIcon) {
            [self.netIcon removeFromSuperview];
            self.netIcon = nil;
        }
        self.netIcon.frame = CGRectMake(CGRectGetWidth(_netContent.frame)/2-80/2, 0, 80, 80);
        [_netContent addSubview:self.netIcon];
        if (self.netDesLabel) {
            [self.netDesLabel removeFromSuperview];
            self.netDesLabel = nil;
        }
        self.netDesLabel.frame = CGRectMake(0, CGRectGetMaxY(self.netIcon.frame)+10, 200, 50);
        [_netContent addSubview:self.netDesLabel];
        if (self.netRefreshBtn) {
            [self.netRefreshBtn removeFromSuperview];
            self.netRefreshBtn = nil;
        }
        self.netRefreshBtn.frame = CGRectMake(20, CGRectGetMaxY(self.netDesLabel.frame)+10, 160, 35);
        [_netContent addSubview:self.netRefreshBtn];
    }
    return _netContent;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showNetIcon = YES;
        self.showNetDesLabel = YES;
        self.showNetRefreshBtn = YES;
        self.netContent.frame = CGRectMake(CGRectGetWidth(self.frame)/2-200/2, CGRectGetHeight(self.frame)*(1-0.618)-100, 200, 200);
        [self addSubview:self.netContent];
        [self.netDesLabel addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"showNetIcon" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"showNetDesLabel" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"showNetRefreshBtn" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"] && [object isEqual:self.netDesLabel]) {
        CGFloat w = CGRectGetWidth( self.netContent.bounds);
        CGSize size = [change[NSKeyValueChangeNewKey] boundingRectWithSize:CGSizeMake(w-40, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        self.netDesLabel.frame = CGRectMake(0, CGRectGetMaxY(self.netIcon.frame)+10, w, size.height);
        self.netRefreshBtn.frame = CGRectMake(20, CGRectGetMaxY(self.netDesLabel.frame)+10, 160, 35);
        CGFloat height = CGRectGetHeight(self.netIcon.frame) + 10 + CGRectGetHeight(self.netDesLabel.frame) + 10 + CGRectGetHeight(self.netRefreshBtn.frame) + 10;
        self.netContent.frame = CGRectMake(CGRectGetWidth(self.frame)/2-200/2, CGRectGetHeight(self.frame)*(1-0.618)-(height/2), 200, height);
    }
    if ([keyPath isEqualToString:@"showNetIcon"] && [object isEqual:self]) {
        BOOL show = [change[NSKeyValueChangeNewKey] boolValue];
        if (!show) {
            [self.netIcon removeFromSuperview];
            self.netDesLabel.frame = CGRectMake(0, 10, CGRectGetWidth(self.netDesLabel.frame), CGRectGetHeight(self.netDesLabel.frame));
            self.netRefreshBtn.frame = CGRectMake(20, CGRectGetMaxY(self.netDesLabel.frame)+10, 160, 35);
            CGFloat height = 10 + CGRectGetHeight(self.netDesLabel.frame) + 10 + CGRectGetHeight(self.netRefreshBtn.frame) + 10;
            self.netContent.frame = CGRectMake(CGRectGetWidth(self.frame)/2-200/2, CGRectGetHeight(self.frame)*(1-0.618)-(height/2), 200, height);
        }
    }
    if ([keyPath isEqualToString:@"showNetDesLabel"] && [object isEqual:self]) {
        BOOL show = [change[NSKeyValueChangeNewKey] boolValue];
        if (!show) {
            [self.netDesLabel removeFromSuperview];
            self.netRefreshBtn.frame = CGRectMake(20, CGRectGetMaxY(self.netIcon.frame)+10, 160, 35);
            CGFloat height = CGRectGetHeight(self.netIcon.frame) + 10 + CGRectGetHeight(self.netRefreshBtn.frame) + 10;
            self.netContent.frame = CGRectMake(CGRectGetWidth(self.frame)/2-200/2, CGRectGetHeight(self.frame)*(1-0.618)-(height/2), 200, height);
        }
    }
    if ([keyPath isEqualToString:@"showNetRefreshBtn"] && [object isEqual:self]) {
        BOOL show = [change[NSKeyValueChangeNewKey] boolValue];
        if (!show) {
            [self.netRefreshBtn removeFromSuperview];
            CGFloat height = CGRectGetHeight(self.netIcon.frame) + 10 + CGRectGetHeight(self.netDesLabel.frame) + 10;
            self.netContent.frame = CGRectMake(CGRectGetWidth(self.frame)/2-200/2, CGRectGetHeight(self.frame)*(1-0.618)-(height/2), 200, height);
        }
    }
}

- (void)dealloc
{
    [self.netDesLabel removeObserver:self forKeyPath:@"text"];
}

@end
