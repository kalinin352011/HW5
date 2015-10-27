//
//  LazyLoadingDelegate.h
//  Lesson7
//
//  Created by tim on 27/10/15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LazyLoadingDelegate

- (void)didLoadNewData:(NSArray *)items;
- (void)didFailToLoadDataWithError:(NSError *)error;

@end

@interface LazyLoadingDelegate : NSObject

@property (weak) id<LazyLoadingDelegate> delegate;
- (void)loadDataUsingLastID:(NSNumber *)lastId;

@end
