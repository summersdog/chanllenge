//
//  ViewController.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/3/14.
//

#import "ViewController.h"
#import "MyCell.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

static NSString *reuseId = @"bottomCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化视图 读取json文件存入数组中
    [self setUpView];
    //载入json数据
    [self loadData];
    _currentIndex=0;
    
    
}
-(void)loadData{
    NSData *data = [[NSData alloc] initWithContentsOfFile:@"/Users/baiyuying/xcode_codes/chanllenge/chanllenge/Resource/contacts.json"];
    self.dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
}
- (void)setUpView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    
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
                            } completion:^(BOOL finished) {
                                //UITableView可以响应其他滑动手势
                                scrollView.panGestureRecognizer.enabled = YES;
                            }];
        
    });
}


@end
