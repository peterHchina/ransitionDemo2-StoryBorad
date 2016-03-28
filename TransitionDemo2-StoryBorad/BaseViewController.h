//
//  BaseViewController.h
//  
//
//  Created by vivo on 16/3/24.
//
//

#import <UIKit/UIKit.h>
@protocol dismissViewControlerDelegate <NSObject>
-(void) modalViewControllerDidClickedDismissButton:(UIViewController *)viewController;
@end

@interface BaseViewController : UIViewController<UIViewControllerTransitioningDelegate,dismissViewControlerDelegate>
@property (nonatomic,retain) id<dismissViewControlerDelegate> delegate;
- (void)showBackButton;
-(void) setDefaultNavigationBar;
-(void) setBarTitleApperanceTitleColor:(UIColor*) titleColor WithTintColor:(UIColor *) tintColor AndBarTintBarColor:(UIColor *) barTintColor AndTitleFontSize:(NSString *) fontSize;
-(void) dissmissPresentedViewController;
-(void) ModelPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
-(void) preparePresentViewController:(UIViewController *)viewControllerToPresent;
@end
