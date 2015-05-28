//
//  NSDictionaryUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 6/4/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSDictionaryUtilsTest : XCTestCase { }
@end

@implementation NSDictionaryUtilsTest

- (void)testBoolValue {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"1", @"key1", 
												[NSNumber numberWithBool:YES], @"key2", 
												[NSNumber numberWithBool:NO], @"key3", 
												[NSNull null], @"key4", 
												nil];
	
	XCTAssertTrue([[dict gh_boolValueForKey:@"key1"] boolValue]);
	XCTAssertTrue([[dict gh_boolValueForKey:@"key2"] boolValue]);
	XCTAssertFalse([[dict gh_boolValueForKey:@"key3"] boolValue]);
	XCTAssertFalse([[dict gh_boolValueForKey:@"key4"] boolValue]);
}

- (void)testDataValue {
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"hwLWnp0tXoCzs+W0UdVPUaBSfiW1Q5B9m6xzDPFXvJqpqXvk1nnmMBNziXJWE4M823j8oSRl0uLhCAhxJW6ah7/a25DjGzwa", @"key1",
                        nil];
  NSData *data = [dict gh_dataAsBase64ForKey:@"key1" options:0];
  NSData *expected = [[NSData alloc] initWithBase64EncodedString:@"hwLWnp0tXoCzs+W0UdVPUaBSfiW1Q5B9m6xzDPFXvJqpqXvk1nnmMBNziXJWE4M823j8oSRl0uLhCAhxJW6ah7/a25DjGzwa" options:0];
  XCTAssertEqualObjects(data, expected);
}

- (void)testHasAllKeys {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"1", @"key1", 
												[NSNumber numberWithBool:YES], @"key2", 
												[NSNumber numberWithBool:NO], @"key3", 
												[NSNull null], @"key4", 
												nil];
	
	BOOL b;
	b = [dict gh_hasAllKeys:nil];
	XCTAssertTrue(b);	
	b = [dict gh_hasAllKeys:@"key1", nil];
	XCTAssertTrue(b);
	b = [dict gh_hasAllKeys:@"key1", @"key3", nil];
	XCTAssertTrue(b);
	b = [dict gh_hasAllKeys:@"key1", @"key4", nil];
	XCTAssertFalse(b);
	b = [dict gh_hasAllKeys:@"key1", @"key5", nil];
	XCTAssertFalse(b);
	b = [dict gh_hasAllKeys:@"key5", @"key1", nil];
	XCTAssertFalse(b);
}

- (void)testSubsetWithKeys {
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"1", @"key1", 
                        @"2", @"key2", 
												nil];
  
  NSDictionary *dictSubset = [dict gh_dictionarySubsetWithKeys:[NSArray arrayWithObject:@"key1"]];
  NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"key1", nil];
  XCTAssertEqualObjects(dictSubset, expected);
  
  // Test missing key
  NSDictionary *dictSubset2 = [dict gh_dictionarySubsetWithKeys:[NSArray arrayWithObject:@"key3"]];
  NSDictionary *expected2 = [NSDictionary dictionary];
  XCTAssertEqualObjects(dictSubset2, expected2);  
}

- (void)testCompact {
	NSMutableDictionary *dict = [@{@"key1": @"1", @"key2": [NSNull null]} mutableCopy];
  
  NSMutableDictionary *expected = [@{@"key1": @"1"} mutableCopy];

	NSDictionary *after = [dict gh_compactDictionary];
  XCTAssertEqualObjects(after, expected);
}

- (void)testJSON {
  NSDictionary *dict = @{@"key1": @(2), @"key2": @(3.1), @"key3": @YES};
  NSString *JSONString = [dict gh_toJSON:NSJSONWritingPrettyPrinted error:nil];
  NSLog(@"%@", JSONString);
  NSDictionary *dict2 = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
  XCTAssertEqualObjects(dict, dict2);
}

@end