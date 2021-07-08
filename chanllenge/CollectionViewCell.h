//
//  CollectionViewCell.h
//  chanllenge
//
//  Created by 白瑜颖 on 2021/4/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

//设置cell内容
-(void)setCellWithData:(NSArray *)data andIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
