PROJECT = "ALIYUN"
VERSION = "1.0.0"

require "log"

require "sys"

require "net"

require "netLed"

require "errDump"

LOG_LEVEL = log.LOGLEVEL_TRACE
--每1分钟查询一次GSM信号强度
--每1分钟查询一次基站信息
net.startQueryAll(60000, 60000)

--此处关闭RNDIS网卡功能
ril.request("AT+RNDISCALL=0,1")

pmd.ldoset(15, pmd.LDO_VLCD)
netLed.setup(true, pio.P0_1, pio.P0_4)

--加载错误日志管理功能模块
errDump.request("udp://ota.airm2m.com:9072")

--加载阿里云功能测试模块
require "testALiYun"

--启动系统框架
sys.init(0, 0)
sys.run()
