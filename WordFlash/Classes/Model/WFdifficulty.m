//
//  WFdifficulty.m
//  WordFlash
//
//  Created by Tony Newth on 13/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import "WFdifficulty.h"

@implementation WFdifficulty


//--Call whichever difficulty you need (easy) (medium) (Hard)

//--Create objects with properties -numberOfWords - displayTime - fallRate - gameTime and populate an array


- (id) init
{
	self = [super init];
	if(self)
	{
	}
	return self;
};


+(WFdifficulty *)easy
{
	WFdifficulty *difficulty = [[WFdifficulty alloc] init];
	difficulty.numberOfWords = 4;
	difficulty.displayTime = 3;
	difficulty.fallRate = 0.5;
	difficulty.gameTime = 30;
	difficulty.numberOfDistractWords = difficulty.numberOfWords * 2;
	
	return difficulty;
}
+(WFdifficulty *)medium
{
	WFdifficulty *difficulty = [[WFdifficulty alloc] init];
	difficulty.numberOfWords = 10;
	difficulty.displayTime = 2;
	difficulty.fallRate = 1.00;
	difficulty.gameTime = 25;
	difficulty.numberOfDistractWords = difficulty.numberOfWords * 2;

	return difficulty;
}
+(WFdifficulty *)hard
{
	WFdifficulty *difficulty = [[WFdifficulty alloc] init];
	difficulty.numberOfWords = 20;
	difficulty.displayTime = 1;
	difficulty.fallRate = 1.25;
	difficulty.gameTime = 20;
	difficulty.numberOfDistractWords = difficulty.numberOfWords * 2;
	
	return difficulty;
}




@end
