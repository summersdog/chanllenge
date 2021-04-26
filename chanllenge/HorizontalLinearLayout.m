//
//  HorizontalLinearLayout.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/4/21.
//

#import "HorizontalLinearLayout.h"

@implementation HorizontalLinearLayout

- (void)prepareLayout{
    [super prepareLayout];
    //此处的size应该计算
    
    self.minimumLineSpacing = 5;
    self.minimumInteritemSpacing = 5;
    NSInteger size = [UIScreen mainScreen].bounds.size.width/5.0f;
    self.itemSize = CGSizeMake(size-10, size-10);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.scrollEnabled=YES;
    self.collectionView.allowsSelection=YES;
    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    

}

//- (CGSize)collectionViewContentSize{
//    return self.collectionView.frame.size;
//}

//- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
//        return arr;
//}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    // 计算出停止滚动时(不是松手时)最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
 
    // 获得系统已经帮我们计算好的布局属性数组
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
 
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
 
    // 当完全停止滚动后，离中点Y值最近的那个cell会通过我们多给出的偏移量回到屏幕最中间
    // 存放最小的间距值
    // 先将间距赋值为最大值，这样可以保证第一次一定可以进入这个if条件，这样可以保证一定能闹到最小间距
    CGFloat minSpace = MAXFLOAT;
    NSIndexPath * stopIndexPath;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minSpace) > ABS(attrs.center.x - centerX)) {
            minSpace = attrs.center.x - centerX;
            stopIndexPath =  attrs.indexPath;

        }
    }
    
//    [self.collectionView selectItemAtIndexPath:stopIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    // 修改原有的偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}

//
//- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
//
//    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
//    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
//
//    NSIndexPath *centerIndexPath;
//    for (UICollectionViewLayoutAttributes *attr in arr) {
//        CGFloat scale = 1 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) / self.collectionView.bounds.size.width;
//        if(scale>0.99)
//        {
//            centerIndexPath = attr.indexPath;
//        }
//    }
//    [self.collectionView selectItemAtIndexPath:centerIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//    return arr;
//}










@end
