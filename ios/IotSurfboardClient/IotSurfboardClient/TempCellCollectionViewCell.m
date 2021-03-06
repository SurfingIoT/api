//
//  TempCellCollectionViewCell.m
//  joinIot
//
//  Created by Jose Lino Neto on 6/20/16.
//  Copyright © 2016 Construtor. All rights reserved.
//

#import "TempCellCollectionViewCell.h"

@implementation TempCellCollectionViewCell

-(void)drawRect:(CGRect)rect{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* backGroudGreen = [UIColor colorWithRed: 0.32 green: 0.8 blue: 0.321 alpha: 1];
    UIColor* textColorWhite = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* backGroundBlue = [UIColor colorWithRed: 0.42 green: 0.543 blue: 0.903 alpha: 1];
    UIColor* backGroundRed = [UIColor colorWithRed: 0.926 green: 0.046 blue: 0.046 alpha: 1];
    
    //// Image Declarations
    UIImage* snow = [UIImage imageNamed: @"snow.png"];
    
    //// Variable Declarations
    UIColor* expression = _tempValue == 25 ? backGroudGreen : (_tempValue > 25 ? backGroundRed : backGroundBlue);
    BOOL expression2 = _tempValue < 25;
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 355, 160)];
    [expression setFill];
    [rectanglePath fill];
    
    
    if (expression2)
    {
        //// Rectangle 2 Drawing
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 355, 160)];
        CGContextSaveGState(context);
        [rectangle2Path addClip];
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawTiledImage(context, CGRectMake(0, 0, snow.size.width, snow.size.height), snow.CGImage);
        CGContextRestoreGState(context);
    }
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(57, 48, 242, 63);
    NSMutableParagraphStyle* textStyle = [NSMutableParagraphStyle new];
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"ArialRoundedMTBold" size: 49], NSForegroundColorAttributeName: textColorWhite, NSParagraphStyleAttributeName: textStyle};
    
    CGFloat textTextHeight = [_cellValue boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, textRect);
    [_cellValue drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
    CGContextRestoreGState(context);
    
    
    //// Text 2 Drawing
    CGRect text2Rect = CGRectMake(118, 4, 232, 21);
    NSMutableParagraphStyle* text2Style = [NSMutableParagraphStyle new];
    text2Style.alignment = NSTextAlignmentRight;
    
    NSDictionary* text2FontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"ArialRoundedMTBold" size: UIFont.labelFontSize], NSForegroundColorAttributeName: textColorWhite, NSParagraphStyleAttributeName: text2Style};
    
    CGFloat text2TextHeight = [_sensorName boundingRectWithSize: CGSizeMake(text2Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text2FontAttributes context: nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, text2Rect);
    [_sensorName drawInRect: CGRectMake(CGRectGetMinX(text2Rect), CGRectGetMinY(text2Rect) + (CGRectGetHeight(text2Rect) - text2TextHeight) / 2, CGRectGetWidth(text2Rect), text2TextHeight) withAttributes: text2FontAttributes];
    CGContextRestoreGState(context);
}

-(void)atualizar{
    [self setNeedsDisplay];
}

@end
