//
//  WFWordListViewController.m
//  WordFlash
//
//  Created by Matthew Seymour on 12/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import "WFWordListViewController.h"
#import "WFWordController.h"
#import "WFdifficulty.h"

@interface WFWordListViewController ()
@property (nonatomic, strong) WFWordController *wordController;
@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) WFdifficulty *level;

@end

@implementation WFWordListViewController


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
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _wordController.selectedWords.count;
	tableView.backgroundColor = [UIColor clearColor];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	cell.textLabel.text =[_wordController.selectedWords[indexPath.row] string];
	cell.backgroundColor = [UIColor clearColor];
	
	NSLog(@"%@",[_wordController.selectedWords[indexPath.row] string]);
	
	return cell;
}

@end
