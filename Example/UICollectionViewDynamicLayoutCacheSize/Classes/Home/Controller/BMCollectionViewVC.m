//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "BMCollectionViewVC.h"
#import "BMCollectionCell.h"
#import "BMLeftCollectionViewFlowLayout.h"
#import "UICollectionViewDynamicLayoutCacheSize.h"
#import "BMCollectionViewVC+BMTest.h"
#import "BMHeaderView.h"
#import "BMFooterView.h"

@implementation BMCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.collectionViewLayout = BMLeftCollectionViewFlowLayout.new;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotification) name:UIDeviceOrientationDidChangeNotification object:nil];

    // 自动测试模块
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否启动自动测试模块" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"启动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self test_while_deleteIndexPaths_reloadRowsAtIndexPaths];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test_while_deleteSections_reloadRowsAtSections];
        });
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"不启动" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _histroyArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _histroyArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMCollectionCell *cell = [BMCollectionCell bm_collectionViewCellFromNibWithCollectionView:collectionView forIndexPath:indexPath];

    cell.titleLabel1.text = _histroyArray[indexPath.section][indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView bm_sizeWithCellClass:BMCollectionCell.class
                                   cellMaxWidth:([UIScreen mainScreen].bounds.size.width-10)
                               cacheByIndexPath:indexPath
                                  configuration:^(__kindof BMCollectionCell *cell) {
        cell.titleLabel1.text = self.histroyArray[indexPath.section][indexPath.item];
    }];
//    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item) {
            id obj = self.histroyArray[indexPath.section][indexPath.item];
            [_histroyArray[indexPath.section] removeObjectAtIndex:indexPath.item];
            [_histroyArray[indexPath.section] insertObject:obj atIndex:0];
            [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        }
    } else {
        id obj = self.histroyArray[indexPath.section][indexPath.item];
        [_histroyArray[indexPath.section] removeObjectAtIndex:indexPath.item];
        [_histroyArray[0] insertObject:obj atIndex:0];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 100);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        return [BMHeaderView bm_collectionReusableViewFromNibWithCollectionView:collectionView kind:kind forIndexPath:indexPath];
    } else {
        return [BMHeaderView bm_collectionReusableViewFromNibWithCollectionView:collectionView kind:kind forIndexPath:indexPath];
    }
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (kind == UICollectionElementKindSectionHeader) {
//        return [BMHeaderView bm_collectionReusableViewFromNibWithCollectionView:collectionView kind:kind forIndexPath:indexPath];
//    } else {
//        return [BMHeaderView bm_collectionReusableViewFromNibWithCollectionView:collectionView kind:kind forIndexPath:indexPath];
//    }
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (kind == UICollectionElementKindSectionHeader) {
//        return [BMFooterView bm_collectionReusableViewFromNibWithCollectionView:collectionView kind:kind forIndexPath:indexPath];
//    } else {
//        return [BMFooterView bm_collectionReusableViewFromNibWithCollectionView:collectionView kind:kind forIndexPath:indexPath];
//    }
//}

// 旋转的时候更新
- (void)deviceOrientationDidChangeNotification {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [CATransaction commit];
}

@end
