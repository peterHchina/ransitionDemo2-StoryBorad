//
//  View1ControllerViewController.m
//  TransitionDemo2-StoryBorad
//
//  Created by vivo on 16/3/25.
//  Copyright © 2016年 vivo. All rights reserved.
//

#import "View1Controller.h"
#import "View2Controller.h"
#import "BaseTableViewCell.h"
@interface View1Controller ()

@end

@implementation View1Controller
{
    NSArray * dataList;
}

-(id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if (self) {
        dataList = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     dataList = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"9",@"9",@"9",@"9",@"9",@"9",@"9",@"9",@"9"];
    // Do any additional setup after loading the view.
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
    static  NSString *cellTag = @"view1Cell";
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellTag];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   // View2Controller *secondController = [[View2Controller alloc] init];
    //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:secondController];
    
    //[self ModelPresentViewController:navController animated:YES completion:nil];
    [self performSegueWithIdentifier:@"present" sender:self];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseTableViewCell *baseCell = (BaseTableViewCell*) cell;
    
    baseCell.contentLable.text = [dataList objectAtIndex:indexPath.row];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"present"]) {
        
        UINavigationController *ViewController = segue.destinationViewController;
        [self preparePresentViewController:ViewController];
    }
}

@end
