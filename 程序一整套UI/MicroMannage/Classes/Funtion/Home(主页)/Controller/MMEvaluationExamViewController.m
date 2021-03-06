//
//  MMEvaluationExamViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/15.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationExamViewController.h"
#import "MMEvaluationExamCell.h"
#import "EvaluationExamModel.h"
#import "MMExamViewController.h"
@interface MMEvaluationExamViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMEvaluationExamViewController
-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"EvaluationExam.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [EvaluationExamModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self EESetUpSubviews];
    // Do any additional setup after loading the view.
}

#pragma mark - subViews
-(void)EESetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 88.0f;
    [self.tableView registerClass:[MMEvaluationExamCell class] forCellReuseIdentifier:@"MMEvaluationExamCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMEvaluationExamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEvaluationExamCell"];
    if(cell == nil){
        cell = [[MMEvaluationExamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEvaluationExamCell"];
    }
    
    if(indexPath.row == (self.plistArray.count - 1)){
        cell.cellLine.hidden = YES;
    }
    
    EvaluationExamModel *model =_plistArray[indexPath.row];
    [cell setCellModel:model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MMExamViewController *Evc = [MMExamViewController new];
    [self.parentViewController.navigationController pushViewController:Evc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
