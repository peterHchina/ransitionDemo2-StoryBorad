//
//  TransitionDissmissAnimation.m
//  
//
//  Created by vivo on 16/3/24.
//
//

#import "TransitionDissmissAnimation.h"

@implementation TransitionDissmissAnimation
{
    TransitionAnimationType animationType;
}

-(id) initWithTransition:(TransitionAnimationType) transition{
   self =  [super init];
    if (self) {
        if (transition == TransitionAnimationNone) {
            animationType = TransitionAnimationNetEasy;
        }else{
            animationType = transition;
        }
        
    }
    return self;
}


-(NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .4;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect fromVCInitFrame = [transitionContext  initialFrameForViewController:fromVc];
    CGRect fromVCFinalFrame = CGRectOffset(fromVCInitFrame, screenBounds.size.width, 0);
    
   
    CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVc];
    CGAffineTransform toVCFinalTransform =  CGAffineTransformMakeScale(1.0,1.0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    [containerView sendSubviewToBack:toVc.view];
    
    NSTimeInterval durtion = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:durtion animations:^{
             fromVc.view.frame = fromVCFinalFrame;
         if (animationType == TransitionAnimationNetEasy) {
                 toVc.view.frame = toVCFinalFrame;
             }else{
                 toVc.view.transform = toVCFinalTransform;
             }
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
   
}
@end
