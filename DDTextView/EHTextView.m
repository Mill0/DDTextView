//
//  EHTextView.m
//
//
//  Created by Milo. on 15/7/8.
//  Copyright (c) 2015年 milodongg. All rights reserved.
//

#import "EHTextView.h"


#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface EHTextView ()
@property (nonatomic, strong) UIImageView *mShadowImageView;
@property (nonatomic, strong) UIImageView *mDepreciationImageView;
@property (nonatomic, copy) NSString *mText;
@property (nonatomic, assign) int rowHeight;
@end

@implementation EHTextView

- (instancetype)initWithFrame:(CGRect)frame addText:(NSString *)mText addRowHeight:(CGFloat)rowHeight
{
    self = [super initWithFrame:frame];

    if (self) {
        self.mText = mText;
        self.rowHeight = rowHeight;
        
        // 底部阴影
        self.mShadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + 4, self.frame.size.width, 3)];
        self.mShadowImageView.image = [UIImage imageNamed:@"buttomShadowBackImage_mine"];
        [self addSubview:self.mShadowImageView];
        
        // 折角
        self.mDepreciationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 55, self.frame.size.height - 33, 50, 33)];
        self.mDepreciationImageView.image = [UIImage imageNamed:@"buttomDepreciationBackImage_mine"];
        [self addSubview:self.mDepreciationImageView];
        
        // 调整位置
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = rowHeight;
        paragraphStyle.maximumLineHeight = rowHeight;
        paragraphStyle.minimumLineHeight = rowHeight;
        self.textContainerInset = UIEdgeInsetsMake(-(rowHeight - self.font.leading) * 0.25, 0, 0, 0);
        
        // 设置字体属性
        NSString *oneRowStr = [mText substringWithRange:NSMakeRange(0, [mText rangeOfString:@"\n"].location)];
        NSMutableAttributedString *prefixAttr = [[NSMutableAttributedString alloc] initWithString:mText];
        [prefixAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, mText.length)];
        [prefixAttr addAttribute:NSForegroundColorAttributeName value:HexRGB(0x919191) range:NSMakeRange(0, mText.length)];
        
        [prefixAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, oneRowStr.length)];
        [prefixAttr addAttribute:NSForegroundColorAttributeName value:HexRGB(0x0385ff) range:NSMakeRange(0, oneRowStr.length)];
        [prefixAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mText.length)];
        
        self.attributedText = prefixAttr;
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sizeContent = CGSizeMake(self.frame.size.width - 32, MAXFLOAT);
    sizeContent = [self.mText boundingRectWithSize:sizeContent
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                           context:nil].size;
    
    int row =  sizeContent.height/self.font.leading;
    CGRect tempRect = self.frame;
    tempRect.size.height = row * self.rowHeight + 3;
    self.frame = tempRect;

    self.mShadowImageView.frame = CGRectMake(0, self.frame.size.height + 4, self.frame.size.width - 32, 3);
    self.mDepreciationImageView.frame = CGRectMake(self.frame.size.width - 55, self.frame.size.height - 33, 50, 33);
}

- (void)setFont:(UIFont *)font
{
    // 调整位置
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = self.rowHeight;
    paragraphStyle.maximumLineHeight = self.rowHeight;
    paragraphStyle.minimumLineHeight = self.rowHeight;
    self.textContainerInset = UIEdgeInsetsMake(-(self.rowHeight - self.font.leading) * 0.25, 0, 0, 0);
    
    // 设置字体属性
    NSString *oneRowStr = [self.mText substringWithRange:NSMakeRange(0, [self.mText rangeOfString:@"\n"].location)];
    NSMutableAttributedString *prefixAttr = [[NSMutableAttributedString alloc] initWithString:self.mText];
    [prefixAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.mText.length)];
    [prefixAttr addAttribute:NSForegroundColorAttributeName value:HexRGB(0x919191) range:NSMakeRange(0, self.mText.length)];
    
    [prefixAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, oneRowStr.length)];
    [prefixAttr addAttribute:NSForegroundColorAttributeName value:HexRGB(0x3d3f41) range:NSMakeRange(0, oneRowStr.length)];
    [prefixAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.mText.length)];
    
    self.attributedText = prefixAttr;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    
    CGContextBeginPath(context);
    
    CGFloat rowH = self.rowHeight;
    NSUInteger numberOfLines =  (self.bounds.size.height - 3) / rowH;
    
    CGFloat baselineOffset = 0;
    
    for (int x = 1; x < numberOfLines + 1; x++) {
        
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        
        CGFloat lengthstest[] = {5,2};
        CGContextSetLineDash(context, 5, lengthstest,1);
        CGContextMoveToPoint(context, 5, rowH * x  + baselineOffset);
        
        CGFloat rowW = numberOfLines == x ? 50 : 0;
        CGContextAddLineToPoint(context, CGRectGetWidth(rect) - rowW - 5, rowH * x + baselineOffset);
       
        CGContextStrokePath(context);
    }
    
    CGContextStrokePath(context);
    
}
@end
