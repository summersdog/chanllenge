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
    //设置背景样式

    NSInteger size = [UIScreen mainScreen].bounds.size.width/5.0f - 10;
    self.frame = CGRectMake(0, 0, size , size);
    self.imAvatar.frame = self.frame;
    CGRect bgFrame = self.frame;
    UIView *_selectedBackgroundView = [[UIView alloc]initWithFrame:bgFrame];
    _selectedBackgroundView.backgroundColor = [UIColor systemBlueColor];
    _selectedBackgroundView.layer.cornerRadius = _selectedBackgroundView.frame.size.height/2;
    
    self.selectedBackgroundView = _selectedBackgroundView;
    CGPoint center = self.selectedBackgroundView.center;
    self.imAvatar.center = center;

}


-(void)setCellWithData:(NSArray *)data andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *imgName = [data[indexPath.row][@"avatar_filename"] componentsSeparatedByString:@"."][0];
    //将头像文件拖拽进了assets
    self.imAvatar.image = [UIImage imageNamed:imgName];
}
@end
