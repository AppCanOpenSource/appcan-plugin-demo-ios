//
//  MD5Degist.h
//  ZC
//
//  Created by yang yangfan on 10-8-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MD5Digest : NSObject {

}
+(NSString *)md5:(NSString *)str;
+(NSString *)urlencode:(NSString *)cStr;
//+(NSString *)urlencode:(NSString *)cStr withLen:(int)len ;


@end
