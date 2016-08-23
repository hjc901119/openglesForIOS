//
//  openglesView.h
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "AGLKContext.h"

@interface openglesView : GLKViewController
{
    GLuint vertexBufferID;
    GLuint textureBuffer;
    AGLKVertexAttriArrayBuffer *arraryBuffer;

}

@property(strong,nonatomic)GLKBaseEffect *baseEffect;
@end
