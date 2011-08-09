From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 03/13] ARM: gpio: omap: convert drivers to use asm/gpio.h
 rather than mach/gpio.h
Date: Tue, 09 Aug 2011 09:05:20 +0100
Message-ID: <E1QqhJQ-0003a8-T9@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>Grant Likely <grant.likely@secretlab.ca>Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpio/gpio-omap.c             |    2 +-
 drivers/input/keyboard/omap-keypad.c |    2 +-
 drivers/mfd/menelaus.c               |    2 +-
 drivers/mmc/host/omap.c              |    2 +-
 drivers/mtd/nand/ams-delta.c         |    2 +-
 drivers/mtd/onenand/omap2.c          |    2 +-
 drivers/video/omap/lcd_apollon.c     |    2 +-
 drivers/video/omap/lcd_h3.c          |    2 +-
 drivers/video/omap/lcd_inn1610.c     |    2 +-
 drivers/video/omap/lcd_ldp.c         |    2 +-
 drivers/video/omap/lcd_osk.c         |    2 +-
 drivers/video/omap/lcd_overo.c       |    2 +-
 drivers/video/omap/lcd_palmtt.c      |    2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0599854..9c27244 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -25,7 +25,7 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <asm/mach/irq.h>
 
 struct gpio_bank {
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 33d0bdc..323bcdf 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -35,7 +35,7 @@
 #include <linux/mutex.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/keypad.h>
 #include <plat/menelaus.h>
 #include <asm/irq.h>
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 9cee8e7..af5d9d0 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -44,7 +44,7 @@
 
 #include <asm/mach/irq.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/menelaus.h>
 
 #define DRIVER_NAME			"menelaus"
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index a6c3290..2dba999 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -33,7 +33,7 @@
 
 #include <plat/board.h>
 #include <plat/mmc.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/dma.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 78017eb..9e6b498 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -26,7 +26,7 @@
 #include <asm/io.h>
 #include <mach/hardware.h>
 #include <asm/sizes.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/board-ams-delta.h>
 
 /*
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index a916dec..6a1d6d9 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -40,7 +40,7 @@
 #include <asm/mach/flash.h>
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 #include <plat/dma.h>
 
diff --git a/drivers/video/omap/lcd_apollon.c b/drivers/video/omap/lcd_apollon.c
index 10459d8..4b24f54 100644
--- a/drivers/video/omap/lcd_apollon.c
+++ b/drivers/video/omap/lcd_apollon.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 #include "omapfb.h"
 
diff --git a/drivers/video/omap/lcd_h3.c b/drivers/video/omap/lcd_h3.c
index 8df6887..622ad83 100644
--- a/drivers/video/omap/lcd_h3.c
+++ b/drivers/video/omap/lcd_h3.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c/tps65010.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include "omapfb.h"
 
 #define MODULE_NAME	"omapfb-lcd_h3"
diff --git a/drivers/video/omap/lcd_inn1610.c b/drivers/video/omap/lcd_inn1610.c
index 9fff86f..12cc52a 100644
--- a/drivers/video/omap/lcd_inn1610.c
+++ b/drivers/video/omap/lcd_inn1610.c
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include "omapfb.h"
 
 #define MODULE_NAME	"omapfb-lcd_h3"
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
index 0f5952c..0624664 100644
--- a/drivers/video/omap/lcd_ldp.c
+++ b/drivers/video/omap/lcd_ldp.c
@@ -26,7 +26,7 @@
 #include <linux/delay.h>
 #include <linux/i2c/twl.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/mux.h>
 #include <asm/mach-types.h>
 
diff --git a/drivers/video/omap/lcd_osk.c b/drivers/video/omap/lcd_osk.c
index b87e8b8..6f8d13c 100644
--- a/drivers/video/omap/lcd_osk.c
+++ b/drivers/video/omap/lcd_osk.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/mux.h>
 #include "omapfb.h"
 
diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
index 564933f..b8fd5b2 100644
--- a/drivers/video/omap/lcd_overo.c
+++ b/drivers/video/omap/lcd_overo.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c/twl.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <plat/mux.h>
 #include <asm/mach-types.h>
 
diff --git a/drivers/video/omap/lcd_palmtt.c b/drivers/video/omap/lcd_palmtt.c
index ff0e6d7..b51b332 100644
--- a/drivers/video/omap/lcd_palmtt.c
+++ b/drivers/video/omap/lcd_palmtt.c
@@ -29,7 +29,7 @@ GPIO13 - screen blanking
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include "omapfb.h"
 
 static int palmtt_panel_init(struct lcd_panel *panel,
-- 
1.7.4.4
