//
//  ViewController.m
//  DrawZigzag
//
//  Created by admin on 7/23/15.
//  Copyright (c) 2015 triocviet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *row;
@property (weak, nonatomic) IBOutlet UITextField *edge;
- (IBAction)draw:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void) drawZigzag:(int) row edge:(int) edge {
    NSString *f = [self genFirstRow:row edge:edge];
    NSString *s = [self genSecondRow:f];
    printf("%s\n",f.UTF8String);
    printf("%s\n",s.UTF8String);
    NSString *r = [NSString stringWithString:s];
    for (int i =2; i<row; i++) {
        r = [self genNextRow:r];
        printf("%s\n",r.UTF8String);
    }
}

-(NSString *) genFirstRow:(int) row edge:(int) edge {
    int a = row -1;
    int b = row*2 -3;
    NSMutableString *firstRow = [[NSMutableString alloc] init];
    NSMutableString *append = [[NSMutableString alloc] init];
    for (int i = 0; i<a; i++) {
        [firstRow appendString:@" "];
    }
    [firstRow appendString:@"x"];
    for (int i = 0; i<b; i++) {
        [append appendString:@" "];
    }
    [append appendString:@"x"];
    
    for (int i=0; i<((edge+1)/2-1); i++) {
        [firstRow appendString:append];
    }
    return [NSString stringWithString:firstRow];
}

-(NSString *)genSecondRow:(NSString *) firstRow {
    NSString *secondRow = [[NSString alloc] init];
    secondRow = [firstRow stringByReplacingOccurrencesOfString:@" x " withString:@"x x"];
    if ([secondRow characterAtIndex:0] == 'x') {
        secondRow = [secondRow stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@" x"];
    }
    if ([secondRow characterAtIndex:(secondRow.length-1)] == 'x') {
        secondRow = [secondRow stringByReplacingCharactersInRange:NSMakeRange(secondRow.length-2, 2) withString:@"x "];
    }
    return secondRow;
}
-(NSString *)genNextRow:(NSString *) str {
    NSMutableString *row = [[NSMutableString alloc] init];
    if ([str characterAtIndex:0] == 'x') {
        return str;
    }
    int count =0;
    for (int i=0; i<str.length; i++) {
        if ([str characterAtIndex:i] == 'x') {
            count++;
            if (count%2 == 1) {
                if (i>0) {
                    [row deleteCharactersInRange:NSMakeRange(i-1, 1)];
                }
                [row appendString:@"x "];
            } else {
                [row appendString:@" x"];
                i++;
            }
        } else {
            [row appendString:@" "];
        }
    }
    return [NSString stringWithString:row];
}

- (IBAction)draw:(id)sender {
    int row = _row.text.intValue;
    int edge = _edge.text.intValue;
    [self drawZigzag:row edge:edge];
}
@end
