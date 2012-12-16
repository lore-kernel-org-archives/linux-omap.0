From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP: Split vrfb.c to remove last remaining
 cpu_is_omap usage
Date: Sun, 16 Dec 2012 12:03:14 -0800
Message-ID: <20121216200314.24238.9481.stgit@muffinssi.local>
References: <20121216200236.24238.38151.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37643 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569Ab2LPUDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Dec 2012 15:03:17 -0500
In-Reply-To: <20121216200236.24238.38151.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

Looks like we missed plat-omap/fb.c for cpu_is_omap usage
mach-omap2. This is the last user of cpu_is_omap, so let's
quickly fix it up so we can finally remove plat/cpu.h for
omap2lus.

We want to limit cpu_is_omap macro usage to mach-omap2 only so
we can make plat/cpu.h private. After this we can finally drop
plat/cpu.h for omap2+.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Makefile |    2 +
 arch/arm/mach-omap1/fb.c     |   80 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile |    2 +
 arch/arm/mach-omap2/fb.c     |   50 +-------------------------
 arch/arm/plat-omap/Makefile  |    2 +
 5 files changed, 85 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/mach-omap1/fb.c
 rename arch/arm/{plat-omap/fb.c => mach-omap2/fb.c} (76%)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index f0e69cb..222d58c 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := io.o id.o sram-init.o sram.o time.o irq.o mux.o flash.o \
-	 serial.o devices.o dma.o
+	 serial.o devices.o dma.o fb.o
 obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
diff --git a/arch/arm/mach-omap1/fb.c b/arch/arm/mach-omap1/fb.c
new file mode 100644
index 0000000..c770d45
--- /dev/null
+++ b/arch/arm/mach-omap1/fb.c
@@ -0,0 +1,80 @@
+/*
+ * File: arch/arm/plat-omap/fb.c
+ *
+ * Framebuffer device registration for TI OMAP platforms
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Imre Deak <imre.deak@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/memblock.h>
+#include <linux/io.h>
+#include <linux/omapfb.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/mach/map.h>
+
+#if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
+
+static bool omapfb_lcd_configured;
+static struct omapfb_platform_data omapfb_config;
+
+static u64 omap_fb_dma_mask = ~(u32)0;
+
+static struct platform_device omap_fb_device = {
+	.name		= "omapfb",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &omap_fb_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &omapfb_config,
+	},
+	.num_resources = 0,
+};
+
+void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
+{
+	omapfb_config.lcd = *config;
+	omapfb_lcd_configured = true;
+}
+
+static int __init omap_init_fb(void)
+{
+	/*
+	 * If the board file has not set the lcd config with
+	 * omapfb_set_lcd_config(), don't bother registering the omapfb device
+	 */
+	if (!omapfb_lcd_configured)
+		return 0;
+
+	return platform_device_register(&omap_fb_device);
+}
+
+arch_initcall(omap_init_fb);
+
+#else
+
+void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a8004f3..947cafe 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
+obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o
 
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/mach-omap2/fb.c
similarity index 76%
rename from arch/arm/plat-omap/fb.c
rename to arch/arm/mach-omap2/fb.c
index a3367b7..d9bd965 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -1,6 +1,4 @@
 /*
- * File: arch/arm/plat-omap/fb.c
- *
  * Framebuffer device registration for TI OMAP platforms
  *
  * Copyright (C) 2006 Nokia Corporation
@@ -33,7 +31,7 @@
 
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
+#include "soc.h"
 
 #ifdef CONFIG_OMAP2_VRFB
 
@@ -94,45 +92,7 @@ static int __init omap_init_vrfb(void)
 arch_initcall(omap_init_vrfb);
 #endif
 
-#if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
-
-static bool omapfb_lcd_configured;
-static struct omapfb_platform_data omapfb_config;
-
-static u64 omap_fb_dma_mask = ~(u32)0;
-
-static struct platform_device omap_fb_device = {
-	.name		= "omapfb",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &omap_fb_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &omapfb_config,
-	},
-	.num_resources = 0,
-};
-
-void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
-{
-	omapfb_config.lcd = *config;
-	omapfb_lcd_configured = true;
-}
-
-static int __init omap_init_fb(void)
-{
-	/*
-	 * If the board file has not set the lcd config with
-	 * omapfb_set_lcd_config(), don't bother registering the omapfb device
-	 */
-	if (!omapfb_lcd_configured)
-		return 0;
-
-	return platform_device_register(&omap_fb_device);
-}
-
-arch_initcall(omap_init_fb);
-
-#elif defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
 
 static u64 omap_fb_dma_mask = ~(u32)0;
 static struct omapfb_platform_data omapfb_config;
@@ -155,10 +115,4 @@ static int __init omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
-#else
-
-void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
-{
-}
-
 #endif
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 9d9aa2f..a14a78a 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := sram.o dma.o fb.o counter_32k.o
+obj-y := sram.o dma.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=

