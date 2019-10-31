# GCDWebServerDemo

## 使用GCDWebServer框架实现wifi局域网传输文件到iPhone的功能。
GitHub下载第三方框架：[https://github.com/swisspol/GCDWebServer](https://github.com/swisspol/GCDWebServer)。

下面直接进入正题：

### 步骤1：

将GCDWebServer框架中的文件导入项目中，需要的文件有：

1. GCDWebDAVServer文件夹下所有文件
2. GCDWebServer文件夹下所有文件
3. GCDWebUploader文件夹下所有文件

文件参考以下图片：
![](http://upload-images.jianshu.io/upload_images/4908799-6e06f90a5f331547.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/150)

### 步骤2：

添加动态库文件，如下图所示：
![](http://upload-images.jianshu.io/upload_images/4908799-e9e241e6144ae15f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)

### 步骤3：

配置Header Search Paths  -> $(SDKROOT)/usr/include/libxml2，如下图所示：
![](http://upload-images.jianshu.io/upload_images/4908799-5ceebaaa7ecd78d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)

### 步骤4：

配置webServer，并实现代理方法。

现在就可以运行一下代码，如下图：
![](http://upload-images.jianshu.io/upload_images/4908799-f5c2ea12d4750c8d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)

还是在网页中输入ip地址和端口试一试吧，效果如下图：
![](http://upload-images.jianshu.io/upload_images/4908799-8d0543f934298e3b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)

博客地址：[iOS项目之wifi局域网传输文件到iPhone的简单实现](https://www.cnblogs.com/sjxjjx/p/7430027.html)
