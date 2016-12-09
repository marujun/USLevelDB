//
//  ViewController.m
//  USLevelDB
//
//  Created by marujun on 2016/12/9.
//  Copyright © 2016年 MaRuJun. All rights reserved.
//

#import "ViewController.h"
#import "LevelDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LevelDB *ldb = [LevelDB databaseInLibraryWithName:@"test1.ldb"];
    
    ldb[@"string_test"] = @"laval"; // same as:
//    [ldb setObject:@"laval" forKey:@"string_test"];
    
    NSLog(@"String Value: %@", ldb[@"string_test"]); // same as:
    NSLog(@"String Value: %@", [ldb objectForKey:@"string_test"]);
    
    [ldb setObject:@{@"key1" : @"val1", @"key2" : @"val2"} forKey:@"dict_test"];
    NSLog(@"Dictionary Value: %@", [ldb objectForKey:@"dict_test"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
