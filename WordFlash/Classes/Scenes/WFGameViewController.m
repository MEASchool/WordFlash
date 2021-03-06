//
//  WFGameViewController.m
//  WordFlash
//
//  Created by Matthew Seymour on 12/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import "WFGameViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "WFWordController.h"
#import "WFword.h"
#import "WFScoreManager.h"

@interface WFGameViewController ()

@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) WFWordController *wordController;
@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSMutableArray *buttonMutable;
@property (nonatomic, strong) WFScoreManager *scoreManager;
@property (nonatomic, strong) CAEmitterLayer *emitter;


@end

@implementation WFGameViewController

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
	_wordController = [WFWordController defaultManager];
	_scoreManager = [WFScoreManager defaultManager];
	_buttonMutable = [[NSMutableArray alloc] init];
	
	
	///////////----------------------
	///// --------- WRONG WORDS
	///////////----------------------
	
	NSLog(@"%@",_buttonMutable);
	for (int i = 0; i < _wordController.selectedDistractWords.count; i++)
	{
		
		UIButton *wrongWordsButton = [UIButton buttonWithTitle:[_wordController.selectedDistractWords[i] string] target:self selector:@selector(wrongWordTappedAction:)event:UIControlEventTouchDown];
		
		////------ KEEPING TRACK OF BUTTONS ------
		
		wrongWordsButton.tag = i;
		
		////------ ADDING A SCROLL IMAGE TO BUTTON ------
		
		UIImage *scrollImage = [UIImage imageNamed:@"scroll.png"];
		CGFloat widthInset = scrollImage.size.width * 0.5 -1;
		CGFloat heightInset = scrollImage.size.height * 0.5 -1;
		UIEdgeInsets insets = UIEdgeInsetsMake(heightInset, widthInset, heightInset, widthInset);
		scrollImage = [scrollImage resizableImageWithCapInsets:insets];
		[wrongWordsButton setBackgroundImage:scrollImage forState:UIControlStateNormal];
		
		////------ SET COLOR OF BUTTON TEXT ------
		
		[wrongWordsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[wrongWordsButton sizeToFit];
		
		[self.view addSubview:wrongWordsButton];
		
		
		
		////------ RANDOMIZE WHERE BUTTON SPAWNS ABOVE THE SCREEN ------
		
		[self randomizeCenter:wrongWordsButton];
		[_buttonMutable addObject:wrongWordsButton];
		
	}
	///////////----------------------
	///// --------- CORRECT WORDS
	///////////----------------------
	
	for (int i = 0; i < _wordController.selectedWords.count; i++)
	{
		
		UIButton *correctWordsButton = [UIButton buttonWithTitle:[_wordController.selectedWords[i] string] target:self selector:@selector(wordTappedAction:)event:UIControlEventTouchDown];
		
		////------ KEEPING TRACK OF BUTTONS ------
		
		correctWordsButton.tag = i;
		
		////------ ADDING A SCROLL IMAGE TO BUTTON ------
		
		UIImage *scrollImage = [UIImage imageNamed:@"scroll.png"];
		CGFloat widthInset = scrollImage.size.width * 0.5 -1;
		CGFloat heightInset = scrollImage.size.height * 0.5 -1;
		UIEdgeInsets insets = UIEdgeInsetsMake(heightInset, widthInset, heightInset, widthInset);
		scrollImage = [scrollImage resizableImageWithCapInsets:insets];
		[correctWordsButton setBackgroundImage:scrollImage forState:UIControlStateNormal];
		
		////------ SET COLOR OF BUTTON TEXT ------

		[correctWordsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[correctWordsButton sizeToFit];
		
		[self.view addSubview:correctWordsButton];
		
		
		
		////------ RANDOMIZE WHERE BUTTON SPAWNS ABOVE THE SCREEN ------
		
		[self randomizeCenter:correctWordsButton];
		[_buttonMutable addObject:correctWordsButton];
		
	}
	
	_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(buttonMove:)];
	[_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	
	
}

////----- WHAT HAPPENS WHEN THE CORRECT BUTTON IS TAPPED

- (void)wordTappedAction:(UIButton *)correctWordsButton
{
	if ([_wordController containsWord:_wordController.selectedWords[correctWordsButton.tag]] == YES)
	{
		CGFloat arrowX = 186;
		CGFloat arrowY = _arrow.center.y;
		
		[UIView animateWithDuration:.8 animations:^
		 {
			 _arrow.center = CGPointMake(arrowX, arrowY);
			 
		 } completion:^(BOOL finished)
		 {
			 _arrow.center = CGPointMake(-50, arrowY);
			 
		 }];
		
		[correctWordsButton removeFromSuperview];
		[_scoreManager increaseScore:1];
		if (_scoreManager.score == (_wordController.selectedWords.count))
		{
			if (self.scoreView)
				self.scoreView();
		}
		NSLog(@"YES");
	}
}

- (void)blowUpShit:(UIButton *)wrongButton
{
    _emitter = [[CAEmitterLayer alloc] init];
	_emitter.position = wrongButton.center;
	CAEmitterCell *cell = [CAEmitterCell emitterCell];
	UIImage *image = [UIImage imageNamed:@"smoke.png"];
	cell.contents = (__bridge id)(image.CGImage);
	cell.birthRate = 20;
	cell.velocity = 20;
	cell.lifetime = 1;
	cell.spin = 1;
	cell.spinRange = 5;
	cell.alphaSpeed = 15;
	cell.lifetimeRange = 1;
	cell.greenSpeed = 0;
	cell.greenRange = 9;
	cell.blueRange = 9;
	cell.blueSpeed = 0;
	cell.redRange = 1;
	cell.redSpeed = 5;
	cell.emissionRange = M_PI;
	
	_emitter.emitterCells = @[cell];
	[self.view.layer addSublayer:_emitter];
	[_emitter performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:0.5];
	
}

////----- WHAT HAPPENS WHEN THE WRONG BUTTON IS TAPPED

- (void)wrongWordTappedAction:(UIButton *)wrongWordsButton
{
	[self blowUpShit:wrongWordsButton];
	
	
	for(int i = 0; i < _buttonMutable.count; i++)
	{
		UIButton *correctWordsButton = _buttonMutable[i];
		UIButton *wrongWordsButton = _buttonMutable[i];
		
		[self randomizeCenter:correctWordsButton];
		[self randomizeCenter:wrongWordsButton];
	}
	

	NSLog(@"NO");
}


////------ RANDOMIZE WHERE BUTTON SPAWNS ABOVE THE SCREEN WITHIN THE WIDTH ------


- (void)randomizeCenter:(UIButton *)button
{
    int width = self.view.frame.size.width;
    int buttonWidth = button.frame.size.width;
	
	int randomX = (arc4random() % width);
	
	if (randomX < buttonWidth * 0.5)
	{
		randomX += buttonWidth * 0.5;
	}
	
	if (randomX > (width-buttonWidth *0.5))
	{
		randomX = width - buttonWidth * 0.5;
	}
	button.center = CGPointMake(randomX, 0-arc4random()%300);
    
}

////------ MAKE BUTTONS FALL DOWN THE SCREEN ------

- (void)buttonMove:(CADisplayLink *)sender
{
	
	for (int r = 0; r < _buttonMutable.count; r++)
	{
		UIButton *button = _buttonMutable[r];
		
		CGFloat x = button.center.x + 0;
		CGFloat y = button.center.y + [_wordController.words[r]speed];
		
		button.center = CGPointMake(x, y);
		if (button.center.y > self.view.frame.size.height)
		{
			[self randomizeCenter:button];
		}
	}
	
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
