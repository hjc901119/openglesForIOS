//
//  AGLKView.m
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import "AGLKView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AGLKView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@synthesize delegate;
@synthesize context;

+(Class) layerClass
{
    return [CAEAGLLayer class];
}
@end
