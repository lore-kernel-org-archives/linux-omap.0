From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 13/17] MMC: OMAP: Supporting MMC multislot structures for
 TI OMAP H2 board
Date: Mon, 26 Nov 2007 12:01:54 -0400
Message-ID: <474AEDF2.7070507@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.lima@indt.org.br>

Proposes the new board-h2-mmc.c file to handle all the mmc
specific code for multislot support.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/board-h2-mmc.c   |  110 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-h2.c       |    2 +
 include/asm-arm/arch-omap/board-h2.h |    2 +
 3 files changed, 114 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-h2-mmc.c

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
new file mode 100644
index 0000000..6fdc784
--- /dev/null
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -0,0 +1,110 @@
+/*
+ * linux/arch/arm/mach-omap1/board-h2-mmc.c
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
+static int h2_mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
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
+static int h2_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
+{
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
+		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
+#endif
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int h2_mmc_get_cover_state(struct device *dev, int slot)
+{
+	BUG_ON(slot != 0);
+
+	return slot_cover_open;
+}
+
+void h2_mmc_slot_cover_handler(void *arg, int state)
+{
+	if (mmc_device == NULL)
+		return;
+
+	slot_cover_open = state;
+	omap_mmc_notify_cover_event(mmc_device, 0, state);
+}
+
+static int h2_mmc_late_init(struct device *dev)
+{
+	int ret = 0;
+
+	mmc_device = dev;
+
+	return ret;
+}
+
+static void h2_mmc_cleanup(struct device *dev)
+{
+}
+
+static struct omap_mmc_platform_data h2_mmc_data = {
+	.nr_slots                       = 1,
+	.switch_slot                    = NULL,
+	.init                           = h2_mmc_late_init,
+	.cleanup                        = h2_mmc_cleanup,
+	.slots[0]       = {
+		.set_power              = h2_mmc_set_power,
+		.set_bus_mode           = h2_mmc_set_bus_mode,
+		.get_ro                 = NULL,
+		.get_cover_state        = h2_mmc_get_cover_state,
+		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
+					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name                   = "mmcblk",
+	},
+};
+
+void __init h2_mmc_init(void)
+{
+	omap_set_mmc_info(1, &h2_mmc_data);
+}
+
+#else
+
+void __init h2_mmc_init(void)
+{
+}
+
+void h2_mmc_slot_cover_handler(void *arg, int state)
+{
+}
+#endif
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 722c5a4..d7345c9 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -489,6 +489,8 @@ static int h2_nand_dev_ready(struct nand_platform_data *data)
 	return omap_get_gpio_datain(H2_NAND_RB_GPIO_PIN);
 }
 
+extern void __init h2_mmc_init(void);
+
 static void __init h2_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
diff --git a/include/asm-arm/arch-omap/board-h2.h b/include/asm-arm/arch-omap/board-h2.h
index b2888ef..88ae403 100644
--- a/include/asm-arm/arch-omap/board-h2.h
+++ b/include/asm-arm/arch-omap/board-h2.h
@@ -34,5 +34,7 @@
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define OMAP1610_ETHR_START		0x04000300
 
+extern void h2_mmc_slot_cover_handler(void *arg, int state);
+
 #endif /*  __ASM_ARCH_OMAP_H2_H */
 
-- 1.5.3.GIT
