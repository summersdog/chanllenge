# chanllenge

本项目用于学习OC
## 总体设计思路
1. 利用tableview进行下方的json文件的展示，并实现类似抖音的上下切换的效果；
2. 利用collectionview进行上方的横向照片的展示，实现切换，选中的效果；
3. 通过某种方式实现上下部分的同步；

## 问题：
1. block frame bounds sender selector notifier、协议 即oc语法问题；
- frame和bounds都是用来描述视图大小和位置的，不同的是两者的坐标系不同，frame使用的是父视图的坐标系，而bounds则是本地视图；
- protocol，类似于接口？
- SEL是用于存储对象方法-()的地址的数据类型，可以理解为函数指针？取地址使用@selector
- block是用于存储匿名函数的数据类型；
2. 各种view控件的问题例如UItableview collectionview UIScrollview使用方法；
- 基本上视图的外观设置通过xib和新创建的类来控制；有关数据的问题，通过datasource协议方法来处理；与交互相关的，比如滚动选中等等通过代理方法来处理；
3. 文档的安装；
- 自带的文档就够用了
4. json文件的读取，jsonmodel？？
- 可以通过NSData封装的方法直接将Json文件内容转为NSData，之后再转为需要的形式；
5. 如何实现同步的功能； 
- 通过共有的currentindex，同时在didscroll代理中进行滚动的同步，通过计算滚动的比例，来同步，在滚动某一个视图的时候，同时滚动另一个视图；
6. controller view delegate datasource分别是什么，各自的关系又是如何的。比如我要创建一个界面到底应该如何做？如果用代码进行创建是否只能等到运行时才能看到效果？
- controller控制器，主要就是通过代码来控制视图的各种行为活动，以及交互反应；
- view视图，界面上看到的所有东西；
- delegate代理，控制视图的大小等属性的设定？
- datasource数据源，可以说需要展示数据的视图类型需要通过这个协议来进行数据的读取，相当于不需要在所有的视图类型中都实现个字的数据读取方法；
7. 数组arry的用法；
- 具体方法参照文档，取元素可用[]；
8. 动态调整view的大小；
- 在view中可以通过setframe或者setbounds来处理
9. cell内的内容如何代码写出来？
- datasource中的方法
10. NSData,NSString用法意义
11. 定义cell的布局，subview view关系，定义方式，编辑方式；
- 可以通过xib的方式可视化的构建自定义cell；
- 通过自定义layout的方式，构建自定义布局；
12. reuseid?是什么意思；
- 一个使得cell可以复用的名称罢了。
13. 懒加载什么时候需要？
14. 如何实现上方的居中，起始位置为第一个头像，滑动结束居中，与下方的同步，如何设置选中效果；
- 上方的居中，需要设置左右边缘的填充；
- 滑动结束居中通过的自定义layout中的方法进行设置，或者通过代理方法也可；
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
NSArray *arr = [super layoutAttributesForElementsInRect:rect];计算结束时，离得最近的偏移量，再偏移过去；
15. 选中效果目前使用的是设置选中背景颜色和形状，如何在滚动时有选中切换的效果呢？
- 在didscroll代理方法中获取当前中点的indexpath并设置选中
16. plist是啥？
17. 各种UIView控件的size的确定，以及多个文件中需要获取某个控件的size的时候怎么做；
18. 同步的实现和选中效果的实现；
- 通过滑动的比例进行同步；
19. collectionView右边有白边
- 原因是拖拽出来的并不能覆盖手机宽度，设置View的大小最好还是通过代码进行计算之后设置


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
9. cell的size的设置顺序是，先是每个cell从nib文件中读取，所以在自定义cell文件中获取的size大小是nib文件中的设置，之后才是通过layout文件中的代码设置，最后才是通过delegate进行设置；
10. navigatorbar的高度无法调整，stackoverflow上的推荐做法是填充一个空白的view
11. 右侧的白边问题，是通过storyboard直接拖拽的collectionview的大小问题，在viewdidload里面重新设置了collectionview的大小即可。
- 

## 与要求不同的
1. 在滑动上方collectionview的时候无法同时滑动，同步是在事件完成之后完成的，完成滑动的时间不一致；
- 已解决
2. 点击的时候出现闪烁的现象；
- 已解决，先选中当前的item，之后滑动过去，通过滚动代理来进行目标的选中；
3. 有一种方式是计算上下滑动距离的比例，然后将偏移量给下面的；问题在于，如何在控制器中得到各自view的滑动距离？计算得到正确的比例？
- 这种方法可行，需要注意的是计算正确每个位置的size大小；

