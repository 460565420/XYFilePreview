//
//  XYFilePreview.m
//  ServiceIntelligent
//
//  Created by xieqilin on 2018/1/16.
//  Copyright © 2018年 xieqilin. All rights reserved.
//

#import "XYFilePreview.h"
#import <QuickLook/QuickLook.h>


@interface XYFilePreview ()
<QLPreviewControllerDataSource, QLPreviewControllerDelegate>
@property (nonatomic, assign) BOOL hindNav;
@property (nonatomic, strong) QLPreviewController *previewController;
@property (nonatomic, strong) NSArray *filePathArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewH;

@end

@implementation XYFilePreview

#pragma mark - life cycle
- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = [UIApplication sharedApplication].delegate.window.bounds;
    self.previewController = [[QLPreviewController alloc] init];
    self.previewController.dataSource = self;
    self.previewController.delegate = self;
}

-(void)layoutSubviews{
    self.previewController.view.frame = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight);
    self.topViewH.constant = SafeAreaTopHeight;
    [self addSubview:self.previewController.view];
}

#pragma mark - private methods

#pragma mark - public methods
/** 预览多个文件 单个数组只传一个就好 */
+ (void)previewFileWithPaths:(NSString *)filePath{
    XYFilePreview *previewView = [[NSBundle mainBundle] loadNibNamed:@"XYFilePreview" owner:nil options:nil].lastObject;
    previewView.filePathArr = @[filePath];
    previewView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].delegate.window addSubview:previewView];
    [UIView animateWithDuration:0.25 animations:^{
        previewView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [previewView.previewController reloadData];
    }];
}


#pragma mark - request methods

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return self.filePathArr.count;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSURL *url = [NSURL fileURLWithPath:self.filePathArr[index]];
    return  url;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view{
    return [UIApplication sharedApplication].delegate.window.bounds;
}

#pragma mark - event response
- (IBAction)backButtonClick:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)moreButtonClick:(id)sender {
    
    NSLog(@"更多按钮点击");
    
}


#pragma mark - getters and setters

@end
