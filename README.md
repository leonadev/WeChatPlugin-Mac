MacWeChatPlugin
===============
适用于Mac版微信的小插件

目前已验证可用的版本：`2.3.30`



* 消息防撤回

  对方的撤回消息将不再生效（自己的撤回消息不受影响），并且可以知道对方正在撤回哪条消息。
  
* 红包提醒

  收到红包时（即使关闭了消息通知），将在本地通知中心收到一条通知，让你不再错过群红包！
  
* 禁止微信检测更新

  屏蔽了微信自动检测更新。
  
  

使用方法
------
安装：

下载并打开工程，Edit Scheme，Executable 如果为 None，则更改一下指向/Applications/WeChat.app，否则无法执行Run操作。

先进行Build(`command+B`)，然后Run(`command+R`)，此时会启动微信并完成注入，之后Stop并关闭工程，重新打开微信即可。

卸载：

打开`/Application/WeChat.app/Contents/MacOS/`，移除`WeChatPlugin.framework`和`WeChat`，并将`WeChat_backup`重命名为`WeChat`即可。

用到的工具
--------
* [insert_dylib](https://github.com/Tyilo/insert_dylib)
