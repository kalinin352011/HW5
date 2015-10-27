//
//  ViewController.m
//  Lesson7
//
//  Created by tim on 23/10/15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//
#import "ViewController.h"
#import "LoadingTableViewController.h"
#import "LoginViewController.h"


@implementation ViewController

#warning do not forgot to become a delegate of LoadingTableViewController before showing it on the screen

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)setLable:(UIStoryboardSegue *)segue sender:(id)sender {
    LoadingTableViewController *controller = (LoadingTableViewController *)segue.sourceViewController;
    if (controller.check) {
        self.randomLabel.text = [self generateRandomString:controller.checkItem];
    }
}

- (NSString *)generateRandomString:(NSInteger)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

- (IBAction)logout:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"login"];
    [userDefaults removeObjectForKey:@"pass"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *testViewController = (LoginViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self flipTransition ];
    [self.navigationController pushViewController:testViewController animated:NO];
}
- (void) flipTransition {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view  cache:NO];
    [UIView commitAnimations];
}

@end
