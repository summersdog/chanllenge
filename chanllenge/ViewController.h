//
//  ViewController.h
//  chanllenge
//
//  Created by 白瑜颖 on 2021/3/14.
//

#import <UIKit/UIKit.h>

@class MyCell;

@interface ViewController : UIViewController

@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,assign) CGFloat widithHeightRatio;

-(void)loadData;
//-(void)matchScrollView:(UIScrollView *)first toScrollView:(UIScrollView *)second;


@end

