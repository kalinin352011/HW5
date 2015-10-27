//
//  LoginViewController.h
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)sigininClicked:(id)sender;

//- (IBAction)backgroundTap:(id)sender;
//-(IBAction)txtUserName:(id)sender;
//-(IBAction)txtPassword:(id)sender;

@end
