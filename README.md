# chanllenge

本项目用于学习OC
## 总体设计思路
1. 利用tableview进行下方的json文件的展示，并实现类似抖音的上下切换的效果；
    a. UITableview设置
2. 利用collectionview进行上方的横向照片的展示，实现切换，选中的效果；
3. 通过某种方式实现上下部分的同步；

## 问题：
1. block frame bounds sender selector notifier、协议 即oc语法问题；
2. 各种view控件的问题例如UItableview collectionview UIScrollview使用方法；
3. 文档的安装；
- 自带的文档就够用了
4. json文件的读取，jsonmodel？？
- 可以通过NSData封装的方法直接将Json文件内容转为NSData，之后再转为需要的形式；
5. 如何实现同步的功能； 
6. controller view delegate datasource分别是什么，各自的关系又是如何的。比如我要创建一个界面到底应该如何做？如果用代码进行创建是否只能等到运行时才能看到效果？
- controller控制器，主要就是通过来吗来控制视图的各种行为活动，以及交互反应；
- view视图，界面上看到的所有东西；
- delegate代理，控制视图的大小等属性的设定？
- datasource数据源，可以说需要展示数据的视图类型需要通过这个协议来进行数据的读取，相当于不需要在所有的视图类型中都实现个字的数据读取方法；
7. 数组arry的用法；
- 具体方法参照文档，取元素可用[]；
8. 动态调整view的大小；
9. cell内的内容如何代码写出来？
10. NSData,NSString用法意义
11. 定义cell的布局，subview view关系，定义方式，编辑方式；
- 可以通过xib的方式可视化的构建自定义cell；
- 通过自定义layout的方式，构建自定义布局；
12. reuseid?是什么意思；
- 一个使得cell可以复用的名称罢了。
13. 懒加载什么时候需要？
14. 如何实现上方的居中，起始位置为第一个头像，滑动结束居中，与下方的同步，如何设置选中效果；
- 上方的居中，需要设置左右的填充；
- 滑动结束居中通过的自定义layout中的方法进行设置
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
NSArray *arr = [super layoutAttributesForElementsInRect:rect];计算结束时，离得最近的偏移量，再偏移过去；
- 选中效果目前使用的是设置选中背景颜色和形状，如何在滚动时有选中切换的效果呢？
15. plist是啥？
16. 各种UIView控件的size的确定；
17. 同步的实现和选中效果的实现；


## 笔记
1. uitableview显示数据 datasource属性
- 1. 设置数据源对象（使用viewcontroller本身的方法拖线+代码中在view中将controller传递给它） 
- 2. 让数据源对象遵守协议，实现UItableviewDataSource中的一些方法
重写的方法必须的有三个：
需要分几组
每组显示几行数据
单元格内容设置；

2. NSData相当于一种数据的形式，可以用作buffer？
3. NSArray，NSDictionary取元素值的方式都可以通过中括号，但字典的键需要使用OC风格字符串，即加@符号；
4. git放弃本地修改通过source contrl->Discard All changes
5. 自定义flowcelllayout也需要遵守一个代理协议；
6. 选中居中通过collectionview的代理方法进行实现；
7. 设置圆形，View.layer.conerRadius
8. 有center方法可以获取view的中点，有convert方法可以更换坐标系；

## 与要求不同的
1. 在滑动上方collectionview的时候无法同时滑动，所有的同步都是在事件完成之后完成的，完成滑动的时间不一致；
2. 应该与1.是相同的原因，导致了滑动过程中的选中无法按次序切换；尝试了在didscroll代理方法中进行中间的选中，会导致点击的时候出现闪烁的现象；
3. 有一种方式是计算上下滑动距离的比例，然后将偏移量给下面的；问题在于，如何在控制器🥱中得到各自view的滑动距离？计算得到正确的比例？

