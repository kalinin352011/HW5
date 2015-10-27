//
//  LoginViewController.m
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "LoginViewController.h"
#import "NavigationController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offsetConstraint;
@end

@implementation LoginViewController
@synthesize txtPassword,txtUserName;

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationController.navigationBarHidden = YES;
#warning read instructions here
//    You need to change some properties of text fields. For the first one keyboard return button should show 'next', and for the second it should be 'done'. Also, add placeholders and make password field hide entered symbols (as usual password field)
//    You have to implement here some of UITextField delegate methods. Desired behavior is that when user press next button on keyboard during login edition, password field becomes activated, and on done button click app do the same as if user press login button directly
//    Please log any errors using NSLog
}
- (void)viewDidLayoutSubviews {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"login"] length] > 0 && [[userDefaults objectForKey:@"pass"] length] > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NavigationController *navigationController = (NavigationController *)[storyboard  instantiateViewControllerWithIdentifier:@"NavigationController"];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [super viewWillDisappear:animated];
}

#pragma mark - Keyboard
- (void)keyboardWillShowNotification:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:.3 animations:^{
        CGFloat kbHeight = kbSize.height;
        self.offsetConstraint.constant = -kbHeight / 2;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    [UIView animateWithDuration:.3 animations:^{
        self.offsetConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)sigininClicked:(id)sender {
    if (self.txtUserName.text.length > 0 && self.txtPassword.text.length > 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.txtUserName.text forKey:@"login"];
        [userDefaults setObject:self.txtPassword.text forKey:@"pass"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NavigationController *navigationController = (NavigationController *)[storyboard  instantiateViewControllerWithIdentifier:@"NavigationController"];
        [self flipTransition];
        [self presentViewController:navigationController animated:NO completion:nil];
    }
       }

//- (IBAction)backgroundTap:(id)sender {
  //  [self.view endEditing:YES ];
//}

- (void) flipTransition {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view  cache:NO];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }else {
        [textField resignFirstResponder];
    }
    return NO;
}



@end
