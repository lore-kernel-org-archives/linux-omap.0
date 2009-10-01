From: balajitk@ti.com
Subject: [PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to enable re-use
Date: Thu,  1 Oct 2009 17:46:49 +0530
Message-ID: <1254399409-3473-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37179 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756516AbZJAMRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Oct 2009 08:17:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, p_gortmaker@yahoo.com, a.zummo@towertech.it, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Balaji T K <balajitk@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. The common modules like RTC, Regulator creates opportunity
to re-use the most of the code from twl4030.

This patch renames few common drivers twl4030* files to twl* to enable
the code re-use.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-2430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-ldp.c                    |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
 arch/arm/mach-omap2/board-overo.c                  |    2 +-
 drivers/gpio/twl4030-gpio.c                        |    2 +-
 drivers/input/misc/twl4030-pwrbutton.c             |    2 +-
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/{twl4030-core.c => twl-core.c}         |    2 +-
 drivers/mfd/twl4030-irq.c                          |    2 +-
 drivers/regulator/Makefile                         |    2 +-
 .../{twl4030-regulator.c => twl-regulator.c}       |    2 +-
 drivers/rtc/Makefile                               |    2 +-
 drivers/rtc/{rtc-twl4030.c => rtc-twl.c}           |    2 +-
 drivers/usb/otg/twl4030-usb.c                      |    2 +-
 drivers/watchdog/twl4030_wdt.c                     |    2 +-
 include/linux/i2c/{twl4030.h => twl.h}             |    0 
 sound/soc/codecs/twl4030.c                         |    2 +-
 19 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/mfd/{twl4030-core.c => twl-core.c} (99%)
 rename drivers/regulator/{twl4030-regulator.c => twl-regulator.c} (99%)
 rename drivers/rtc/{rtc-twl4030.c => rtc-twl.c} (99%)
 rename include/linux/i2c/{twl4030.h => twl.h} (100%)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8ec2a13..bb68b10 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -19,7 +19,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ac262cd..2c86d50 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -19,7 +19,7 @@
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea383f8..b0e11a6 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -23,7 +23,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e00ba12..881b5ee 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -29,7 +29,7 @@
 #include <linux/mtd/nand.h>
 
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 864ee3d..db02b9e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -24,7 +24,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/leds.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 6bce230..4bf200a 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -26,7 +26,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 
 #include <linux/mtd/mtd.h>
diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index afad147..8446399 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -34,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 
 /*
diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index f5fc997..a73b889 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -27,7 +27,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #define PWR_PWRON_IRQ (1 << 0)
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 6f8a9a1..4e9d513 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
-obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-irq.o
+obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl-core.c
similarity index 99%
rename from drivers/mfd/twl4030-core.c
rename to drivers/mfd/twl-core.c
index ca54996..04d28c7 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl-core.c
@@ -36,7 +36,7 @@
 #include <linux/regulator/machine.h>
 
 #include <linux/i2c.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #include <mach/cpu.h>
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 7d43083..f1e6e39 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -32,7 +32,7 @@
 #include <linux/irq.h>
 #include <linux/kthread.h>
 
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 
 /*
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 4d762c4..0653ce8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
-obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
+obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o
 obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
 obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
diff --git a/drivers/regulator/twl4030-regulator.c b/drivers/regulator/twl-regulator.c
similarity index 99%
rename from drivers/regulator/twl4030-regulator.c
rename to drivers/regulator/twl-regulator.c
index e2032fb..c8a6e58 100644
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 
 /*
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 3c0f2b2..e331b1c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
-obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl4030.o
+obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
 obj-$(CONFIG_RTC_DRV_TX4939)	+= rtc-tx4939.o
 obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl.c
similarity index 99%
rename from drivers/rtc/rtc-twl4030.c
rename to drivers/rtc/rtc-twl.c
index 9c8c70c..93565be 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl.c
@@ -28,7 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 
 /*
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 9e3e7a5..591334d 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -33,7 +33,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index cb46556..20968b2 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #define TWL4030_WATCHDOG_CFG_REG_OFFS	0x3
 
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl.h
similarity index 100%
rename from include/linux/i2c/twl4030.h
rename to include/linux/i2c/twl.h
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4dbb853..2c47240 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -26,7 +26,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-- 
1.5.4.7

