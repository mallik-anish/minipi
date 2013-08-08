//
//  CutMethod.m
//  CutImageFreeHand
//
//  Created by Lion User on 04/08/2013.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "CutMethod.h"

@implementation CutMethod
@synthesize cpImage;
+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2
{
    point1.y = rect1.height - point1.y;
    CGPoint result = CGPointMake((point1.x*rect2.width)/rect1.width, (point1.y*rect2.height)/rect1.height);
    return result;


}
-(NSArray *)getCropImage:(UIImageView *)mainImage  aryPoints:(NSMutableArray *)cutAryPoints
{
    cpImage=[[getCropImage alloc] init];
   // NSLog(@"%d",[cpImage getCropImage:mainImage aryPoint:cutAryPoints].count);
    return [cpImage getCropImage:mainImage aryPoint:cutAryPoints];
}
-(UIImage *)setCutBackgroundImage:(UIImageView *)mainImage aryPoints:(NSMutableArray *)selectAryPoints{
    
    NSArray *points = selectAryPoints;
    NSLog(@"%d",points.count);
    CGRect rect = CGRectZero;
    rect.size = mainImage.image.size;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0 );
    {
        [[UIColor whiteColor]setFill];
        UIRectFill(rect);
        [[UIColor blackColor]setFill];
        UIBezierPath *aPath=[UIBezierPath bezierPath];
        CGPoint pnt=[CutMethod convertCGPoint:[[points objectAtIndex:0] CGPointValue] fromRect1:mainImage.frame.size toRect2:mainImage.frame.size];
        [aPath moveToPoint:CGPointMake(pnt.x, pnt.y)];
        for(uint i=0;i<points.count;i++)
        {
        CGPoint pntCnt=[CutMethod convertCGPoint:[[points objectAtIndex:i] CGPointValue] fromRect1:mainImage.frame.size toRect2:mainImage.frame.size];
            [aPath addLineToPoint:CGPointMake(pntCnt.x, pntCnt.y)];
        }
        [aPath closePath];
        [aPath fill];
    
    }
    UIImage *mask=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [mainImage.image drawAtPoint:CGPointZero];
        
    }
    UIImage *maskImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetImageFromCurrentImageContext();
    return maskImage;
}
@end
