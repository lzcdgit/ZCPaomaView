//
//  PaoMaView.h
//  跑马灯
//  第一次上传GitHub ,希望能点下Star或者提提意见,谢谢.
//  https://github.com/lzcdgit
//  目前还没有很好的封装,后续会优化.
//  Created by lzc on 2018/7/17.
//  Copyright © 2018年 lzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCPaomaDelegate<NSObject>

@optional

- (void)reloadPaomaView:(UILabel *)view dataAry:(NSMutableArray *)dataAry;
- (void)reloadAlwayShowPaomaView:(UILabel *)view dataAry:(NSMutableArray *)dataAry;


@end



@interface PaoMaView : UIView

@property (nonatomic , weak)id<ZCPaomaDelegate>delegate;

@property (nonatomic , strong) UILabel *oneLB;

@property (nonatomic , strong) UILabel *twoLB;

@property (nonatomic , strong)NSMutableArray *dataAry;


- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTextFontSize:(CGFloat)fontSize withStopTime:(NSInteger)interval withScrollSpeed:(CGFloat )speed;

- (void)start;
- (void)reloadData;

- (CGFloat)getFontSizeOfWidth:(NSString *)str fontHeigt:(CGFloat)fontHeight;
@end
