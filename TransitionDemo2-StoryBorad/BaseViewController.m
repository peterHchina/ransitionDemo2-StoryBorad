//
//  BaseViewController.m
//  
//
//  Created by vivo on 16/3/24.
//
//

#import "BaseViewController.h"
#import "TransitionDissmissAnimation.h"
#import "TransitionPresentAnimation.h"
#import "SwipeInteractiveTransition.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
{
    TransitionDissmissAnimation *dissmissAnimation;
    TransitionPresentAnimation *presentAnimation;
    SwipeInteractiveTransition *swipeTransition;
}

-(id) init{
    self = [super init];
    if (self) {
        dissmissAnimation = [[TransitionDissmissAnimation alloc] initWithTransition:TransitionAnimationNone];
        presentAnimation = [[TransitionPresentAnimation alloc] initWithTransition:TransitionAnimationNone];
        swipeTransition = [SwipeInteractiveTransition new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dissmissAnimation = [[TransitionDissmissAnimation alloc] initWithTransition:TransitionAnimationTecent];
    presentAnimation = [[TransitionPresentAnimation alloc] initWithTransition:TransitionAnimationTecent];
    swipeTransition = [SwipeInteractiveTransition new];
    [self setDefaultNavigationBar];
    //统一设置导航状态栏文字颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBackButton
{
    [self createLeftBarButtonItemWithNormalImage:@"btn_back" highlightImage:@"btn_back_clicked" titleText:nil];
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
}

-(void) setDefaultNavigationBar{
    [self setBarTitleApperanceTitleColor:nil WithTintColor:nil AndBarTintBarColor:nil AndTitleFontSize:nil];
}

-(void) setBarTitleApperanceTitleColor:(UIColor*) titleColor WithTintColor:(UIColor *) tintColor AndBarTintBarColor:(UIColor *) barTintColor AndTitleFontSize:(NSString *) fontSize{
    if (!tintColor) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        self.navigationController.navigationBar.tintColor = tintColor;
    }
    
    if (!barTintColor) {
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    }else{
        self.navigationController.navigationBar.barTintColor = tintColor;
    }
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary new];
    if (titleColor) {
        [attributeDict setObject:titleColor forKey:NSForegroundColorAttributeName];
    }else{
        [attributeDict setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    }
    
    if (!fontSize || fontSize.integerValue<=0) {
        [attributeDict setObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName];
    }else{
        [attributeDict setObject:[UIFont systemFontOfSize:fontSize.integerValue] forKey:NSFontAttributeName];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributeDict];
}

//左上角barButtonItem 按钮自定义
- (void)createLeftBarButtonItemWithNormalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage titleText:(NSString *) title
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    CGFloat imageleft = -30;
    CGFloat titleleft = -29;
    if (title!=nil && title.length!=0) {
        [btn setTitle:title forState:UIControlStateHighlighted];
        [btn setTitle:title forState:UIControlStateNormal];
        
    }
    else
    {
        [btn setTitle:NSLocalizedString(@"back", nil) forState:UIControlStateHighlighted];
        [btn setTitle:NSLocalizedString(@"back", nil) forState:UIControlStateNormal];
        title = NSLocalizedString(@"back", nil);
    }
    
    if (title!=nil && title.length!=0)
    {
        if (title.length == 1) {
            
            imageleft =-60;
            titleleft = -59;
        }
        else if (title.length == 2)
        {
            imageleft =-46;
            titleleft = -45;
        }
        else if (title.length ==3)
        {
            imageleft =-30;
            titleleft = -29;
        }
        else
        {
            imageleft =-17.5;
            titleleft = -16.5;
        }
    }
    
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    
    
    
    btn.tag = 9;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, imageleft, 0, 0);
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, titleleft, 0, 0)];
    
    [btn addTarget:self action:@selector(dissmissPresentedViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

//代码转场到下一个Controller
-(void) ModelPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    viewControllerToPresent.transitioningDelegate = self;
    UINavigationController *viewController =  (UINavigationController *)viewControllerToPresent;
    BaseViewController * rootViewController =  (BaseViewController *)viewController.viewControllers[0];
    rootViewController.delegate = self;
    [swipeTransition wireToViewController:viewControllerToPresent];
    [self presentViewController:viewControllerToPresent animated:YES completion:^{
        
    }];

}

//StoryBoard转场到下一个Controller
-(void) preparePresentViewController:(UIViewController *)viewControllerToPresent{
    viewControllerToPresent.transitioningDelegate = self;
    UINavigationController *viewController =  (UINavigationController *)viewControllerToPresent;
    BaseViewController * rootViewController =  (BaseViewController *)viewController.viewControllers[0];
    rootViewController.delegate = self;
    [swipeTransition wireToViewController:viewControllerToPresent];
}

-(id <UIViewControllerAnimatedTransitioning> ) animationControllerForDismissedController:(UIViewController *)dismissed{
    return dissmissAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return presentAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>) interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return swipeTransition.isInteraction?swipeTransition:nil;
}

-(void) modalViewControllerDidClickedDismissButton:(UIViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) dissmissPresentedViewController{
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
        [self.delegate modalViewControllerDidClickedDismissButton:self];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
