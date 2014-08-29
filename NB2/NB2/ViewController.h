//
//  ViewController.h
//  NB2
//
//  Created by kohn on 13-11-16.
//  Copyright (c) 2013年 Kohn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNBTabBar.h"

@class MyNBTabController;
@interface ViewController : UIViewController<MyNBTabBarDelegate>{
    MyNBTabBar *tabBar;
    MyNBTabController * currentVC;
}

@end
