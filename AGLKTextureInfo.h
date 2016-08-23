//
//  AGLKTextureInfo.h
//  openglesForIos
//
//  Created by 盛超 on 16/8/23.
//  Copyright © 2016年 hjc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface AGLKTextureInfo : NSObject
{
    @private
    GLuint name;
    GLenum target;
    GLuint width;
    GLuint height;
}

@property(readonly)GLuint name;
@property(readonly)GLenum target;
@property(readonly)GLuint width;
@property(readonly)GLuint height;

+(AGLKTextureInfo*)textureWithCGImage:(CGImageRef)cgImage options:(NSDictionary*)options error:(NSError**)outError;
-(id)initWithName:(GLuint)aName target:(GLenum)aTarget width:(GLuint)aWidth height:(GLuint)aHeight;
@end
