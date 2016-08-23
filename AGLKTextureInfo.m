//
//  AGLKTextureInfo.m
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import "AGLKTextureInfo.h"

typedef enum
{
    AGLK1 = 1,
    AGLK2 = 2,
    AGLK4 = 4,
    AGLK8 = 8,
    AGLK16 = 16,
    AGLK32 = 32,
    AGLK64 = 64,
    AGLK128 = 128,
    AGLK256 = 256,
    AGLK512 = 512,
    AGLK1024 = 1024,
}
AGLKTPowerOf2;

@implementation AGLKTextureInfo

@synthesize name;
@synthesize target;
@synthesize width;
@synthesize height;


-(id)initWithName:(GLuint)aName target:(GLenum)aTarget width:(GLuint)aWidth height:(GLuint)aHeight
{
        if(nil != (self = [super init]))
        {
            name = aName;
            target = aTarget;
            width = aWidth;
            height = aHeight;
        }
    return self;
}


+(AGLKTextureInfo*)textureWithCGImage:(CGImageRef)cgImage options:(NSDictionary*)options error:(NSError**)outError
{
    size_t width;
    size_t height;
    NSData *imageData = AGLKDataWithResizedCGImageBytes(cgImage, &width, &height);
    
    GLuint textureBufferID;
    glGenBuffers(1, &textureBufferID);
    glBindBuffer(GL_TEXTURE_2D, textureBufferID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (int)width, (int)height, 0, GL_RGBA,GL_UNSIGNED_BYTE,[imageData bytes]);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    AGLKTextureInfo *result = [[AGLKTextureInfo alloc] initWithName:textureBufferID target:GL_TEXTURE_2D width:(GLuint)width height:(GLuint)height];
    
    return result;
}

static AGLKTPowerOf2 AGLKCaculatePowerOf2ForDimension(GLuint dimension)
{
    AGLKTPowerOf2 result = AGLK1;
    if (dimension > (GLuint)AGLK512)
    {
        result  = AGLK1024;
    }
    else if(dimension > (GLuint)AGLK256)
    {
        result = AGLK512;
    }
    else if(dimension > (GLuint)AGLK128)
    {
        result = AGLK256;
    }
    else if(dimension > (GLuint)AGLK64)
    {
        result = AGLK128;
    }
    else if(dimension > (GLuint)AGLK32)
    {
        result = AGLK64;
    }
    else if(dimension > (GLuint)AGLK16)
    {
        result = AGLK32;
    }
    else if(dimension > (GLuint)AGLK8)
    {
        result = AGLK16;
    }
    else if(dimension > (GLuint)AGLK4)
    {
        result = AGLK8;
    }
    else if(dimension > (GLuint)AGLK2)
    {
        result = AGLK4;
    }
    else if(dimension > (GLuint)AGLK1)
    {
        result = AGLK2;
    }
    
    return result;
}
static NSData *AGLKDataWithResizedCGImageBytes(CGImageRef cgImage,size_t *widthPtr,size_t *heightPtr)
{
    NSCParameterAssert(NULL != cgImage);
    NSCParameterAssert(NULL != widthPtr);
    NSCParameterAssert(NULL != heightPtr);
    
    size_t originWidth = CGImageGetWidth(cgImage);
    size_t originHeight = CGImageGetHeight(cgImage);
    
    size_t width = AGLKCaculatePowerOf2ForDimension(originWidth);
    size_t height = AGLKCaculatePowerOf2ForDimension(originHeight);
    NSMutableData *imageData = [NSMutableData dataWithLength:height*width*4];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef cgContext = CGBitmapContextCreate([imageData mutableBytes],width,height,8,4*width,colorSpace,kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(cgContext, 0, height);
    CGContextScaleCTM(cgContext, 1.0, -1.0);
    CGContextDrawImage(cgContext, CGRectMake(0, 0, width, height), cgImage);
    CGContextRelease(cgContext);
    *widthPtr = width;
    *heightPtr = height;

    return imageData;
};


@end
