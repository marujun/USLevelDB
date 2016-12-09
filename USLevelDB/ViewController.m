//
//  ViewController.m
//  USLevelDB
//
//  Created by marujun on 2016/12/9.
//  Copyright © 2016年 MaRuJun. All rights reserved.
//

#import "ViewController.h"
#import "LevelDB.h"
#import <mach/mach.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"document path: %@",[paths objectAtIndex:0]);
    
    NSLog(@"meory used0: %@",[self usedMemory]);
    
    LevelDB *ldb = [LevelDB databaseInLibraryWithName:@"test.ldb"];
    ldb[@"string_test"] = @"laval"; // same as:
    [ldb setObject:@"laval" forKey:@"string_test"];
    
    NSLog(@"String Value: %@", ldb[@"string_test"]); // same as:
    NSLog(@"String Value: %@", [ldb objectForKey:@"string_test"]);
    
    NSLog(@"meory used1: %@",[self usedMemory]);
//    for (int i = 0; i< 1000000; i++) {
//        @autoreleasepool {
//            [ldb setObject:@{@"key1" : [NSString stringWithFormat:@"val1 %d",i], @"key2" : @"val2"} forKey:[NSString stringWithFormat:@"dict_test09876%d",i]];
//        }
//    }
    [ldb setObject:@{@"key1" : @"val1", @"key2" : @"val2"} forKey:@"dict_test"];
    NSLog(@"meory used2: %@",[self usedMemory]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设备内存大小相关
- (NSString *)freeMemory {
    return [NSByteCountFormatter stringFromByteCount:[self freeMemoryInBytes] countStyle:NSByteCountFormatterCountStyleMemory];
}

- (NSString *)usedMemory {
    return [NSByteCountFormatter stringFromByteCount:[self usedMemoryInBytes] countStyle:NSByteCountFormatterCountStyleMemory];
}

- (vm_size_t)freeMemoryInBytes {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return vm_page_size * vmStats.free_count;
}

- (vm_size_t)usedMemoryInBytes {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size;
}


@end
