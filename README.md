# SuperAlertView
自定义的 alertview   可以免除警告

// 警告框样式的


      SuperAlert * alertview=[[SuperAlert alloc]initWithTitle:@"温馨提示" message:@"网络连接错误请重试" clickButtonTitle:@[@"确定",@"取消"] buttonClick:^(NSInteger btIndex) {
       NSLog(@"%ld",(long)btIndex);

     } delegate:self];
    
    [alertview shown];
   
   
   
   // 输入框样式的
   
   //textfiled:填写的是 textfiled 的占位符  填写几个创建几个 textfiled 
   
   //message:可以不填写,填 nil
   
    SuperAlert * alertview=[[SuperAlert alloc]initWithTitle:@"superAlert" message:@"填写账号密码" textfiled:@[@"请输入账号",@"请输入密码"] clickButtonTitle:@[@"取消",@"确定"] buttonClick:^(NSInteger btIndex, NSMutableArray *strArr) {
      NSLog(@"%ld,%@",(long)btIndex,strArr);
  } delegate:self];
    
    [alertview shown];
    
    //代理方法可以不适用 因为已经有 block 了 如果想使用代理方法了 可以使用 
    
    使用 block 中的 strArr 为 textfiled 的内容

     -(void)superAlertView:(SuperAlert *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
     {
      NSLog(@"%ld",(long)buttonIndex);
     }
