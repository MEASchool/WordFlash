//
//  WFViewController.m
//  WordFlash
//
//  Created by Hayden Young on 12/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import "WFRootViewController.h"
#import "WFWordListViewController.h"
#import "WFGameViewController.h"
#import "WFScoreViewController.h"
#import "WFdifficulty.h"
#import "WFWordController.h"

@interface WFRootViewController ()

@property (nonatomic, strong)WFRootViewController *rootVC;
@property (nonatomic, strong)WFWordListViewController *wordListVC;
@property (nonatomic, strong)WFGameViewController *gameVC;
@property (nonatomic, strong)WFScoreViewController *scoreVC;
@property (nonatomic, strong)WFdifficulty *difficulty;
@property (nonatomic, strong)WFdifficulty *level;
@property (nonatomic, strong)WFWordController *gameLevel;


@end

@implementation WFRootViewController

static BOOL _showingScore;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UIImage *image = iPhone568Image(@"background.png");//[UIImage imageNamed:@"background.png"];
	self.view.backgroundColor = [UIColor colorWithPatternImage:image];
	}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gameViewAction:(id)sender
{
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	_gameVC = [storyboard instantiateViewControllerWithIdentifier:@"WFGameViewController"];
	[self.view addSubview:_gameVC.view];
	[_wordListVC.view removeFromSuperview];
	__weak WFRootViewController *weakSelf = self;
	
	_gameVC.scoreView = ^
	{
		NSLog(@"***%@", weakSelf);
		[weakSelf scoreViewAction:nil];
	};

}


//--Added new levels of game -- easy medium hard ---
- (IBAction)startEasy:(id)sender
{
	_showingScore = NO;
	//---The following block now gives the gamelevel the difficulty variables
	_level = [WFdifficulty easy];
	_gameLevel = [WFWordController  defaultManager];
	[_gameLevel loadWordsWithSpeedModifier:_level.fallRate];
	[_gameLevel createWords:_level.numberOfWords];
	[_gameLevel createDistractWords:_level.numberOfDistractWords];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	_wordListVC = [storyboard instantiateViewControllerWithIdentifier:@"WordListViewController"];
	[self.view addSubview:_wordListVC.view];
	[self performSelector:@selector(gameViewAction:) withObject:_gameVC afterDelay:_level.displayTime];
	[self performSelector:@selector(scoreViewAction:) withObject:_scoreVC afterDelay:_level.gameTime];
	
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	NSLog(@"%f, %f",width , height);
	
}

- (IBAction)startMedium:(id)sender
{
	
	_showingScore = NO;
	_level = [WFdifficulty medium];
	_gameLevel = [WFWordController  defaultManager];
	[_gameLevel loadWordsWithSpeedModifier:_level.fallRate];
	[_gameLevel createWords:_level.numberOfWords];
	[_gameLevel createDistractWords:_level.numberOfDistractWords];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	_wordListVC = [storyboard instantiateViewControllerWithIdentifier:@"WordListViewController"];
	[self.view addSubview:_wordListVC.view];
	[self performSelector:@selector(gameViewAction:) withObject:_gameVC afterDelay:_level.displayTime];
	[self performSelector:@selector(scoreViewAction:) withObject:_scoreVC afterDelay:_level.gameTime];
	
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	NSLog(@"%f, %f",width , height);
}

- (IBAction)startHard:(id)sender
{
	_showingScore = NO;
	_level = [WFdifficulty hard];
	_gameLevel = [WFWordController  defaultManager];
	[_gameLevel loadWordsWithSpeedModifier:_level.fallRate];
	[_gameLevel createWords:_level.numberOfWords];
	[_gameLevel createDistractWords:_level.numberOfDistractWords];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	_wordListVC = [storyboard instantiateViewControllerWithIdentifier:@"WordListViewController"];
	[self.view addSubview:_wordListVC.view];
	[self performSelector:@selector(gameViewAction:) withObject:_gameVC afterDelay:_level.displayTime];
	[self performSelector:@selector(scoreViewAction:) withObject:_scoreVC afterDelay:_level.gameTime];
	
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	NSLog(@"%f, %f",width , height);
}


- (IBAction)scoreViewAction:(id)sender
{
	if (!_showingScore)
	{
		_showingScore = YES;
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
		_scoreVC = [storyboard instantiateViewControllerWithIdentifier:@"WFScoreViewController"];
		[self.view addSubview:_scoreVC.view];
		[_gameVC.view removeFromSuperview];
	}
}


@end
