//
//  getCropImage.h
//  CutImageFreeHand
//
//  Created by Lion User on 04/08/2013.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getCropImage : NSObject
+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2;
-(NSArray *)getCropImage:(UIImageView *)mainImage aryPoint:(NSMutableArray *)cropImgSelect;
-(void)getCoordinateValue:(NSMutableArray *)aryData;
@property(nonatomic)float minX;
@property(nonatomic)float minY;
@property(nonatomic)float maxX;
@property(nonatomic)float maxY;

@end
