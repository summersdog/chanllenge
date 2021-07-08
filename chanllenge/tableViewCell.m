//
//  MyCell.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/4/19.
//

#import "tableViewCell.h"

@interface tableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;

@end

@implementation tableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSArray *)data andIndex:(NSInteger)index{
    NSMutableAttributedString *first_name = [[NSMutableAttributedString alloc]initWithString:data[index][@"first_name"]];
    NSMutableAttributedString *last_name = [[NSMutableAttributedString alloc]initWithString:data[index][@"last_name"]];

    [last_name addAttribute:NSForegroundColorAttributeName value:[UIColor systemGrayColor] range:NSMakeRange(0,last_name.length)];
    
    [first_name appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@" "]];
    [first_name appendAttributedString:last_name];
    
    _nameLabel.attributedText = first_name;
    _titleLabel.text = data[index][@"title"];
    _introductionTextView.text = data[index][@"introduction"];
    
}

@end
