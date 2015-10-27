//
//  LoadingTableViewController.m
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "LoadingTableViewController.h"



@implementation LoadingTableViewController

#warning get some tips here
//Here should be familiar lazy loading table view
//Implement table view such as click on cell makes it have checkmark on the right side. User can change selection unlimited number of times. Clicking to the save button returns to the previos page and updates random text label with random characters of length same as number that was selected here in the table
//Returning back using arrow on upper left corner does nothing
- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}

- (LazyLoadingDelegate *)loading {
    if (!_loading) {
        _loading = [LazyLoadingDelegate new];
        _loading.delegate = self;
    }
    return _loading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.check = NO;
    self.numberCheckItem = -1;
}

- (void)didLoadNewData:(NSArray *)items {
    self.isLoading = NO;
    NSInteger offset = self.items.count * 2;
    [self.items addObjectsFromArray:items];
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSInteger i = 0; i < items.count * 2; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i + offset inSection:0];
        [indexPaths addObject:ip];
    }
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didFailToLoadDataWithError:(NSError *)error {
    self.isLoading = NO;
    self.didFail = YES;
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"%@", error);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? !self.didFail : 2 * self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"loadingCellIdentifier"];
        return cell;
    }
    NSInteger index = indexPath.row / 2;
    if (indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"basicCellIdentifier"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.items[index]];
    }
    if (indexPath.row % 2 == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"subtitleCellIdentifier"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.items[index]];
    }
    
    cell.accessoryType = (indexPath.row == self.numberCheckItem) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && !self.isLoading) {
        [self.loading loadDataUsingLastID:self.items.lastObject];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell* cellCheck = [tableView cellForRowAtIndexPath:indexPath];
        cellCheck.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkItem = [self.items[indexPath.row / 2] integerValue];
        self.numberCheckItem = indexPath.row;
        self.check = YES;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:indexPath];
    uncheckCell.accessoryType = UITableViewCellAccessoryNone;
}



@end
