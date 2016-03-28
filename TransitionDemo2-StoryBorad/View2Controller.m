//
//  View2Controller.m
//  TransitionDemo2-StoryBorad
//
//  Created by vivo on 16/3/25.
//  Copyright © 2016年 vivo. All rights reserved.
//

#import "View2Controller.h"
#import "BaseTableViewCell.h"
#import "View3Controller.h"
@interface View2Controller ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation View2Controller
{
    NSArray *dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButton];
    [self.tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"view2Cell"];
    dataList = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataList count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *cellTag = @"view2Cell";
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellTag];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"present2" sender:self];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseTableViewCell *baseCell = (BaseTableViewCell*) cell;
    
    baseCell.contentLable.text = [dataList objectAtIndex:indexPath.row];
    baseCell.contentView.backgroundColor = [UIColor purpleColor];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"present2"]) {
        
        UINavigationController *ViewController = segue.destinationViewController;
        [self preparePresentViewController:ViewController];
    }
}
@end
