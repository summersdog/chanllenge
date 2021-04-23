//
//  ViewController.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/3/14.
//

#import "ViewController.h"
#import "MyCell.h"
#import "CollectionViewCell.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation ViewController

@synthesize widithHeightRatio;

static NSString *reuseId = @"bottomCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化视图 读取json文件存入数组中
    [self loadData];
    [self setUpView];
    //载入json数据
   
    
    
    
    
    
}
-(void)loadData{
    NSData *data = [[NSData alloc] initWithContentsOfFile:@"/Users/baiyuying/xcode_codes/chanllenge/chanllenge/Resource/contacts.json"];
    self.dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSInteger size = [UIScreen mainScreen].bounds.size.width/5.0f;
    
    CGFloat coWidth = (size-6);
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
    self.currentIndex=0;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"topCell"];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//    [self setWidithHeightRatio:0];
    

    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bottom"];
//    [self setCell:cell withTableView:tableView];
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
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
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.indexPathsForSelectedItems.firstObject.item inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            //获取滑动结束位置的坐标
            CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
            //UITableView禁止响应其他滑动手势
            scrollView.panGestureRecognizer.enabled = NO;
        
            if(translatedPoint.y < -100 && self.currentIndex < self.dataArray.count-1) {
                self.currentIndex ++;   //向下滑动索引递增
            }
            if(translatedPoint.y > 100 && self.currentIndex > 0) {
                self.currentIndex --;   //向上滑动索引递减
            }
            //动画切换
            [UIView animateWithDuration:0.15
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut animations:^{
                                    //UITableView滑动到指定cell
                                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//                [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
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
    return UIEdgeInsetsMake(0, self.collectionView.bounds.size.width*2/5, 0, self.collectionView.bounds.size.width*2/5);
}


//选中居中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    collectionView.allowsSelection=NO;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    collectionView.allowsSelection=YES;
    [collectionView selectItemAtIndexPath:indexPath animated:UICollectionViewScrollPositionNone scrollPosition:NO];

    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.item inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.currentIndex = indexPath.row;

}

//- (void)setWidithHeightRatio:(CGFloat)widithHeightRatio
//{
//    
//    self.widithHeightRatio = MyMidthHeightRatio;
//}

//滚动同步事件监听处理



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

    
    //实现选中中间元素的滚动监听方法
    {
    if ([scrollView isEqual:self.collectionView]) {
        //选中中间的
        CGPoint center = self.collectionView.center;
        center = [self.view convertPoint:center toView:self.collectionView];
        NSIndexPath *centerIndexPath= [self.collectionView indexPathForItemAtPoint:center];
        NSLog(@"center(%f,%f) index(%ld)",center.x,center.y,centerIndexPath.item);
        self.currentIndex = centerIndexPath.item;
        [self.collectionView selectItemAtIndexPath:centerIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        
//        CGPoint offset = scrollView.contentOffset;
//        CGFloat heightOffset = offset.x/self.widithHeightRatio;
//
//        [self.tableView setContentOffset:CGPointMake(0, heightOffset)];
        
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }else{
//        CGPoint offset = scrollView.contentOffset;
//        CGFloat widthOffset = offset.y*self.widithHeightRatio;
//
//        [self.collectionView setContentOffset:CGPointMake(widthOffset, 0)];
    }
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }
    //实现对偏移量的监听和转移；
}






@end
