//
//  MyNBTabButton.m
//  NB2
//
//  Created by kohn on 13-11-16.
//  Copyright (c) 2013年 Kohn. All rights reserved.
//

#import "MyNBTabButton.h"
@interface MyNBTabButton()

@property (nonatomic,strong) NSMutableArray *notifications;
@property (nonatomic,strong) MyNBTabNotification *light;

@end

@implementation MyNBTabButton
@synthesize notifications = _notifications, viewController = _viewController, light = _light, icon, highlightedIcon;

- (id)initWithIcon:(UIImage *)nIcon {
    self = [super init];
    if (self) {
        self.icon = nIcon;
        self.light = [[MyNBTabNotification alloc] initWithFrame:CGRectMake(0, 0, 24, 27)];
        self.notifications = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)setViewController:(MyNBTabController *)viewController {
    _viewController = viewController;
    self.viewController.tabBarButton = self;
}

- (MyNBTabNotification *)notificationView {
    return self.light;
}

- (void)addNotification:(NSDictionary *)notification {
    [self.notifications insertObject:notification atIndex:0];
    [self.light addNotifications:1];
}
- (void)removeNotification:(NSUInteger)index {
    if ([self.notifications count] > 0) {
        [self.notifications removeObjectAtIndex:index];
        [self.light removeNotifications:1];
    }
}
- (void)clearNotifications {
    [self.light removeNotifications:[self.notifications count]];
    [self.notifications removeAllObjects];
}
- (NSInteger)notificationCount {
    return [self.notifications count];
}
@end
