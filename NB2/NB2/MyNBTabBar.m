//
//  MyNBTabBar.m
//  NB2
//
//  Created by kohn on 13-11-16.
//  Copyright (c) 2013年 Kohn. All rights reserved.
//

#import "MyNBTabBar.h"
#import "MyNBTabButton.h"
#import "MyNBTabNotification.h"

#define HEIGHT_MENU_VIEW ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 45 : 65)

@interface MyNBTabBar()

@property (strong) NSMutableArray *buttons;
@property (strong) NSMutableArray *buttonData;
@property (strong) NSMutableArray *statusLights;

- (void)setupButtons;
- (void)setupLights;
@end

@implementation MyNBTabBar
@synthesize buttons = _buttons, buttonData = _buttonData, statusLights = _statusLights, delegate;

- (id)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - HEIGHT_MENU_VIEW, SCREEN_WIDTH, 45);
        self.backgroundColor = [UIColor blackColor];
        
        self.buttonData = [[NSMutableArray alloc]initWithArray:items];
        self.buttons = [[NSMutableArray alloc]init];
        
        [self setupButtons];
        [self setupLights];
    }
    return self;
}
- (void)setupButtons {
    NSInteger count = 0;
    NSInteger xExtra = 0;
    NSInteger buttonSize = floor(SCREEN_WIDTH / [self.buttonData count]) -1;
    for (MyNBTabButton *info in self.buttonData) {
        NSInteger extra = 0;
        if ([self.buttonData count] % 2 == 1) {
            if ([self.buttonData count] == 5) {
                NSInteger i = (count +1) + (floor([self.buttonData count] / 2));
                if (i == [self.buttonData count]) {
                    extra = 1;
                }else if([self.buttonData count] == 3){
                    buttonSize = floor(SCREEN_WIDTH / [self.buttonData count]);
                }
            }else{
                if (count + 1 == 2) {
                    extra = 1;
                } else if (count + 1 == 3) {
                    xExtra = 1;
                }
            }
        }
        NSInteger buttonX = (count * buttonSize) +count+xExtra;
        
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.frame  = CGRectMake(buttonX, 2, buttonSize + extra, 43);
        UIImage *tabButtonBackground = [[UIImage imageNamed:@"tabButtonBackground"]stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        UIImage *hightabButtonBackground = [[UIImage imageNamed:@"hightabButtonBackground"]stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        
        UIImage * normalImage = [info icon];
        UIImage * highlightImage = [info highlightedIcon];
        
        UIImageView *btnImgView = [[UIImageView alloc] initWithImage:normalImage highlightedImage:highlightImage];
        btnImgView.frame = CGRectMake((buttonSize + extra-64)/2, 0, 64, 43);
        [tabButton addSubview:btnImgView];
        
        [tabButton setBackgroundImage:tabButtonBackground forState:UIControlStateNormal];
        [tabButton setBackgroundImage:hightabButtonBackground forState:UIControlStateSelected];
        
        [tabButton addTarget:self action:@selector(touchDownForButton:) forControlEvents:UIControlEventTouchDown];
        [tabButton addTarget:self action:@selector(touchUpForButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:tabButton];
        [self.buttons addObject:tabButton];
        count++;
    }
}

- (void)setupLights{
    NSInteger count = 0;
    NSInteger xExtra = 0;
    NSInteger buttonSize = floor(320 / [self.buttonData count]) - 1;
    for (MyNBTabButton *info in self.buttonData) {
        NSInteger extra = 0;
        if ([self.buttonData count] % 2 == 1) {
            if ([self.buttonData count] == 5) {
                NSInteger i = (count + 1) + (floor([self.buttonData count] / 2));
                if (i == [self.buttonData count]) {
                    extra = 1;
                } else if (i == [self.buttonData count]+1) {
                    xExtra = 1;
                }
            } else if ([self.buttonData count] == 3) {
                buttonSize = floor(320 / [self.buttonData count]);
            }
        } else {
            if (count + 1 == 2) {
                extra = 1;
            } else if (count + 1 == 3) {
                xExtra = 1;
            }
        }
        NSInteger buttonX = (count * buttonSize) + count + xExtra;
        [[info notificationView] updateImageView];
        [[info notificationView] setAllFrames:CGRectMake(buttonX + buttonSize+extra - 29 , 0, 24, 27)];
        
        [self addSubview:[info notificationView]];
        count++;
    }
    
}

- (void)showDefauls {
    [self touchDownForButton:[self.buttons objectAtIndex:0]];
    [self touchUpForButton:[self.buttons objectAtIndex:0]];
}
- (void)showIndex:(NSInteger) index{
    [self touchDownForButton:[self.buttons objectAtIndex:index]];
    [self touchUpForButton:[self.buttons objectAtIndex:index]];
}

- (void)touchDownForButton:(UIButton *)button{
    button.selected = YES;
    NSInteger i = [self.buttons indexOfObject:button];
    MyNBTabController *vc = [[self.buttonData objectAtIndex:i] viewController];
    
    [delegate switchViewController:vc];
    
    for (UIButton *b in self.buttons) {
        for (UIView *aView in [b subviews]) {
            if ([aView isKindOfClass:[UIImageView class]]) {
                UIImageView * imgView = (UIImageView *)aView;
                imgView.highlighted = NO;
            }
        }
    }
    for (UIView *aView in [button subviews]) {
        if ([aView isKindOfClass:[UIImageView class]]) {
            UIImageView * imgView = (UIImageView *)aView;
            imgView.highlighted = YES;
        }
    }
    
    for (UIButton * b in self.buttons) {
        b.selected = NO;
    }
    
}
- (void)touchUpForButton:(UIButton *)button {
    for (UIButton *b in self.buttons) {
        for (UIView *aView in [b subviews]) {
            if ([aView isKindOfClass:[UIImageView class]]) {
                UIImageView * imgView = (UIImageView *)aView;
                imgView.highlighted = NO;
            }
        }
    }
    for (UIView *aView in [button subviews]) {
        if ([aView isKindOfClass:[UIImageView class]]) {
            UIImageView * imgView = (UIImageView *)aView;
            imgView.highlighted = YES;
        }
    }
    
    for (UIButton * b in self.buttons) {
        b.selected = NO;
    }
    button.selected = YES;
}


@end
