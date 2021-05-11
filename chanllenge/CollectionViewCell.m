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
    NSInteger size = [UIScreen mainScreen].bounds.size.width/5.0f;
    CGSizeMake(size-10, size-10);
    CGRect bgFrame = self.frame;
    bgFrame.size = CGSizeMake(size-10, size-10);
    UIView *_selectedBackgroundView = [[UIView alloc]initWithFrame:bgFrame];
    _selectedBackgroundView.backgroundColor = [UIColor systemBlueColor];
    _selectedBackgroundView.layer.cornerRadius = _selectedBackgroundView.frame.size.height/2;
    
    self.selectedBackgroundView = _selectedBackgroundView;
    CGPoint center = self.selectedBackgroundView.center;
    center = [self convertPoint:center toView:self.imAvatar];
    self.imAvatar.center =center;
    
}


-(void)setCellWithData:(NSArray *)data andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *imgName = [data[indexPath.row][@"avatar_filename"] componentsSeparatedByString:@"."][0];
    self.imAvatar.image = [UIImage imageNamed:imgName inBundle:[NSBundle bundleWithPath:@"/Users/baiyuying/xcode_codes/chanllenge/chanllenge/Resource"] withConfiguration:nil];
}
@end
