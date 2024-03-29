//
//  JHGradientButton.m
//  JHKit
//
//  Created by HaoCold on 2023/3/28.
//

#import "JHGradientButton.h"
#import "UIView+JHDrawCategory.h"

#define kUIColorFromHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIButton (JHGradientBackgroundColor)
- (CALayer *)gradientBackgroundColor:(NSArray <UIColor *>*)colors;
@end

@implementation UIButton (JHGradientBackgroundColor)

- (CALayer *)gradientBackgroundColor:(NSArray <UIColor *>*)colors
{
    if (colors.count == 0) {
        return nil;
    }
    
    for (UIColor *color in colors) {
        if (![color isKindOfClass:[UIColor class]]) {
            return nil;
        }
    }
    
    if (colors.count == 1) {
        self.backgroundColor = colors[0];
    }
    
    CALayer *layer = [self jh_gradientLayer:self.bounds color:colors location:@[@(0.3)] direction:CAGradientLayerDirection_FromLeftToRight];
    //NSLog(@"%@:\n%@",self.titleLabel.text,self.layer.sublayers);
    
    if (self.currentTitle) {
        [self.layer insertSublayer:layer below:self.titleLabel.layer];
    }
    if (self.currentImage) {
        [self.layer insertSublayer:layer below:self.imageView.layer];
    }
    
    return layer;
}

@end

@interface JHGradientButton()
/// 添加了多个渐变色，用于切换
@property (nonatomic,  strong) NSMutableArray *customLayers;

@end

@implementation JHGradientButton

+ (instancetype)gradientButton:(CGSize)size title:(NSString *)title
{
    JHGradientButton *button = [self gradientButton:size title:title colors:@[kUIColorFromHex(0xDCE35B), kUIColorFromHex(0x45B649)]];
    return button;
}

+ (instancetype)gradientButton:(CGSize)size title:(NSString *)title colors:(NSArray *)colors
{
    return [self gradientButton:size title:title image:nil colors:colors];
}

+ (instancetype)gradientButton:(CGSize)size title:(NSString *)title image:(UIImage *)image colors:(NSArray *)colors
{
    JHGradientButton *button = [JHGradientButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = CGRectGetHeight(button.frame) * 0.5;
    [button setImage:image forState:0];
    [button setTitle:title forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    CALayer *layer = [button gradientBackgroundColor:colors];
    
    if (layer) {
        [button.customLayers addObject:layer];
    }
    
    return button;
}

- (void)addGradientColors:(NSArray *)colors
{
    CALayer *layer = [self gradientBackgroundColor:colors];
    
    if (layer) {
        [self.customLayers addObject:layer];
    }
}

- (void)showGradientColor:(NSInteger)index
{
    if (index < self.customLayers.count) {
        [self.customLayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL * _Nonnull stop) {
            layer.hidden = YES;
        }];
        
        CALayer *layer = self.customLayers[index];
        layer.hidden = NO;
    }
}

- (NSMutableArray *)customLayers{
    if (!_customLayers) {
        _customLayers = @[].mutableCopy;
    }
    return _customLayers;
}

@end
