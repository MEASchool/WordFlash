//
//  WFViewController.h
//  WordFlash
//
//  Created by Hayden Young on 12/08/13.
//  Copyright (c) 2013 Hayden Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFRootViewController : UIViewController

//- (IBAction)startButton:(id)sender;

- (IBAction)startEasy:(id)sender;
- (IBAction)startMedium:(id)sender;
- (IBAction)startHard:(id)sender;

- (IBAction)gameViewAction:(id)sender;


- (IBAction)scoreViewAction:(id)sender;
@end
