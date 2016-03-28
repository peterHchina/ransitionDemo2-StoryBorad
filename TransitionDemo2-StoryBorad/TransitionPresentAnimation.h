//
//  TransitionPresentAnimation.h
//  
//
//  Created by vivo on 16/3/24.
//
//

#import <Foundation/Foundation.h>
#import "TransitionDissmissAnimation.h"
@interface TransitionPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>
-(id) initWithTransition:(TransitionAnimationType) transition;
@end
