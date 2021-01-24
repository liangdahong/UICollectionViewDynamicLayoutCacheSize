//
//  BMHomeVC+BMSectionTest.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC+BMSectionTest.h"
#import "AppDelegate.h"

@implementation BMCollectionViewVC (BMSectionTest)

- (void)test_BMReloadRowsAtSections {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [self.histroyArray enumerateObjectsUsingBlock:^(NSMutableArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (arc4random_uniform(4) == 0) {
            [indexSet addIndex:idx];
        }
    }];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        self.histroyArray[idx] = [AppDelegate test_arcArray].mutableCopy;
    }];
    [self.collectionView reloadData];
    // 这里不能使用 reloadSections  会导致崩溃，暂时未找到原因。
    // [self.collectionView reloadSections:indexSet];
}

- (void)test_BMDeleteSections {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [self.histroyArray enumerateObjectsUsingBlock:^(NSMutableArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (arc4random_uniform(3) == 0) {
            [indexSet addIndex:idx];
        }
    }];
    [indexSet enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [self.histroyArray removeObjectAtIndex:idx];
    }];
    [self.collectionView deleteSections:indexSet];
}

@end
