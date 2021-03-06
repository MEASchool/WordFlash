//
//  WFScoreViewController.m
//  WordFlash
//
//  Created by Matthew Seymour on 13/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import "WFScoreViewController.h"
#import "WFScoreManager.h"
#import "WFWordController.h"
#import "WFRootViewController.h"
#import "WFGameViewController.h"

@interface WFScoreViewController ()

@property (nonatomic, strong)WFScoreManager *scoreManager;
@property (nonatomic, strong)WFWordController *wordController;
@property (nonatomic, strong)WFRootViewController *rootVC;
@property (nonatomic, strong)WFGameViewController *gameVC;

@end

@implementation WFScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	UIImage *image = iPhone568Image(@"background.png");//[UIImage imageNamed:@"background.png"];
	self.view.backgroundColor = [UIColor colorWithPatternImage:image];
	_scoreManager = [WFScoreManager defaultManager];
	_wordController = [WFWordController defaultManager];
	
////------ SHOW SCORE ------
	
	_scoreAcheived.text = [NSString stringWithFormat:@"%i",(int)_scoreManager.score];
	
////------ SHOW TOTAL AVAILABLE ------
	
	_scoreAttainable.text = [NSString stringWithFormat:@"%i",(int)[_wordController.selectedWords count]];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////------ RESET BUTTON ------


- (IBAction)resetAction:(id)sender
{
	_scoreManager.score = 0;
	[self.view removeFromSuperview];
	[_gameVC.view removeFromSuperview];
	NSLog(@"GAME RESET");
}
@end
