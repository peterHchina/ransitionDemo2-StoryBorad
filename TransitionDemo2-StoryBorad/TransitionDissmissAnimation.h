//
//  TransitionDissmissAnimation.h
//  
//
//  Created by vivo on 16/3/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

 typedef NS_ENUM(NSInteger,TransitionAnimationType){
    TransitionAnimationNone =0,
    TransitionAnimationNetEasy,
    TransitionAnimationTecent
};

@interface TransitionDissmissAnimation : NSObject<UIViewControllerAnimatedTransitioning>
-(id) initWithTransition:(TransitionAnimationType) transition;
@end
