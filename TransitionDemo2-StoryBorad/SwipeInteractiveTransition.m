//
//  SwipeInteractiveTransition.m
//  
//
//  Created by vivo on 16/3/24.
//
//

#import "SwipeInteractiveTransition.h"

@interface SwipeInteractiveTransition()
@property (nonatomic, assign) BOOL isComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation SwipeInteractiveTransition

-(void) wireToViewController:(UIViewController *) viewController{
    
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

-(void) prepareGestureRecognizerInView:(UIView *) view{
    UIPanGestureRecognizer * gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}


-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

-(void) handleGesture:(UIPanGestureRecognizer *) gecognizer{
    CGPoint translcation = [gecognizer translationInView:gecognizer.view.superview];
    CGPoint vatory = [gecognizer velocityInView:gecognizer.view.superview];
    switch (gecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteraction = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat francation = translcation.x/370.0;
            francation = fminf(fmaxf(francation, 0), 1.0);
            if (francation>0.4 || vatory.x>1500.0) {
                _isComplete = YES;
            }else{
                self.isComplete = NO;
            }

            [self updateInteractiveTransition:francation];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            self.isInteraction = NO;
            if (!_isComplete || gecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }else{
                [self finishInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}
@end
