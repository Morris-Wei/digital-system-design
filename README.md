# Digital-system-design短学期作业
## A coded lock密码锁

- 功能描述：用于模仿密码锁的工作过程。完成密码锁的核心控制功能。
- 功能要求及验收要点：设计一个密码锁，平时处于等待状态。

## Details详细描述（3、5点）
1. 管理员可以通过设置（专用按键）更改密码。
2. 如果没有预置密码，密码缺省为“0000”。

3. 用户如果需要开锁，拨动相应的开关进入输入密码状态，输入4位密码，按下确定键后，若密码正确，锁打开，若密码错误，将提示密码错误，要求重新输入，三次输入都错误，将发出报警信号。

4. 报警后，只有管理员作相应的处理（专用按键）才能停止报警。

5. 用户输入密码时，在按下确定键之前，可以通过按退格键修正，每按一次退格键消除一位密码。

6. 正确开锁后，用户处理完毕后，按下确定键，系统回到等待状态。
7. 系统操作过程中，只要密码锁没有打开，如果10秒没有对系统操作，系统回到等待状态。
8. 系统操作过程中，如果密码锁已经打开，如果20秒没有对系统操作，系统自动上锁，回到等待状态。

**提示：
（1）	密码正确，锁打开时，可以使用开关上方的LED灯配合显示效果，比如LED全亮等。密码错误，提示信号也可以使用LED进行显示。报警信号也可以使用LED进行显示，比如不停的闪烁等。
（2）	数码管要充分使用，用以显示用户输入的数字等。**

## 硬件及环境
> NEXYS4 DDR ARTIX XC7A100T-CSG325
> Vivado 2018 采用VHDL编写

### 目前已完成所有八个功能
