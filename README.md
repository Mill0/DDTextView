# DDTextView
- DDTextView对UITextView的一个修改, 使其看起来像书信的一种格式, 使用简单方便.

* [Examples 【示例】](#Examples)
```objc
    // 初始化
    EHTextView *myView = [[EHTextView alloc] initWithFrame:CGRectMake(16, 20, self.view.frame.size.width - 32, 100) addText:@"Open your misty eyes\n拨开笼罩的迷雾\nHere comes another fight\n新的战役将要开始\nThere's a stormy night\n还有一场腥风血雨之夜\nBefore the morning arrives\n在天亮以前\nNo matter where you go \n无论你去往哪里\nI will follow you\n我都会跟随\nKeep careful watch of your soul\n紧紧守护你的灵魂 " addRowHeight:40];
    
    // 设置字体大小, 也可以不在这里设置, 默认第一行为17 后面为15
    //    myView.font = [UIFont systemFontOfSize:17];
    
    // 添加
    [self.view addSubview:myView];
 ```
* Tell you what ?
![fscalendar---headeralpha]()
