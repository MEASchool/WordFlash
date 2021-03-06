//
//  UIButton+ExtraFactory.h
//  WordFlash
//
//  Created by Matthew Seymour on 12/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ExtraFactory)

+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector event:(UIControlEvents)event;
@end
