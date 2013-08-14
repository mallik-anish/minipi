//
//  ViewController.h
//  CutImageFreeHand
//
//  Created by Anish Mallik on 04/08/2013.
//  Copyright (c) 2013 Anish Mallik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CutMethod.h"
@interface ViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CGPoint lastPoint;
    int flag;
}
@property (retain, nonatomic) IBOutlet UIView *vwCut;
@property (retain, nonatomic) IBOutlet UIImageView *imgCut;
@property(retain,nonatomic)NSMutableArray *aryPoints;
- (IBAction)btnWrite:(id)sender;

- (IBAction)btnCut:(id)sender;
@property(retain,nonatomic)CutMethod *ctMthod;

@property(retain,nonatomic)NSMutableArray *arr;
@property(retain,nonatomic)NSData *data;
@property (nonatomic) CGFloat lastScaleImage;
- (IBAction)handlePanImage:(UIPanGestureRecognizer *)sender;
- (IBAction)handleScaleImage:(UIPinchGestureRecognizer *)sender;
-(void)handleDoubleTap:(UITapGestureRecognizer *)sender;
@property(retain,nonatomic)NSArray *aryCropImg;
//-(void)handleDoubleTap1:(UITapGestureRecognizer *)sender;
@end
