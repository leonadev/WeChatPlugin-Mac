//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "PBGeneratedMessage.h"

@class NSString;

@interface SKBuiltinString_t : PBGeneratedMessage
{
    unsigned int hasString:1;
    NSString *string;
}

+ (id)parseFromData:(id)arg1;
+ (id)skStringWithString:(id)arg1;
@property(retain, nonatomic, setter=SetString:) NSString *string; // @synthesize string;
@property(readonly, nonatomic) BOOL hasString; // @synthesize hasString;
//- (void).cxx_destruct;
- (id)mergeFromCodedInputStream:(id)arg1;
- (int)serializedSize;
- (void)writeToCodedOutputStream:(id)arg1;
- (BOOL)isInitialized;
- (id)init;

@end

