
//
//  BMCollectionViewVC+BMTest.m
//  UICollectionViewDynamicLayoutCacheSize
//
//  Created by liangdahong on 2020/5/25.
//  Copyright © 2020 梁大红. All rights reserved.
//

#import "BMCollectionViewVC+BMTest.h"
#import "AppDelegate.h"
#import "BMHomeVC+BMSectionTest.h"
#import "BMHomeVC+IndexPaths.h"

#define kBMTest_TableView_top     [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
#define kBMTest_TableView_Bottom  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.bounds.size.height) animated:NO]; \
});\

@implementation BMCollectionViewVC (BMTest)

- (void)test_while_deleteIndexPaths_reloadRowsAtIndexPaths {
    if ([self.collectionView visibleCells].count <= 2) {
        self.histroyArray = AppDelegate.test_histroyArray;
        [self.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test_while_deleteIndexPaths_reloadRowsAtIndexPaths];
        });
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test_BMDeleteIndexPaths];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kBMTest_TableView_Bottom;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self test_BMReloadRowsAtIndexPaths];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self test_while_deleteIndexPaths_reloadRowsAtIndexPaths];
                    });
                });
            });
        });
    });
}

- (void)test_while_deleteSections_reloadRowsAtSections {
    if ([self.collectionView visibleCells].count <= 2) {
        self.histroyArray = AppDelegate.test_histroyArray;
        [self.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test_while_deleteSections_reloadRowsAtSections];
        });
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test_BMDeleteSections];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kBMTest_TableView_Bottom;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self test_BMReloadRowsAtSections];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self test_while_deleteSections_reloadRowsAtSections];
                    });
                });
            });
        });
    });
}

@end
