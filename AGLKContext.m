//
//  AGLKContext.m
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import "AGLKContext.h"

@implementation AGLKContext

-(void) setClearColor:(GLKVector4)clearColorRGBA
{
    clearColor = clearColorRGBA;
    glClearColor(clearColorRGBA.r, clearColorRGBA.g, clearColorRGBA.b, clearColorRGBA.a);
}

-(GLKVector4)clearColor
{
    return clearColor;
}

-(void)clear:(GLbitfield)mask
{
    glClear(mask);
}
@end

@implementation AGLKVertexAttriArrayBuffer

@synthesize glName;
@synthesize bufferSizeBytes;
@synthesize stride;

-(id)initWithAttribStride:(GLsizeiptr)astride numberOfVertices:(GLsizei)count data:(const GLvoid*)dataPtr usage:(GLenum)usage
{
    NSParameterAssert(0<astride);
    NSParameterAssert(0 <count);
    NSParameterAssert(NULL != dataPtr);
    if(nil != (self =[super init]))
    {
        stride = astride;
        bufferSizeBytes = stride * count;
        glGenBuffers(1, &glName);
        glBindBuffer(GL_ARRAY_BUFFER, glName);
        glBufferData(GL_ARRAY_BUFFER, bufferSizeBytes, dataPtr, usage);
    }
    return self;
}
-(void)prepareToDrawWithAttrib:(GLuint)index numberOfCoordinates:(GLuint)count attribOffset:(GLsizeiptr)offset shouldEnable:(BOOL)shouleEnable
{
    glBindBuffer(GL_ARRAY_BUFFER,glName);
    if(shouleEnable)
    {
        glEnableVertexAttribArray(index);
    }
    glVertexAttribPointer(index, count, GL_FLOAT, GL_FALSE, (int)stride, NULL+offset);
}

-(void)drawArraryWithMode:(GLenum)mode startVertexIndex:(GLint)first numberOfVertices:(GLsizei)count
{
    glDrawArrays(mode, first, count);
}


-(void)dealloc
{
    if(0 != glName)
    {
        glDeleteBuffers(1, &glName);
    }
}



@end







