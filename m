From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [12/17 PATCH] MMC: OMAP: Supporting MMC multislot structures for
 TI OMAP H3 board.
Date: Fri, 17 Aug 2007 15:02:16 -0400
Message-ID: <46C5F0B8.60400@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090604070700040906000301"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604070700040906000301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Felipe Balbi <felipe.lima@indt.org.br>

Proposes the new board-h3-mmc.c file to handle all the mmc specific code
for multislot support.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

--------------090604070700040906000301
Content-Type: text/plain;
	name*0="0012-MMC-OMAP-Supporting-MMC-multislot-structures-for-TI-OMAP-H3";
	name*1="-board.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0012-MMC-OMAP-Supporting-MMC-multislot-structures-for-TI-OMA";
	filename*1="P-H3-board.diff"

Proposes the new board-h3-mmc.c file to handle all the mmc
specific code for multislot support.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Index: linux-omap/arch/arm/mach-omap1/board-h3-mmc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap1/board-h3-mmc.c	2007-08-14 15:50:05.000000000 -0400
@@ -0,0 +1,115 @@
+/*
+ * linux/arch/arm/mach-omap1/board-h3-mmc.c
+ *
+ * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
+ * Author: Felipe Balbi <felipe.lima@indt.org.br>
+ *
+ * This code is based on linux/arch/arm/mach-omap2/board-n800-mmc.c, which is:
+ * Copyright (C) 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/arch/mmc.h>
+#include <asm/arch/gpio.h>
+
+#ifdef CONFIG_MMC_OMAP
+static int slot_cover_open;
+static struct device *mmc_device;
+
+static int h3_mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot +1,
+		power_on ? "on" : "off", vdd);
+#endif
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int h3_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
+{
+	int ret = 0;
+
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
+		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
+#endif
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	/* Treated on upper level */
+
+	return bus_mode;
+}
+
+static int h3_mmc_get_cover_state(struct device *dev, int slot)
+{
+	BUG_ON(slot != 0);
+
+	return slot_cover_open;
+}
+
+void h3_mmc_slot_cover_handler(void *arg, int state)
+{
+	if (mmc_device == NULL)
+		return;
+
+	slot_cover_open = state;
+	omap_mmc_notify_cover_event(mmc_device, 0, state);
+}
+
+static int h3_mmc_late_init(struct device *dev)
+{
+	int ret = 0;
+
+	mmc_device = dev;
+
+	return ret;
+}
+
+static void h3_mmc_cleanup(struct device *dev)
+{
+}
+
+static struct omap_mmc_platform_data h3_mmc_data = {
+	.enabled			= 1,
+	.nr_slots                       = 1,
+	.wire4                          = 1,
+	.switch_slot                    = NULL,
+	.init                           = h3_mmc_late_init,
+	.cleanup                        = h3_mmc_cleanup,
+	.slots[0]       = {
+		.set_power              = h3_mmc_set_power,
+		.set_bus_mode           = h3_mmc_set_bus_mode,
+		.get_ro                 = NULL,
+		.get_cover_state        = h3_mmc_get_cover_state,
+		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name                   = "mmcblk",
+	},
+};
+
+void __init h3_mmc_init(void)
+{
+	omap_set_mmc_info(1, &h3_mmc_data);
+}
+
+#else
+
+void __init h3_mmc_init(void)
+{
+}
+
+void h3_mmc_slot_cover_handler(void *arg, int state)
+{
+}
+#endif
Index: linux-omap/include/asm-arm/arch-omap/board-h3.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/board-h3.h	2007-08-14 12:09:02.000000000 -0400
+++ linux-omap/include/asm-arm/arch-omap/board-h3.h	2007-08-14 12:10:08.000000000 -0400
@@ -36,5 +36,7 @@
 
 #define NR_IRQS				(MAXIRQNUM + 1)
 
+extern void h3_mmc_init(void);
+extern void h3_mmc_slot_cover_handler(void *arg, int state);
 
 #endif /*  __ASM_ARCH_OMAP_H3_H */

--------------090604070700040906000301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090604070700040906000301--
