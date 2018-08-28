MacWeChatPlugin
===============
适用于Mac版微信的小插件

* 消息防撤回

  对方的撤回消息将不再生效，并且可以知道对方正在撤回哪条消息。
  
  自己的撤回消息不受影响。
  
  

使用方法
------
安装：

下载打开工程，先进行Build(`command+B`)，然后Run(`command+R`)，此时会启动微信并完成注入，之后Stop并关闭工程，重新打开微信即可。

卸载：

打开`/Application/WeChat.app/Contents/MacOS/`，移除`WeChatPlugin.framework`和`WeChat`，并将`WeChat_backup`重命名为`WeChat`即可。

用到的工具
--------
* [insert_dylib](https://github.com/Tyilo/insert_dylib)
