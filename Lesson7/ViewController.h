//
//  ViewController.h
//  Lesson7
//
//  Created by Azat Almeev on 11.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *randomLabel;

- (NSString *)generateRandomString:(NSInteger)num;

@end


