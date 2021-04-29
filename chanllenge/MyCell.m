//
//  MyCell.m
//  chanllenge
//
//  Created by 白瑜颖 on 2021/4/19.
//

#import "MyCell.h"

@interface MyCell()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvIntroduction;

@end

@implementation MyCell

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
    
    _lbName.attributedText = first_name;
    _lbTitle.text = data[index][@"title"];
    _tvIntroduction.text = data[index][@"introduction"];
    
}

@end
