//
//  openglesView.m
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import "openglesView.h"
#import <GLKit/GLKTextureLoader.h>

typedef struct {
    GLKVector3 positionCoords;
    GLKVector2 texttureCoords;
}SceneVertex;

static const SceneVertex vertices[]=
{
    {{-0.5f,-0.5f,0.0},{0.0f,0.0f}},
    {{0.5f,-0.5f,0.0},{1.0f,0.0f}},
    {{-0.5f,0.5f,0.0},{0.0f,1.0f}}
};

@implementation openglesView
-(void) viewDidLoad
{
    [super viewDidLoad];
//
    GLKView *view = (GLKView*)self.view;
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
   
    ((AGLKContext*)view.context).clearColor = GLKVector4Make(0.50f, 1.0f, 1.0f, 1.0f);

    arraryBuffer = [[AGLKVertexAttriArrayBuffer alloc] initWithAttribStride:sizeof(SceneVertex) numberOfVertices:sizeof(vertices)/sizeof(SceneVertex) data:vertices usage:GL_STATIC_DRAW];

    CGImageRef imageRef = [[UIImage imageNamed:@"icon.png"] CGImage];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:imageRef options:nil error:nil];
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
    
    
//    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
//    
//    GLKView *view = (GLKView*)self.view;
//    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
//    [EAGLContext setCurrentContext:view.context];
//    
//
//    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
//    self.baseEffect = [[GLKBaseEffect alloc] init];
//    self.baseEffect.useConstantColor = GL_TRUE;
//    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.baseEffect prepareToDraw];
    
    [(AGLKContext*)view.context clear:GL_COLOR_BUFFER_BIT];
    [arraryBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition numberOfCoordinates:3 attribOffset:offsetof(SceneVertex,positionCoords) shouldEnable:YES];

    [arraryBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0 numberOfCoordinates:2 attribOffset:offsetof(SceneVertex, texttureCoords) shouldEnable:YES];
    
    [arraryBuffer drawArraryWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:3];
    
//    glClear(GL_COLOR_BUFFER_BIT);
//    glClear(GL_DEPTH_BUFFER_BIT);
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
//       glDrawArrays(GL_TRIANGLES, 0, 3);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    glVertexAttribPointer(GLKVertexAttribTexCoord0,2,GL_FLOAT,GL_FALSE,sizeof(SceneVertex),NULL);
//    
//    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    
}

-(void) viewDidUnload
{
    [super viewDidUnload];
    GLKView *view = (GLKView*)self.view;
    [EAGLContext setCurrentContext:view.context];
    
    if(0 != vertexBufferID)
    {
        glDeleteBuffers(1, &vertexBufferID);
        vertexBufferID = 0;
    }
    
    ((GLKView*)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
}


@end
