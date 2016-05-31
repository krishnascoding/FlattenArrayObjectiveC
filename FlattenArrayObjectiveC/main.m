//
//  main.m
//  FlattenArrayObjectiveC
//
//  Created by Krishna Ramachandran on 5/30/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlattenArray : NSObject
@property (nonatomic) NSMutableArray *flattenedArr; // Our flattened array will be stored in this NSMutableArray
@end

@implementation FlattenArray
-(FlattenArray *)init {
    self = [super init];
    if (self) {
        _flattenedArr = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)flattenArray:(NSArray *)array atIndex:(int)index
{
    if ((array.count == index) || ![array objectAtIndex:index])  { // Return if current index is beyond bounds of array or nil
        return;
        
    } else if ([[array objectAtIndex:index] isKindOfClass:[NSArray class]]) { // See if object at current index is type array
        
        NSArray *newArr = [array objectAtIndex:index];   // If yes, save object as variable called newArr
        [self flattenArray:newArr atIndex:0];        // Recursively call flattenArray method on newArr
        
    } else {
        
        // NSLog(@"%@", [array objectAtIndex:index]);     // Print object at current index if it is not of type array
        [self.flattenedArr addObject:[array objectAtIndex:index]];   // Save object to the new NSMutableArray property called flattenedArr
    }
    
    [self flattenArray:array atIndex:index + 1];    // Recursively call flattenArray method on object at next index
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Create our test array which has multiple nested arrays
        NSArray *arr = [NSArray arrayWithObjects:@1, @[@2, @3, @4, @[@5, @[@6, @7]], @8], @9, @[@[@10], @11, @12, @13], @14, @15, nil];
        
        // Create an instance of FlattenArray
        FlattenArray *flattenArr = [[FlattenArray alloc] init];
        
        // Call the flattenArray method with arr as the argument and starting index set to 0
        [flattenArr flattenArray:arr atIndex:0];
        
        // Log our NSMutableArray flattenedArr so we can see it
        NSLog(@"%@", [flattenArr flattenedArr]);
    
    }
    return 0;
}

