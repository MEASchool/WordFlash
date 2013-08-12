//
//  UIButton+ExtraFactory.m
//  WordFlash
//
//  Created by Matthew Seymour on 12/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import "UIButton+ExtraFactory.h"

@implementation UIButton (ExtraFactory)

+(UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
	UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:title forState:(UIControlStateNormal)];
	[button sizeToFit];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

@end
