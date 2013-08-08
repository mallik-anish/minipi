//
//  ViewController.m
//  CutImageFreeHand
//
//  Created by Lion User on 04/08/2013.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "ViewController.h"
#import "CutMethod.h"
#import "getCropImage.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
@property (retain,nonatomic)getCropImage *getImg;
@end

@implementation ViewController
@synthesize aryPoints,ctMthod,arr,getImg,data,lastScaleImage;
- (void)viewDidLoad
{
    [super viewDidLoad];
    ctMthod=[[CutMethod alloc] init];
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired=2;
    [self.vwCut addGestureRecognizer:doubleTap];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-touch Method
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    lastPoint=[touch locationInView:self.vwCut];
     self.aryPoints=[[NSMutableArray alloc] initWithCapacity:0];
    if(flag==0)
    self.arr=[[NSMutableArray alloc] initWithCapacity:0];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint currentPoint=[touch locationInView: self.vwCut];
    UIGraphicsBeginImageContext(self.vwCut.frame.size);
    [self.imgCut drawRect:CGRectMake(0, 0, self.vwCut.frame.size.width, self.vwCut.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    

    if(flag==0)
    {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
       CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.imgCut.image=UIGraphicsGetImageFromCurrentImageContext();
         data=UIImageJPEGRepresentation(UIGraphicsGetImageFromCurrentImageContext(), 1.0);
   // self.imgPrev.image=self.imgCut.image;
    UIGraphicsEndImageContext();
   // [self.aryPoints addObject:[NSValue valueWithCGPoint:currentPoint]];
    lastPoint=currentPoint;
       
    }
    else
    {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 0.0, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.imgCut.image=UIGraphicsGetImageFromCurrentImageContext();
       // self.imgPrev=self.imgCut.image;
        UIGraphicsEndImageContext();
        [self.aryPoints addObject:[NSValue valueWithCGPoint:currentPoint]];
        lastPoint=currentPoint;
    }
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch=[touches anyObject];
    CGPoint currentPoint=[touch locationInView: self.vwCut];
    UIGraphicsBeginImageContext(self.vwCut.frame.size);
    [self.imgCut drawRect:CGRectMake(0, 0, self.vwCut.frame.size.width, self.vwCut.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    if(flag==0)
    {
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.imgCut.image=UIGraphicsGetImageFromCurrentImageContext();
   // self.imgPrev.image=self.imgCut.image;
     data=UIImagePNGRepresentation(self.imgCut.image);
        [self.arr addObject:data];
       
    UIGraphicsEndImageContext();
    lastPoint=currentPoint;
        
        
    }
    else
    {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 0.0, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.imgCut.image=UIGraphicsGetImageFromCurrentImageContext();
        //self.imgPrev=self.imgCut.image;
        UIGraphicsEndImageContext();
        lastPoint=currentPoint;
       
        
       self.imgCut.image=[UIImage imageWithData:[self.arr objectAtIndex:0]];
        
        // call method for cut image
        
        NSArray *aryCropImg=[ctMthod getCropImage:self.imgCut aryPoints:self.aryPoints];// get cut image
       
        UIImageView  *imgcut=[[UIImageView alloc] initWithFrame:CGRectMake([[aryCropImg objectAtIndex:1] floatValue], [[aryCropImg objectAtIndex:2] floatValue], [[aryCropImg objectAtIndex:3] floatValue], [[aryCropImg objectAtIndex:4] floatValue])];
        imgcut.image=[aryCropImg objectAtIndex:0];
        imgcut.tag=100;
        [imgcut setUserInteractionEnabled:YES];
        
        //set pinch and pan gester to image to move
        UIPanGestureRecognizer *p1 =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanImage:)];
        [p1 setDelegate:self];
        [imgcut addGestureRecognizer:p1];
        [p1 release];
        
        
        UIPinchGestureRecognizer *p1pinch =[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleScaleImage:)];
        [p1pinch setDelegate:self];
        [imgcut addGestureRecognizer:p1pinch];
        [p1pinch release];
        [self.vwCut addSubview:imgcut];
       
        self.imgCut.image=[ctMthod setCutBackgroundImage:self.imgCut aryPoints:self.aryPoints]; // get clear c
        data=UIImagePNGRepresentation(self.imgCut.image);
        [self.arr removeAllObjects];
        [self.arr addObject:data];
    }
}
#pragma mark-gestureMethod
- (IBAction)handlePanImage:(UIPanGestureRecognizer *)sender{
    if([(UIPanGestureRecognizer *)sender state] == UIGestureRecognizerStateBegan) {
        
        [self.vwCut bringSubviewToFront:sender.view];
        
    }
    CGPoint translation = [sender translationInView:self.vwCut];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                     sender.view.center.y + translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.vwCut];
    

}
- (IBAction)handleScaleImage:(UIPinchGestureRecognizer *)sender{
    if([(UIPinchGestureRecognizer *)sender state] == UIGestureRecognizerStateBegan) {
        
        [self.view bringSubviewToFront:sender.view];
        self.lastScaleImage = 1.0;
    }
    CGFloat scale = 1.0 - (self.lastScaleImage - [(UIPinchGestureRecognizer *)sender scale]);
    
    CGAffineTransform currentTransform = sender.view.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [sender.view setTransform:newTransform];
    
    self.lastScaleImage = [(UIPinchGestureRecognizer*)sender scale];
}
//method to make final image on double tap and save
-(void)removeImage
{
    UIGraphicsBeginImageContext(self.vwCut.frame.size);
    [self.vwCut.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imgFinal=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imgCut.image=imgFinal;
    
    data=UIImagePNGRepresentation(self.imgCut.image);
    [self.arr removeAllObjects];
    [self.arr addObject:data];
for(UIView *subView in [self.vwCut subviews])
   {
     if([subView isKindOfClass:[UIImageView class]])
     {
         UIImageView *img=(UIImageView *)subView;
         if(img.tag==100)
         {
             [subView removeFromSuperview];
         }
     }
   }
}
-(void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    
    [self removeImage];
    
}
- (void)dealloc {
    [_vwCut release];
    [_imgCut release];
   
    [super dealloc];
}
- (IBAction)btnWrite:(id)sender {
    flag=0;
}

- (IBAction)btnCut:(id)sender {
    
    flag=1;
}
@end
