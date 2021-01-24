
//
//  BMHomeVC+BMReloadRowsAtIndexPaths.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by liangdahong on 2020/5/25.
//  Copyright © 2020 梁大红. All rights reserved.
//

#import "BMHomeVC+IndexPaths.h"
#import "AppDelegate.h"

@implementation BMCollectionViewVC (IndexPaths)

- (void)test_BMReloadRowsAtIndexPaths {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSMutableArray <NSIndexPath *> *indexPaths = @[].mutableCopy;
    [self.histroyArray enumerateObjectsUsingBlock:^(NSMutableArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSString * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (arc4random_uniform(4) == 0) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:idx1 inSection:idx]];
            }
        }];
    }];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.histroyArray[obj.section][obj.item] = [AppDelegate test_arcString];
    }];
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (void)test_BMDeleteIndexPaths {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSMutableArray <NSIndexPath *> *indexPaths = @[].mutableCopy;
    [self.histroyArray enumerateObjectsUsingBlock:^(NSMutableArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSString * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (arc4random_uniform(4) == 0) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:idx1 inSection:idx]];
            }
        }];
    }];
    [indexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        if (obj1.section == obj2.section) {
            return obj1.row < obj2.row;
        }
        return obj1.section < obj2.section;
    }];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.histroyArray[obj.section] removeObjectAtIndex:obj.item];
    }];
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.collectionView deleteItemsAtIndexPaths:indexPaths];
}

@end
