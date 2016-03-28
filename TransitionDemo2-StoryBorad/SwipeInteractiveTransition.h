//
//  SwipeInteractiveTransition.h
//  
//
//  Created by vivo on 16/3/24.
//
//

#import <UIKit/UIKit.h>

@interface SwipeInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign) BOOL isInteraction;
-(void) wireToViewController:(UIViewController *) viewController;
@end
