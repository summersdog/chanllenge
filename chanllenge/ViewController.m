//
//  ViewController.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/3/14.
//

#import "ViewController.h"
#import "MyCell.h"
#import "CollectionViewCell.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation ViewController

@synthesize widithHeightRatio;

static NSString *reuseId = @"bottomCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //载入json数据 计算滑动比例
    [self loadData];
    //初始化视图
    [self setUpView];
    
    
    
    
    
    
    
}
-(void)loadData{
    NSData *data = [[NSData alloc] initWithContentsOfFile:@"/Users/baiyuying/xcode_codes/chanllenge/chanllenge/Resource/contacts.json"];
    self.dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSInteger size = [UIScreen mainScreen].bounds.size.width*0.2-10;
//    NSInteger size = self.collectionView.contentSize.width;
    //5是spacing
    CGFloat coWidth = size+5;
    CGFloat taHeight = self.tableView.bounds.size.height;
    CGFloat MyMidthHeightRatio = coWidth/taHeight;
    [self setWidithHeightRatio:MyMidthHeightRatio];
    
    
}
- (void)setUpView{
    //设置代理 数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.collectionView.delegate=self;
    self.collectionView.dataSource = self;
    
    //设置显示风格
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    //去掉末尾的横线
    self.tableView.tableFooterView = [UIView new];
    
    
    //初始化
    self.currentIndex=0;
    
    //设置collectionview的宽度
    CGRect old = self.collectionView.frame;
    old.size.width = [UIScreen mainScreen].bounds.size.width;
    [self.collectionView setFrame:old];
    
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"topCell"];
    
    //选中默认位置
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    

    
}

//获取tableview的cell
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        //通过nib的方式
        cell = [[NSBundle mainBundle] loadNibNamed:@"bottomCell" owner:nil options:nil][0];
    }
    [cell setData:_dataArray andIndex:indexPath.row];
    
    return cell;
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.frame.size.height;
}

#pragma ScrollView delegate
//实现滑动切换的动画效果，通过代理，判断滑动的长度是否超过100
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([scrollView isEqual:self.collectionView]) {

    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            //获取滑动结束位置的坐标
            CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
            //UITableView禁止响应其他滑动手势
            scrollView.panGestureRecognizer.enabled = NO;
            //为了避免滑动了太远导致了连续滑动两格，需要判断是否超过了高度的一半导致已经滑到了下一个，并更改了当前的index
            if(translatedPoint.y < -100 && translatedPoint.y>-self.tableView.bounds.size.height/2 && self.currentIndex < self.dataArray.count-1) {
                self.currentIndex ++;   //向下滑动索引递增
            }
            if(translatedPoint.y > 100 && translatedPoint.y<self.tableView.bounds.size.height/2 && self.currentIndex > 0) {
                self.currentIndex --;   //向上滑动索引递减
            }
            //动画切换
            [UIView animateWithDuration:0.15
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut animations:^{
                                    //UITableView滑动到指定cell
                                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

                                } completion:^(BOOL finished) {
                                    //UITableView可以响应其他滑动手势
                                    scrollView.panGestureRecognizer.enabled = YES;
                                }];
            
        });
    }

    

    

}



//collectionview cell的获取
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //获取cell
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
    if(cell==nil){
    cell = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil][0];

    }
    
    
    //设置cell内容
    [cell setCellWithData:_dataArray andIndexPath:indexPath];

    
    
    //返回cell
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataArray.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//填补开头和末尾的空隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CGFloat size = [UIScreen mainScreen].bounds.size.width*0.2-10;
    return UIEdgeInsetsMake(0, self.collectionView.bounds.size.width*0.5-size*0.5, 0, self.collectionView.bounds.size.width*0.5-size*0.5);
}




//选中居中
//为了避免闪烁效果，首先选中当前的，再滚动到选中的地方，通过滚动的代理方法进行选中元素的选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //先选中当前的
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    //同步
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    self.currentIndex = indexPath.row;

}

//滚动事件监听处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

    
    //实现选中中间元素的滚动监听方法
    {
    if ([scrollView isEqual:self.collectionView]) {
        //选中中间的
        CGPoint center = self.collectionView.center;
        center = [self.view convertPoint:center toView:self.collectionView];
        NSIndexPath *centerIndexPath= [self.collectionView indexPathForItemAtPoint:center];

        //同步滚动
        //这里判断nil是因为可能会滚动到centerIndexPath为nil的地方，导致.item=0；
        if (centerIndexPath!=nil) {
            self.currentIndex = centerIndexPath.item;
        }
        [self.collectionView selectItemAtIndexPath:centerIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        
        CGPoint offset = scrollView.contentOffset;
        CGFloat heightOffset = offset.x/self.widithHeightRatio;

        [self.tableView setContentOffset:CGPointMake(0, heightOffset)];

        
    }else{
        CGPoint offset = scrollView.contentOffset;
        CGFloat widthOffset = offset.y*self.widithHeightRatio;

        [self.collectionView setContentOffset:CGPointMake(widthOffset, 0)];
        }


    }

}






@end
