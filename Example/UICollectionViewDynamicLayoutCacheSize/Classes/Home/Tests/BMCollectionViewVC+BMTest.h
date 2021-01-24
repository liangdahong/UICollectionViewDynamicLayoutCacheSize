//
//  BMCollectionViewVC+BMTest.h
//  UICollectionViewDynamicLayoutCacheSize
//
//  Created by liangdahong on 2020/5/25.
//  Copyright © 2020 梁大红. All rights reserved.
//

#import "BMCollectionViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMCollectionViewVC (BMTest)

/// deleteIndexPaths，reloadRowsAtIndexPath
- (void)test_while_deleteIndexPaths_reloadRowsAtIndexPaths;
/// deleteSections，reloadRowsAtSections
- (void)test_while_deleteSections_reloadRowsAtSections;

// 暂时未完成此 insert 和 move 的测试
//- (void)test_while_insertSections_moveSection;
//- (void)test_while_insertRowsAtIndexPaths_moveRowAtIndexPath;

@end

NS_ASSUME_NONNULL_END
