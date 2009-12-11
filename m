From: balajitk@ti.com
Subject: [PATCH v4 01/08] ARM: OMAP: Rename twl4030* driver files to enable re-use
Date: Fri, 11 Dec 2009 21:26:04 +0530
Message-ID: <1260546964-22295-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46208 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbZLKP4n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 10:56:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, me@felipebalbi.com, peter.ujfalusi@nokia.com, dtor@mail.ru, p_gortmaker@yahoo.com, a.zummo@towertech.it, tony@atomide.com, wim@iguana.be, timo.t.kokkonen@nokia.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Balaji T K <balajitk@ti.com>

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
 drivers/input/keyboard/twl4030_keypad.c            |    2 +-
 drivers/input/misc/twl4030-pwrbutton.c             |    2 +-
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/{twl4030-core.c => twl-core.c}         |    2 +-
 drivers/mfd/twl4030-irq.c                          |    2 +-
 drivers/mfd/twl4030-power.c                        |    2 +-
 drivers/regulator/Makefile                         |    2 +-
 .../{twl4030-regulator.c => twl-regulator.c}       |    2 +-
 drivers/rtc/Makefile                               |    2 +-
 drivers/rtc/{rtc-twl4030.c => rtc-twl.c}           |    2 +-
 drivers/usb/otg/twl4030-usb.c                      |    2 +-
 drivers/video/omap/lcd_2430sdp.c                   |    2 +-
 drivers/watchdog/twl4030_wdt.c                     |    2 +-
 include/linux/i2c/{twl4030.h => twl.h}             |    0 
 sound/soc/codecs/twl4030.c                         |    2 +-
 22 files changed, 21 insertions(+), 21 deletions(-)
 rename drivers/mfd/{twl4030-core.c => twl-core.c} (99%)
 rename drivers/regulator/{twl4030-regulator.c => twl-regulator.c} (99%)
 rename drivers/rtc/{rtc-twl4030.c => rtc-twl.c} (99%)
 rename include/linux/i2c/{twl4030.h => twl.h} (100%)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index db9374b..e508904 100644
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
index 491364e..fd59189 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -20,7 +20,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c062238..f292c16 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -24,7 +24,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 41480bd..f32156f 100644
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
index 2db5ba5..b9e2386 100644
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
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 52dfd51..9650364 100644
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
index 49384a7..a320d7b 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -34,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 
 /*
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 9a2977c..1d1536a 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -31,7 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
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
index af0fc90..986adfc 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
-obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-irq.o
+obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o
 obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
 
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl-core.c
similarity index 99%
rename from drivers/mfd/twl4030-core.c
rename to drivers/mfd/twl-core.c
index 40449cd..b6e8202 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl-core.c
@@ -36,7 +36,7 @@
 #include <linux/regulator/machine.h>
 
 #include <linux/i2c.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #include <plat/cpu.h>
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index fb194fe..72e05c3 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -32,7 +32,7 @@
 #include <linux/irq.h>
 #include <linux/kthread.h>
 
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 
 /*
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index d423e0c..e7878b9 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -26,7 +26,7 @@
 
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 4257a86..9ae3cc4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
-obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
+obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
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
index af1ba7a..7da6efb 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -80,7 +80,7 @@ obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
 obj-$(CONFIG_RTC_DRV_STMP)	+= rtc-stmp3xxx.o
 obj-$(CONFIG_RTC_DRV_SUN4V)	+= rtc-sun4v.o
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
 
diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
index fea7fee..c5dc86d 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -25,7 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <plat/omapfb.h>
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
index 5f1681f..c3a6ceb 100644
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

