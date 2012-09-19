From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/29] ARM: OMAP1: Make plat/mux.h omap1 only
Date: Wed, 19 Sep 2012 14:05:39 -0700
Message-ID: <20120919210539.28074.33302.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42166 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967Ab2ISVFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:05:42 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pcmcia@lists.infradead.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, spi-devel-general@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>, linux-omap@vger.kernel.org

We are moving omap2+ to use the device tree based pinctrl-single.c
and will be removing the old mux framework. This will remove the
omap1 specific parts from plat-omap.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org
Cc: spi-devel-general@lists.sourceforge.net
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c         |    2 -
 arch/arm/mach-omap1/board-fsample.c           |    2 -
 arch/arm/mach-omap1/board-generic.c           |    2 -
 arch/arm/mach-omap1/board-h2.c                |    2 -
 arch/arm/mach-omap1/board-h3.c                |    2 -
 arch/arm/mach-omap1/board-innovator.c         |    2 -
 arch/arm/mach-omap1/board-nokia770.c          |    2 -
 arch/arm/mach-omap1/board-osk.c               |    2 -
 arch/arm/mach-omap1/board-palmte.c            |    2 -
 arch/arm/mach-omap1/board-palmtt.c            |    2 -
 arch/arm/mach-omap1/board-palmz71.c           |    2 -
 arch/arm/mach-omap1/board-perseus2.c          |    2 -
 arch/arm/mach-omap1/board-sx1.c               |    2 -
 arch/arm/mach-omap1/board-voiceblue.c         |    2 -
 arch/arm/mach-omap1/devices.c                 |    2 -
 arch/arm/mach-omap1/i2c.c                     |    2 -
 arch/arm/mach-omap1/include/mach/mux.h        |    0 
 arch/arm/mach-omap1/io.c                      |    2 -
 arch/arm/mach-omap1/mcbsp.c                   |    2 -
 arch/arm/mach-omap1/mux.c                     |   58 ++++++++++++++++
 arch/arm/mach-omap1/pm.c                      |    2 -
 arch/arm/mach-omap1/serial.c                  |    2 -
 arch/arm/mach-omap1/usb.c                     |    2 -
 arch/arm/mach-omap2/common.c                  |    1 
 arch/arm/mach-omap2/hsmmc.c                   |    1 
 arch/arm/plat-omap/Makefile                   |    2 -
 arch/arm/plat-omap/i2c.c                      |    1 
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 -
 arch/arm/plat-omap/mux.c                      |   90 -------------------------
 drivers/pcmcia/omap_cf.c                      |    2 -
 drivers/spi/spi-omap-uwire.c                  |    2 -
 drivers/usb/host/ohci-omap.c                  |    2 -
 drivers/usb/musb/tusb6010_omap.c              |    1 
 drivers/usb/otg/isp1301_omap.c                |    2 -
 drivers/video/backlight/omap1_bl.c            |    2 -
 drivers/video/omap/lcd_osk.c                  |    2 -
 36 files changed, 84 insertions(+), 126 deletions(-)
 rename arch/arm/{plat-omap/include/plat/mux.h => mach-omap1/include/mach/mux.h} (100%)
 delete mode 100644 arch/arm/plat-omap/mux.c

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index ab1e51f..05af063 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -37,7 +37,7 @@
 
 #include <plat/board-ams-delta.h>
 #include <plat/keypad.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #include <mach/hardware.h>
 #include <mach/ams-delta-fiq.h>
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 6d98552..4b784f2 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -28,7 +28,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/keypad.h>
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 04b5fda..4ec579f 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -22,7 +22,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #include <mach/usb.h>
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 5560a40..124db5c 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -38,7 +38,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index edc2487..a6f28a6 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -40,7 +40,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/tc.h>
 #include <plat/keypad.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index f21c296..0eb9881 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -31,7 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index ec01f03..fb3a6e9 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -25,7 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/keypad.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 2b1db05..eb108d5 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -47,7 +47,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/flash.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/tc.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 49f8d74..bd27646 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -35,7 +35,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/flash.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/tc.h>
 #include <plat/dma.h>
 #include <plat/irda.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 01523cd..8128eab 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -35,7 +35,7 @@
 
 #include <plat/led.h>
 #include <plat/flash.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index a7abce6..2367c0d 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -37,7 +37,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/flash.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 277e0bc..0d9b836 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -28,7 +28,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/fpga.h>
 #include <plat/flash.h>
 #include <plat/keypad.h>
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2e1fff2..1f43fe9 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/flash.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/irda.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 1668af3..bd7b3fc 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -33,7 +33,7 @@
 
 #include <plat/board-voiceblue.h>
 #include <plat/flash.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/tc.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 05fdbd9..0cc54dd 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -20,7 +20,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
 
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 5446c99..a0551a6 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -20,7 +20,7 @@
  */
 
 #include <plat/i2c.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/cpu.h>
 
 void __init omap1_i2c_mux_pins(int bus_id)
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/mach-omap1/include/mach/mux.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/mux.h
rename to arch/arm/mach-omap1/include/mach/mux.h
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6c95a59..6a5baab 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -16,7 +16,7 @@
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/tc.h>
 #include <plat/dma.h>
 
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index adf0097..cd77423 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 
 #include <plat/dma.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
 
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index e9cc52d..667ce50 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -29,7 +29,7 @@
 
 #include <mach/hardware.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #ifdef CONFIG_OMAP_MUX
 
@@ -451,6 +451,56 @@ static int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 #endif
 }
 
+static struct omap_mux_cfg *mux_cfg;
+
+int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
+{
+	if (!arch_mux_cfg || !arch_mux_cfg->pins || arch_mux_cfg->size == 0
+			|| !arch_mux_cfg->cfg_reg) {
+		printk(KERN_ERR "Invalid pin table\n");
+		return -EINVAL;
+	}
+
+	mux_cfg = arch_mux_cfg;
+
+	return 0;
+}
+
+/*
+ * Sets the Omap MUX and PULL_DWN registers based on the table
+ */
+int __init_or_module omap_cfg_reg(const unsigned long index)
+{
+	struct pin_config *reg;
+
+	if (!cpu_class_is_omap1()) {
+		printk(KERN_ERR "mux: Broken omap_cfg_reg(%lu) entry\n",
+				index);
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (mux_cfg == NULL) {
+		printk(KERN_ERR "Pin mux table not initialized\n");
+		return -ENODEV;
+	}
+
+	if (index >= mux_cfg->size) {
+		printk(KERN_ERR "Invalid pin mux index: %lu (%lu)\n",
+		       index, mux_cfg->size);
+		dump_stack();
+		return -ENODEV;
+	}
+
+	reg = &mux_cfg->pins[index];
+
+	if (!mux_cfg->cfg_reg)
+		return -ENODEV;
+
+	return mux_cfg->cfg_reg(reg);
+}
+EXPORT_SYMBOL(omap_cfg_reg);
+
 int __init omap1_mux_init(void)
 {
 	if (cpu_is_omap7xx()) {
@@ -468,4 +518,8 @@ int __init omap1_mux_init(void)
 	return omap_mux_register(&arch_mux_cfg);
 }
 
-#endif
+#else
+#define omap_mux_init() do {} while(0)
+#define omap_cfg_reg(x)	do {} while(0)
+#endif	/* CONFIG_OMAP_MUX */
+
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index b2560d3..47ec161 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -53,7 +53,7 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/tc.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 0d1709b..b9d6834 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -22,7 +22,7 @@
 
 #include <asm/mach-types.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/fpga.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 65f8817..84267ed 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -26,7 +26,7 @@
 
 #include <asm/irq.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #include <mach/usb.h>
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 8e43c4d8..17950c6 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/mux.h>
 #include <plat/clock.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 80399d7..03ebf47 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -19,7 +19,6 @@
 
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
-#include <plat/mux.h>
 #include <plat/omap_device.h>
 
 #include "mux.h"
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a017e99..dacaee0 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := common.o sram.o clock.o dma.o mux.o fb.o counter_32k.o
+obj-y := common.o sram.o clock.o dma.o fb.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 40bc06a..6013831 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -32,7 +32,6 @@
 #include <linux/clk.h>
 
 #include <mach/irqs.h>
-#include <plat/mux.h>
 #include <plat/i2c.h>
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index a5311498..b2eac60 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -21,8 +21,6 @@
 #include <linux/device.h>
 #include <linux/pm_qos.h>
 
-#include <plat/mux.h>
-
 #define DRIVER_NAME	"omap_uart"
 
 /*
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
deleted file mode 100644
index fd0d3aa..0000000
--- a/arch/arm/plat-omap/mux.c
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/mux.c
- *
- * Utility to set the Omap MUX and PULL_DWN registers from a table in mux.h
- *
- * Copyright (C) 2003 - 2008 Nokia Corporation
- *
- * Written by Tony Lindgren
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#include <asm/system.h>
-
-#include <plat/cpu.h>
-#include <plat/mux.h>
-
-#ifdef CONFIG_OMAP_MUX
-
-static struct omap_mux_cfg *mux_cfg;
-
-int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
-{
-	if (!arch_mux_cfg || !arch_mux_cfg->pins || arch_mux_cfg->size == 0
-			|| !arch_mux_cfg->cfg_reg) {
-		printk(KERN_ERR "Invalid pin table\n");
-		return -EINVAL;
-	}
-
-	mux_cfg = arch_mux_cfg;
-
-	return 0;
-}
-
-/*
- * Sets the Omap MUX and PULL_DWN registers based on the table
- */
-int __init_or_module omap_cfg_reg(const unsigned long index)
-{
-	struct pin_config *reg;
-
-	if (!cpu_class_is_omap1()) {
-		printk(KERN_ERR "mux: Broken omap_cfg_reg(%lu) entry\n",
-				index);
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
-	if (mux_cfg == NULL) {
-		printk(KERN_ERR "Pin mux table not initialized\n");
-		return -ENODEV;
-	}
-
-	if (index >= mux_cfg->size) {
-		printk(KERN_ERR "Invalid pin mux index: %lu (%lu)\n",
-		       index, mux_cfg->size);
-		dump_stack();
-		return -ENODEV;
-	}
-
-	reg = &mux_cfg->pins[index];
-
-	if (!mux_cfg->cfg_reg)
-		return -ENODEV;
-
-	return mux_cfg->cfg_reg(reg);
-}
-EXPORT_SYMBOL(omap_cfg_reg);
-#else
-#define omap_mux_init() do {} while(0)
-#define omap_cfg_reg(x)	do {} while(0)
-#endif	/* CONFIG_OMAP_MUX */
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 0ad06a3..fa74efe 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/tc.h>
 
 
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index a3996a1..0a94d9d 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -52,7 +52,7 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #include <mach/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
 
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f8b2d91..4531d03 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include <plat/fpga.h>
 
 #include <mach/hardware.h>
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 53e2596..7a62b95 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -17,7 +17,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <plat/dma.h>
-#include <plat/mux.h>
 
 #include "musb_core.h"
 #include "tusb6010.h"
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index 720df35..ceee211 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -36,7 +36,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #include <mach/usb.h>
 
diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index 92257ef..9a046a4 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -30,7 +30,7 @@
 #include <linux/platform_data/omap1_bl.h>
 
 #include <mach/hardware.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 
 #define OMAPBL_MAX_INTENSITY		0xff
 
diff --git a/drivers/video/omap/lcd_osk.c b/drivers/video/omap/lcd_osk.c
index 5914220..3aa62da 100644
--- a/drivers/video/omap/lcd_osk.c
+++ b/drivers/video/omap/lcd_osk.c
@@ -24,7 +24,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/gpio.h>
-#include <plat/mux.h>
+#include <mach/mux.h>
 #include "omapfb.h"
 
 static int osk_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)

