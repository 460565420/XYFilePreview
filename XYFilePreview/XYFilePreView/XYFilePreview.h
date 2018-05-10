//
//  XYFilePreview.h
//  ServiceIntelligent
//
//  Created by xieqilin on 2018/1/16.
//  Copyright © 2018年 xieqilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYFilePreview : UIView

/** 快速预览单个文件 */
+ (void)previewFileWithPaths:(NSString *)filePath;

@end
