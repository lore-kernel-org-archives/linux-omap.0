From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/16] ARM: OMAP: Make plat/omap_hwmod.h local to mach-omap2
Date: Thu, 04 Oct 2012 15:04:59 -0700
Message-ID: <20121004220458.26676.36446.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28192 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753341Ab2JDWFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:05:00 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Let's make omap_hwmod local to mach-omap2 for
ARM common zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomain.h                  |    2 +-
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/display.c                      |    2 +-
 arch/arm/mach-omap2/dma.c                          |    2 +-
 arch/arm/mach-omap2/drm.c                          |    2 +-
 arch/arm/mach-omap2/gpio.c                         |    2 +-
 arch/arm/mach-omap2/hdq1w.c                        |    2 +-
 arch/arm/mach-omap2/hdq1w.h                        |    2 +-
 arch/arm/mach-omap2/hwspinlock.c                   |    2 +-
 arch/arm/mach-omap2/i2c.c                          |    2 +-
 arch/arm/mach-omap2/io.c                           |    2 +-
 arch/arm/mach-omap2/msdi.c                         |    2 +-
 arch/arm/mach-omap2/mux.c                          |    2 +-
 arch/arm/mach-omap2/omap_device.c                  |    2 +-
 arch/arm/mach-omap2/omap_device.h                  |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |    0 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +-
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |    2 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    2 +-
 arch/arm/mach-omap2/omap_opp_data.h                |    2 +-
 arch/arm/mach-omap2/pmu.c                          |    2 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 arch/arm/mach-omap2/timer.c                        |    2 +-
 arch/arm/mach-omap2/wd_timer.c                     |    2 +-
 arch/arm/mach-omap2/wd_timer.h                     |    2 +-
 34 files changed, 33 insertions(+), 33 deletions(-)
 rename arch/arm/{plat-omap/include/plat/omap_hwmod.h => mach-omap2/omap_hwmod.h} (100%)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 629576b..a868c02 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -19,7 +19,7 @@
 
 #include "powerdomain.h"
 #include <plat/clock.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/cpu.h>
 
 /*
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2fb4bd1..11a200e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,7 +25,7 @@
 
 #include "iomap.h"
 #include <plat/dma.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include "omap4-keypad.h"
 
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 15e84c4..261f79f 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -25,7 +25,7 @@
 #include <linux/delay.h>
 
 #include <video/omapdss.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/omap-pm.h>
 #include "common.h"
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index cc7d918..279a734 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -28,7 +28,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/dma.h>
 
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 67991ea..6282cc8 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -25,7 +25,7 @@
 #include <linux/dma-mapping.h>
 
 #include "omap_device.h"
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
 
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 2bd2467..80b1e1a 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -23,7 +23,7 @@
 #include <linux/of.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/omap-pm.h>
 
diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index a533ce3..3da8900 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -27,7 +27,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include "hdq1w.h"
 
diff --git a/arch/arm/mach-omap2/hdq1w.h b/arch/arm/mach-omap2/hdq1w.h
index 0c1efc8..c7e08d2 100644
--- a/arch/arm/mach-omap2/hdq1w.h
+++ b/arch/arm/mach-omap2/hdq1w.h
@@ -21,7 +21,7 @@
 #ifndef ARCH_ARM_MACH_OMAP2_HDQ1W_H
 #define ARCH_ARM_MACH_OMAP2_HDQ1W_H
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 /*
  * XXX A future cleanup patch should modify
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 5856521..1df9b5f 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -21,7 +21,7 @@
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 
 static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 03bdb0c..5904a7a 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -22,7 +22,7 @@
 #include <linux/i2c-omap.h>
 
 #include "common.h"
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/omap-pm.h>
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e389919..1e81d54 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -28,7 +28,7 @@
 #include <plat/sdrc.h>
 #include <plat/serial.h>
 #include <plat/omap-pm.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/multi.h>
 #include <plat/dma.h>
 
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 133cdc2..86ce761 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -25,7 +25,7 @@
 #include <linux/err.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include "mmc.h"
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 9fe6829..6dd62f8 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -36,7 +36,7 @@
 #include <linux/interrupt.h>
 
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 #include "control.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 30b631f..5124664 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -90,7 +90,7 @@
 #include <linux/notifier.h>
 
 #include "omap_device.h"
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/clock.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index 106f506..0933c59 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -34,7 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 extern struct dev_pm_domain omap_device_pm_domain;
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 299ca28..7f47378 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -140,7 +140,7 @@
 #include <linux/bootmem.h>
 
 #include <plat/clock.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/prcm.h>
 
 #include "soc.h"
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/omap_hwmod.h
rename to arch/arm/mach-omap2/omap_hwmod.h
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b913ddf..3ed44b2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -16,7 +16,7 @@
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index bcda2fa5..6d997c0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -17,7 +17,7 @@
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
index cbb4ef6..b490087 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
@@ -13,7 +13,7 @@
  */
 #include <asm/sizes.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/serial.h>
 
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 62ae397..c0390c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -9,7 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/serial.h>
 #include <plat/dma.h>
 #include "../plat-omap/common.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 1a1287d..f54714a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -13,7 +13,7 @@
  */
 #include <asm/sizes.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/serial.h>
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 35dcdb6..7e1bc57 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/serial.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 76449f9..fa54767 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -16,7 +16,7 @@
 
 #include <linux/i2c-omap.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/cpu.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index d8aa3c1..ac0290d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -19,7 +19,7 @@
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include "l3_3xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8364cc9..52c133e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -23,7 +23,7 @@
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include <plat/dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 9f1ccdc..79d623b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -16,7 +16,7 @@
  * data and their integration with other OMAP modules and Linux.
  */
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 2bc8f17..cfcce299 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -13,7 +13,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_OMAP_HWMOD_COMMON_DATA_H
 #define __ARCH_ARM_MACH_OMAP2_OMAP_HWMOD_COMMON_DATA_H
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 #include "common.h"
 #include "display.h"
diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..7e437bf 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -19,7 +19,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H
 #define __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 #include "voltage.h"
 
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 4b3230f..98c5969 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -15,7 +15,7 @@
 
 #include <asm/pmu.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 
 static char *omap2_pmu_oh_names[] = {"mpu"};
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6559c48..e07772a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -30,7 +30,7 @@
 #include <plat/omap-serial.h>
 #include "common.h"
 #include <plat/dma.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/omap-pm.h>
 #include <plat/serial.h>
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 0460130..b888051 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -43,7 +43,7 @@
 #include <asm/sched_clock.h>
 
 #include <asm/arch_timer.h>
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index b2f1c67..f6b6c37 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 #include "wd_timer.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/wd_timer.h b/arch/arm/mach-omap2/wd_timer.h
index f6bbba7..a78f810 100644
--- a/arch/arm/mach-omap2/wd_timer.h
+++ b/arch/arm/mach-omap2/wd_timer.h
@@ -10,7 +10,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_WD_TIMER_H
 #define __ARCH_ARM_MACH_OMAP2_WD_TIMER_H
 
-#include <plat/omap_hwmod.h>
+#include "omap_hwmod.h"
 
 extern int omap2_wd_timer_disable(struct omap_hwmod *oh);
 extern int omap2_wd_timer_reset(struct omap_hwmod *oh);

