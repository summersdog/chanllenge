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
}


-(void)setCellWithData:(NSArray *)data andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *imgName = [data[indexPath.row][@"avatar_filename"] componentsSeparatedByString:@"."][0];
    self.imAvatar.image = [UIImage imageNamed:imgName inBundle:[NSBundle bundleWithPath:@"/Users/baiyuying/xcode_codes/chanllenge/chanllenge/Resource/avatars"] withConfiguration:nil];
}
@end
