//
//  AGLKView.h
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class EAGLContext;
@protocol AGLKViewDelegate;

@interface AGLKView : UIView
{
    EAGLContext *context;
    GLuint defaultFrameBuffer;
    GLuint colorRenderBuffer;
    GLint drawbleWidth;
    GLint drawbleHeight;
}

@property(nonatomic,weak) IBOutlet id<AGLKViewDelegate> delegate;
@property(nonatomic,retain)EAGLContext *context;
@property(nonatomic,readonly)NSInteger drawableWidth;
@property(nonatomic,readonly)NSInteger drawbleHeight;

-(void) display;
@end

@protocol AGLKViewDelegate <NSObject>

@required
-(void)glkView:(AGLKView*)view drawInRect:(CGRect)rect;

@end
