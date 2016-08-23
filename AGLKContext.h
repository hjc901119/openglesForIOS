//
//  AGLKContext.h
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//
 
#import <GLKit/GLKit.h>

@interface AGLKVertexAttriArrayBuffer : NSObject
{
    GLsizeiptr stride;
    GLsizeiptr bufferSizeBytes;
    GLuint     glName;
}

@property(nonatomic,readonly)GLsizeiptr stride;
@property(nonatomic,readonly)GLsizeiptr bufferSizeBytes;
@property(nonatomic,readonly)GLuint     glName;


-(id)initWithAttribStride:(GLsizeiptr)stride numberOfVertices:(GLsizei)count data:(const GLvoid*)dataPtr usage:(GLenum)usage;

-(void)prepareToDrawWithAttrib:(GLuint)index numberOfCoordinates:(GLuint)count attribOffset:(GLsizeiptr)offset shouldEnable:(BOOL)shouleEnable;

-(void)drawArraryWithMode:(GLenum)mode startVertexIndex:(GLint)first numberOfVertices:(GLsizei)count;

@end



@interface AGLKContext : EAGLContext
{
    GLKVector4 clearColor;

}
@property(nonatomic,assign)GLKVector4 clearColor;
-(void)clear:(GLbitfield)mask;

@end
