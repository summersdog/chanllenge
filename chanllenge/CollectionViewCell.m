//
//  CollectionViewCell.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/4/20.
//

#import "CollectionViewCell.h"


@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imAvatar;

@end

@implementation CollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置选中样式
//    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
//    backgroundView.layer.cornerRadius = backgroundView.frame.size.width/2;
//    backgroundView.backgroundColor = [UIColor blueColor];
//    self.backgroundView = backgroundView;
//    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *_selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    _selectedBackgroundView.backgroundColor = [UIColor systemBlueColor];
    _selectedBackgroundView.layer.cornerRadius = _selectedBackgroundView.frame.size.height/2;
    
    self.selectedBackgroundView = _selectedBackgroundView;
    
    self.imAvatar.center =CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
    
}


-(void)setCellWithData:(NSArray *)data andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *imgName = [data[indexPath.row][@"avatar_filename"] componentsSeparatedByString:@"."][0];
    self.imAvatar.image = [UIImage imageNamed:imgName inBundle:[NSBundle bundleWithPath:@"/Users/baiyuying/xcode_codes/chanllenge/chanllenge/Resource/avatars"] withConfiguration:nil];
}
@end
