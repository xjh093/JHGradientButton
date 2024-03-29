//
//  JHGradientButton.h
//  JHKit
//
//  Created by HaoCold on 2023/3/28.
//  从左到右，背景渐变的按钮

#import <UIKit/UIKit.h>

@interface JHGradientButton : UIButton

/// #DCE35B -> #45B649
+ (instancetype)gradientButton:(CGSize)size title:(NSString *)title;
/// 任意 2 种颜色
+ (instancetype)gradientButton:(CGSize)size title:(NSString *)title colors:(NSArray *)colors;
+ (instancetype)gradientButton:(CGSize)size title:(NSString *)title image:(UIImage *)image colors:(NSArray *)colors;

/// 添加更多渐变背景色
- (void)addGradientColors:(NSArray *)colors;
/// 展示第几个渐变背景色
- (void)showGradientColor:(NSInteger)index;

@end
