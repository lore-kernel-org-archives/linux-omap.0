From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Adds MMC multislot for apollon
Date: Mon, 3 Dec 2007 08:47:50 +0900
Message-ID: <20071202234750.GA13107@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Adds MMC support for apollon using the MMC multislot support code.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2195991..d4d6d98 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 obj-$(CONFIG_MACH_OMAP_2430OSK)		+= board-2430osk.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
+					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-mmc.o board-n800-bt.o \
diff --git a/arch/arm/mach-omap2/board-apollon-mmc.c b/arch/arm/mach-omap2/board-apollon-mmc.c
new file mode 100644
index 0000000..f77167e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-apollon-mmc.c
@@ -0,0 +1,88 @@
+/*
+ * linux/arch/arm/mach-omap2/board-apollon-mmc.c
+ *
+ * Copyright (C) 2005-2007 Samsung Electronics
+ * Author: Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/mmc.h>
+
+#ifdef CONFIG_MMC_OMAP
+
+static struct device *mmc_device;
+
+static int apollon_mmc_set_power(struct device *dev, int slot, int power_on,
+					int vdd)
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
+static int apollon_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
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
+static int apollon_mmc_late_init(struct device *dev)
+{
+	mmc_device = dev;
+
+	return 0;
+}
+
+static void apollon_mmc_cleanup(struct device *dev)
+{
+}
+
+static struct omap_mmc_platform_data apollon_mmc_data = {
+	.nr_slots			= 1,
+	.switch_slot			= NULL,
+	.init				= apollon_mmc_late_init,
+	.cleanup			= apollon_mmc_cleanup,
+	.slots[0]	= {
+		.set_power		= apollon_mmc_set_power,
+		.set_bus_mode		= apollon_mmc_set_bus_mode,
+		.get_ro			= NULL,
+		.get_cover_state	= NULL,
+		.ocr_mask		= MMC_VDD_30_31 | MMC_VDD_31_32 |
+					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name			= "mmcblk",
+	},
+};
+
+void __init apollon_mmc_init(void)
+{
+	omap_set_mmc_info(1, &apollon_mmc_data);
+}
+
+#else	/* !CONFIG_MMC_OMAP */
+
+void __init apollon_mmc_init(void)
+{
+}
+
+#endif	/* CONFIG_MMC_OMAP */
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 9cff027..d815635 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -283,16 +283,15 @@ static struct omap_uart_config apollon_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
 };
 
+/*
+ * Note: If you want to detect card feature, please assign GPIO 37
+ */
 static struct omap_mmc_config apollon_mmc_config __initdata = {
 	.mmc [0] = {
 		.enabled 	= 1,
 		.wire4		= 1,
 	/* Use internal loop-back in MMC/SDIO Module Input Clock selection */
 		.internal_clock	= 1,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-	/* Note: If you want to detect card feature, please assign 37 */
-		.switch_pin	= -1,
 	},
 };
 
@@ -386,6 +385,8 @@ static void __init omap_apollon_init(void)
 
 	spi_register_board_info(apollon_spi_board_info,
 				ARRAY_SIZE(apollon_spi_board_info));
+
+	apollon_mmc_init();
 }
 
 static void __init omap_apollon_map_io(void)
diff --git a/include/asm-arm/arch-omap/board-apollon.h b/include/asm-arm/arch-omap/board-apollon.h
index dcb587b..547125a 100644
--- a/include/asm-arm/arch-omap/board-apollon.h
+++ b/include/asm-arm/arch-omap/board-apollon.h
@@ -29,6 +29,8 @@
 #ifndef __ASM_ARCH_OMAP_APOLLON_H
 #define __ASM_ARCH_OMAP_APOLLON_H
 
+extern void apollon_mmc_init(void);
+
 /* Placeholder for APOLLON specific defines */
 #define APOLLON_ETHR_GPIO_IRQ		74
 
