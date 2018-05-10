//
//  XYFilePreviewController.h
//  ServiceIntelligent
//
//  Created by xieqilin on 2018/1/16.
//  Copyright © 2018年 xieqilin. All rights reserved.
//

#import <QuickLook/QuickLook.h>

typedef enum : NSUInteger {
    XYJumpPush,//push 无动画
    XYJumpPushAnimat,//push 有动画
    XYJumpPresent,//Present 无动画
    XYJumpPresentAnimat,//Present 有动画
} XYJumpMode;

@interface XYFilePreviewController : QLPreviewController

/** 预览多个文件 单个文件时数组传一个 */
- (void)previewFileWithPaths:(NSArray <NSString *>*)filePathArr on:(UIViewController *)vc jump:(XYJumpMode)jump;

/** 将要退出 */
- (void)setWillDismissBlock:(void (^)())willDismissBlock;

/** 已经退出 */
- (void)setDidDismissBlock:(void (^)())didDismissBlock;

/** 将要访问文件中的Url回调  BOOL 是否允许访问*/
- (void)setShouldOpenUrlBlock:(BOOL (^)(NSURL *, id<QLPreviewItem>))shouldOpenUrlBlock;

@end
