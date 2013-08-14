//
//  getCropImage.m
//  CutImageFreeHand
//
//  Created by Anish Mallik on 04/08/2013.
//  Copyright (c) 2013 Anish Mallik. All rights reserved.
//

#import "getCropImage.h"

@implementation getCropImage
@synthesize minX,minY,maxX,maxY;
+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2
{
    point1.y = rect1.height - point1.y;
    CGPoint result = CGPointMake((point1.x*rect2.width)/rect1.width, (point1.y*rect2.height)/rect1.height);
    return result;
}
-(void)getCoordinateValue:(NSMutableArray *)aryData
{
    minX=[[aryData objectAtIndex:0] CGPointValue].x;
    minY=[[aryData objectAtIndex:0] CGPointValue].y;
     maxX=[[aryData objectAtIndex:0] CGPointValue].x;
     maxY=[[aryData objectAtIndex:0] CGPointValue].y;
    
    for (int i=0; i<aryData.count; i++) {
        if(maxX < [[aryData objectAtIndex:i] CGPointValue].x)maxX=[[aryData objectAtIndex:i] CGPointValue].x;
        if(maxY < [[aryData objectAtIndex:i] CGPointValue].y)maxY=[[aryData objectAtIndex:i] CGPointValue].y;
        
        if(minX > [[aryData objectAtIndex:i] CGPointValue].x)minX=[[aryData objectAtIndex:i] CGPointValue].x;
        if(minY > [[aryData objectAtIndex:i] CGPointValue].y)minY=[[aryData objectAtIndex:i] CGPointValue].y;
        
    }
       
}
-(NSArray *)getCropImage:(UIImageView *)mainImage aryPoint:(NSMutableArray *)cropImgSelect borderImg:(UIImageView *)borderImg
{
    NSArray *aryPnt=cropImgSelect;
    CGRect rect=CGRectZero;
    rect.size=mainImage.image.size;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    {
        [[UIColor blackColor] setFill];
        UIRectClip(rect);
        [[UIColor whiteColor] setFill];
        UIBezierPath *aPath=[UIBezierPath bezierPath];
        CGPoint pnt=[getCropImage convertCGPoint:[[aryPnt objectAtIndex:0] CGPointValue] fromRect1:mainImage.frame.size toRect2:mainImage.frame.size];
        [aPath moveToPoint:CGPointMake(pnt.x, pnt.y)];
        for(uint i=0;i<aryPnt.count;i++)
        {
            CGPoint pnt=[getCropImage convertCGPoint:[[aryPnt objectAtIndex:i] CGPointValue] fromRect1:mainImage.frame.size toRect2:mainImage.frame.size];
            [aPath addLineToPoint:CGPointMake(pnt.x, pnt.y)];
            
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
    UIGraphicsEndImageContext();
    
   [self getCoordinateValue:cropImgSelect];
    
    //get border image
    UIImage *borderMask=[self getBorderImage:borderImg aryPoint:cropImgSelect];
    
    
    
    
    
    
    CGImageRef imag=CGImageCreateWithImageInRect(maskImage.CGImage, CGRectMake(minX, minY, (maxX - minX), (maxY - minY)));
    //crop border image
    CGImageRef imagBorder=CGImageCreateWithImageInRect(borderMask.CGImage, CGRectMake(minX, minY, (maxX - minX), (maxY - minY)));
    
    NSArray *array=[NSArray arrayWithObjects:[UIImage imageWithCGImage:imag],[NSString stringWithFormat:@"%f",minX],[NSString stringWithFormat:@"%f",minY],[NSString stringWithFormat:@"%f",(maxX-minX)],[NSString stringWithFormat:@"%f",(maxY-minY)],[UIImage imageWithCGImage:imagBorder], nil];
    NSLog(@"%d",array.count);
    return array;
    
}
-(UIImage *)getBorderImage:(UIImageView *)borderImg aryPoint:(NSMutableArray *)aryPoint
{
    NSArray *aryPnt=aryPoint;
    CGRect rect=CGRectZero;
    rect.size=borderImg.image.size;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    {
        [[UIColor blackColor] setFill];
        UIRectClip(rect);
        [[UIColor whiteColor] setFill];
        UIBezierPath *aPath=[UIBezierPath bezierPath];
        CGPoint pnt=[getCropImage convertCGPoint:[[aryPnt objectAtIndex:0] CGPointValue] fromRect1:borderImg.frame.size toRect2:borderImg.frame.size];
        [aPath moveToPoint:CGPointMake(pnt.x, pnt.y)];
        for(uint i=0;i<aryPnt.count;i++)
        {
            CGPoint pnt=[getCropImage convertCGPoint:[[aryPnt objectAtIndex:i] CGPointValue] fromRect1:borderImg.frame.size toRect2:borderImg.frame.size];
            [aPath addLineToPoint:CGPointMake(pnt.x, pnt.y)];
            
        }
        [aPath closePath];
        [aPath fill];
        
    }
    UIImage *mask=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [borderImg.image drawAtPoint:CGPointZero];
    }
    
    UIImage *maskImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return maskImage;

}
@end
    
    
