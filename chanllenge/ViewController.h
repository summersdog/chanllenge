//
//  ViewController.h
//  chanllenge
//
//  Created by 白瑜颖 on 2021/3/14.
//

#import <UIKit/UIKit.h>

@class MyCell;

@interface ViewController : UIViewController

@property(nonatomic,assign) int currentIndex;
@property(nonatomic,strong) NSArray *dataArray;

-(void)loadData;


@end

