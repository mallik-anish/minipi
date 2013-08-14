//
//  CutMethod.h
//  CutImageFreeHand
//
//  Created by Anish Mallik on 04/08/2013.
//  Copyright (c) 2013 Anish Mallik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getCropImage.h"
@interface CutMethod : NSObject
+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2;
-(UIImage *)setCutBackgroundImage:(UIImageView *)mainImage aryPoints:(NSMutableArray *)selectAryPoints;
-(NSArray *)getCropImage:(UIImageView *)mainImage  aryPoints:(NSMutableArray *)cutAryPoints borderImg:(UIImageView *)borderImg;
@property(retain,nonatomic)getCropImage *cpImage;
@end
