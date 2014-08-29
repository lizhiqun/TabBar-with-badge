//
//  ViewController.m
//  NB2
//
//  Created by kohn on 13-11-16.
//  Copyright (c) 2013年 Kohn. All rights reserved.
//
#define SELECTED_VIEW_CONTROLLER_TAG 98456345
#define NOTIFICATION_IMAGE_VIEW_TAG 98456346

#import "ViewController.h"
#import "MyNBTabController.h"
#import "MyNBTabButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (tabBar) {
        [tabBar removeFromSuperview];
    }
    self.view.backgroundColor = [UIColor grayColor];
    MyNBTabController *vc1 = [[MyNBTabController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
    MyNBTabController *vc2 = [[MyNBTabController alloc]init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    MyNBTabController *vc3 = [[MyNBTabController alloc]init];
    vc3.view.backgroundColor = [UIColor blueColor];
    MyNBTabController *vc4 = [[MyNBTabController alloc]init];
    vc4.view.backgroundColor = [UIColor whiteColor];
    currentVC = vc1;
    
    [self.view insertSubview:vc1.view belowSubview:tabBar];
    [self.view insertSubview:vc2.view belowSubview:tabBar];
    [self.view insertSubview:vc3.view belowSubview:tabBar];
    [self.view insertSubview:vc4.view belowSubview:tabBar];
    
    MyNBTabButton *t1 = [[MyNBTabButton alloc] initWithIcon:[UIImage imageNamed:@"timelineIcon"]];
   
    t1.highlightedIcon = [UIImage imageNamed:@"timelineIconHighlighted"];
    t1.viewController = vc1;
    
    MyNBTabButton *t2 = [[MyNBTabButton alloc] initWithIcon:[UIImage imageNamed:@"mentionsIcon"]];
    t2.highlightedIcon = [UIImage imageNamed:@"mentionsIconHighlighted"];
    t2.viewController = vc2;
    
    MyNBTabButton *t3 = [[MyNBTabButton alloc] initWithIcon:[UIImage imageNamed:@"messagesIcon"]];
    t3.highlightedIcon = [UIImage imageNamed:@"messagesIconHighlighted"];
    t3.viewController = vc3;
    
    MyNBTabButton *t4 = [[MyNBTabButton alloc] initWithIcon:[UIImage imageNamed:@"searchIcon"]];
    t4.highlightedIcon = [UIImage imageNamed:@"searchIconHighlighted"];
    t4.viewController = vc4;
    
    NSArray *a = [NSArray arrayWithObjects:t1, t2,t3, t4, nil];
    tabBar = [[MyNBTabBar alloc] initWithItems:a];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    [tabBar showIndex:0];
    
}


-(void)switchViewController:(MyNBTabController *)viewController {
    UIView *currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    currentView = nil;
    
    viewController.view.frame = CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height-tabBar.frame.size.height);
    
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    
    [self.view insertSubview:viewController.view belowSubview:tabBar];
    if (currentVC == viewController) {
        [viewController.tabBarButton addNotification:[NSDictionary dictionary]];
    }else{
        
        [currentVC.tabBarButton clearNotifications];
        
        [viewController.tabBarButton addNotification:[NSDictionary dictionary]];
        currentVC = viewController;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
