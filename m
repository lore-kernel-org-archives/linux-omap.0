From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/16] ARM: OMAP: Make omap_device local to mach-omap2
Date: Thu, 04 Oct 2012 15:04:56 -0700
Message-ID: <20121004220456.26676.31050.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28151 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753341Ab2JDWE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:58 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Let's make omap_device local to mach-omap2 for
ARM common zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/pm_bus.c                  |    1 -
 arch/arm/mach-omap2/Makefile                  |    3 ++-
 arch/arm/mach-omap2/am35xx-emac.c             |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
 arch/arm/mach-omap2/devices.c                 |    2 +-
 arch/arm/mach-omap2/display.c                 |    2 +-
 arch/arm/mach-omap2/dma.c                     |    2 +-
 arch/arm/mach-omap2/drm.c                     |    2 +-
 arch/arm/mach-omap2/gpio.c                    |    2 +-
 arch/arm/mach-omap2/gpmc.c                    |    2 +-
 arch/arm/mach-omap2/hdq1w.c                   |    2 +-
 arch/arm/mach-omap2/hsmmc.c                   |    2 +-
 arch/arm/mach-omap2/hwspinlock.c              |    2 +-
 arch/arm/mach-omap2/i2c.c                     |    2 +-
 arch/arm/mach-omap2/mcbsp.c                   |    2 +-
 arch/arm/mach-omap2/msdi.c                    |    2 +-
 arch/arm/mach-omap2/omap_device.c             |    2 +-
 arch/arm/mach-omap2/omap_device.h             |    0 
 arch/arm/mach-omap2/opp.c                     |    2 +-
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/pmu.c                     |    2 +-
 arch/arm/mach-omap2/serial.c                  |    2 +-
 arch/arm/mach-omap2/sr_device.c               |    2 +-
 arch/arm/mach-omap2/timer.c                   |    2 +-
 arch/arm/mach-omap2/usb-host.c                |    2 +-
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/plat-omap/Makefile                   |    1 -
 arch/arm/plat-omap/omap-pm-noop.c             |    3 ++-
 28 files changed, 27 insertions(+), 27 deletions(-)
 rename arch/arm/{plat-omap/omap_device.c => mach-omap2/omap_device.c} (99%)
 rename arch/arm/{plat-omap/include/plat/omap_device.h => mach-omap2/omap_device.h} (100%)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 7868e75..8a74ec5 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -19,7 +19,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <plat/omap_device.h>
 #include <plat/omap-pm.h>
 
 #ifdef CONFIG_PM_RUNTIME
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fe40d9e..46d9071 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,8 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
+	 omap_device.o
 
 # INTCPS IP block support - XXX should be moved to drivers/
 obj-$(CONFIG_ARCH_OMAP2)		+= irq.o
diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index d0c54c5..af11dcd 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/davinci_emac.h>
 #include <asm/system.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include "am35xx.h"
 #include "control.h"
 #include "am35xx-emac.h"
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a08bebc..521244d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -44,7 +44,7 @@
 #include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/usb.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c8c2117..2fb4bd1 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -26,7 +26,7 @@
 #include "iomap.h"
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include "omap4-keypad.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 45b5238..15e84c4 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -26,7 +26,7 @@
 
 #include <video/omapdss.h>
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/omap-pm.h>
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index ff75abe..cc7d918 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -29,7 +29,7 @@
 #include <linux/device.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/dma.h>
 
 #define OMAP2_DMA_STRIDE	0x60
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 72e0f01b..67991ea 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -24,7 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/omap_hwmod.h>
 
 #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index d1058f1..2bd2467 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -24,7 +24,7 @@
 #include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/omap-pm.h>
 
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8ab1e1b..a63ebc7 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -32,7 +32,7 @@
 #include <plat/cpu.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index e003f2b..a533ce3 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -28,7 +28,7 @@
 #include <linux/platform_device.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include "hdq1w.h"
 
 #include "common.h"
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index dd8e694..b0b11be 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -19,7 +19,7 @@
 
 #include "mmc.h"
 #include <plat/omap-pm.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 8763c85..5856521 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -22,7 +22,7 @@
 #include <linux/hwspinlock.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
 	.base_id = 0,
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index b15416c..03bdb0c 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -23,7 +23,7 @@
 
 #include "common.h"
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/omap-pm.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 37f8f94..9b3a8b8 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -21,7 +21,7 @@
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include <plat/dma.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <linux/pm_runtime.h>
 
 /*
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 4c80334..133cdc2 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -26,7 +26,7 @@
 #include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include "mmc.h"
 
 #include "common.h"
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/mach-omap2/omap_device.c
similarity index 99%
rename from arch/arm/plat-omap/omap_device.c
rename to arch/arm/mach-omap2/omap_device.c
index cee85a5..30b631f 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -89,7 +89,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/omap_hwmod.h>
 #include <plat/clock.h>
 
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/mach-omap2/omap_device.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/omap_device.h
rename to arch/arm/mach-omap2/omap_device.h
diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 45ad7f7..b023c8a 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/opp.h>
 
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "omap_opp_data.h"
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index abefbc4..bb01ac6 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -20,7 +20,7 @@
 #include <asm/system_misc.h>
 
 #include <plat/omap-pm.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include "common.h"
 
 #include "prcm-common.h"
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 2a79176..4b3230f 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -16,7 +16,7 @@
 #include <asm/pmu.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 static char *omap2_pmu_oh_names[] = {"mpu"};
 static char *omap3_pmu_oh_names[] = {"mpu", "debugss"};
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0405c81..6559c48 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -31,7 +31,7 @@
 #include "common.h"
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/omap-pm.h>
 #include <plat/serial.h>
 
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index cbeae56..692b4eb 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "voltage.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 8847d6e..0460130 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -44,7 +44,7 @@
 
 #include <asm/arch_timer.h>
 #include <plat/omap_hwmod.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 #include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
 
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 3c43449..84d8228 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -26,7 +26,7 @@
 #include <asm/io.h>
 
 #include <plat/usb.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 51da21c..24f300a 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -26,7 +26,7 @@
 #include <linux/usb/musb.h>
 
 #include <plat/usb.h>
-#include <plat/omap_device.h>
+#include "omap_device.h"
 
 #include "am35xx.h"
 
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index dacaee0..9c81cf5 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -9,7 +9,6 @@ obj-n :=
 obj-  :=
 
 # omap_device support (OMAP2+ only at the moment)
-obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 9f64133..c498dd2 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -24,7 +24,8 @@
 
 /* Interface documentation is in mach/omap-pm.h */
 #include <plat/omap-pm.h>
-#include <plat/omap_device.h>
+
+#include "../mach-omap2/omap_device.h"
 
 static bool off_mode_enabled;
 static int dummy_context_loss_counter;

