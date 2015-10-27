//
//  LoadingTableViewController.h
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LazyLoadingDelegate.h"

@interface LoadingTableViewController : UITableViewController <LazyLoadingDelegate>

@property (nonatomic) LazyLoadingDelegate *loading;
@property (nonatomic) NSMutableArray *items;
@property BOOL isLoading;
@property BOOL didFail;
@property NSInteger checkItem;
@property NSInteger numberCheckItem;
@property BOOL check;

@end
