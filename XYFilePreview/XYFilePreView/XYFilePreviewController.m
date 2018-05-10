//
//  XYFilePreviewController.m
//  ServiceIntelligent
//
//  Created by xieqilin on 2018/1/16.
//  Copyright © 2018年 xieqilin. All rights reserved.
//

#import "XYFilePreviewController.h"

@interface XYFilePreviewController ()
<QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, copy) void(^willDismissBlock)();
@property (nonatomic, copy) void(^didDismissBlock)();
@property (nonatomic, copy) BOOL(^shouldOpenUrlBlock)(NSURL *url, id <QLPreviewItem>item);
@property (nonatomic, strong) NSArray *filePathArr;

@end

@implementation XYFilePreviewController

#pragma mark - life cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - private methods
- (void)jumpWith:(XYJumpMode)jump on:(UIViewController *)vc{
    switch (jump) {
        case XYJumpPush:
        case XYJumpPushAnimat:
            [vc.navigationController pushViewController:self animated:(jump == XYJumpPushAnimat)];
            break;
        case XYJumpPresent:
        case XYJumpPresentAnimat:
            [vc presentViewController:self animated:(jump == XYJumpPresentAnimat) completion:nil];
            break;
    }
    [self reloadData];
}

#pragma mark - public methods
- (void)previewFileWithPaths:(NSArray <NSString *>*)filePathArr  on:(UIViewController *)vc jump:(XYJumpMode)jump{
    self.filePathArr = filePathArr;
    [self jumpWith:jump on:vc];
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return self.filePathArr.count;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSURL *url = [NSURL fileURLWithPath:self.filePathArr[index]];
    return  url;
}

#pragma mark - QLPreviewControllerDelegate
/*!
 * @abstract Invoked before the preview controller is closed.
 */
- (void)previewControllerWillDismiss:(QLPreviewController *)controller{
    !self.willDismissBlock?:self.willDismissBlock();
}

/*!
 * @abstract Invoked after the preview controller is closed.
 */
- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
    !self.didDismissBlock?:self.didDismissBlock();
}

/*!
 * @abstract Invoked by the preview controller before trying to open an URL tapped in the preview.
 * @result Returns NO to prevent the preview controller from calling -[UIApplication openURL:] on url.
 * @discussion If not implemented, defaults is YES.
 */
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item{
    return !self.shouldOpenUrlBlock?YES:self.shouldOpenUrlBlock(url, item);
}

#pragma mark - event response

#pragma mark - getters and setters
- (void)setWillDismissBlock:(void (^)())willDismissBlock{
    if(!willDismissBlock) return;
    _willDismissBlock = [willDismissBlock copy];
}

- (void)setDidDismissBlock:(void (^)())didDismissBlock{
    if(!didDismissBlock) return;
    _didDismissBlock = [didDismissBlock copy];
}

- (void)setShouldOpenUrlBlock:(BOOL (^)(NSURL *, id<QLPreviewItem>))shouldOpenUrlBlock{
    if(!shouldOpenUrlBlock) return;
    _shouldOpenUrlBlock = [shouldOpenUrlBlock copy];
}


@end
