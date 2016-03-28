//
//  TransitionPresentAnimation.m
//  
//
//  Created by vivo on 16/3/24.
//
//

#import "TransitionPresentAnimation.h"

@implementation TransitionPresentAnimation
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
    
   
    CGRect fromVCInitFrame =[transitionContext initialFrameForViewController:fromVc];
    
    CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVc];
    toVc.view.frame = CGRectOffset(toVCFinalFrame, screenBounds.size.width, 0);
    
    CGRect  fromVCFinalFrame =CGRectOffset(fromVCInitFrame, -50, 0);
    CGAffineTransform fromVCTransform =  CGAffineTransformMakeScale(0.98,.98);

    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    
    NSTimeInterval durtion = [self transitionDuration:transitionContext];
    
        [UIView animateWithDuration:durtion animations:^{
            toVc.view.frame = toVCFinalFrame;
            if (animationType == TransitionAnimationNetEasy) {
                   fromVc.view.frame = fromVCFinalFrame;
                }else{
                  fromVc.view.transform = fromVCTransform;
              }
        } completion:^(BOOL finished) {
                       [transitionContext completeTransition:YES];
        }];
}

@end
