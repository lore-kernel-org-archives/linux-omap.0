From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards
Date: Mon, 15 Jun 2009 05:56:04 -0700
Message-ID: <20090615125603.GP4474@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57301 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZFOM4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 08:56:03 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1MGBjI-000JDD-JU
	for linux-omap@vger.kernel.org; Mon, 15 Jun 2009 12:56:04 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a minimal patch to add onenand support for SDPs.

Tony

--lrZ03NoBR/3+SXJZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="sdp-flash.patch"

>From b8a6a05466f241454e73966dd5b1446216fed3db Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 15 Jun 2009 15:43:37 +0300
Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards

Add support for flash on SDP boards. Currently only onenand
is supported.

Only tested on 3430SDP, somebody please test on 2430SDP.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1f86f11..a0c2ac1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
@@ -57,6 +58,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o \
 					   board-n800-mmc.o \
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 9c3fdcd..3aa106f 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -39,6 +39,7 @@
 #include <mach/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
+#include "board-sdp.h"
 
 #define SDP2430_CS0_BASE	0x04000000
 #define SECONDARY_LCD_GPIO		147
@@ -211,6 +212,7 @@ static void __init omap_2430sdp_init(void)
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init();
 
 	/* Turn off secondary LCD backlight */
 	ret = gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD backlight");
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 21b4a52..6f16803 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -43,6 +43,7 @@
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
+#include "board-sdp.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -495,6 +496,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 }
 
diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
new file mode 100644
index 0000000..1496d89
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -0,0 +1,78 @@
+/*
+ * linux/arch/arm/mach-omap2/board-sdp-flash.c
+ *
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include <mach/onenand.h>
+
+/* REVISIT: Add support for other flash memory types */
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition board_onenand_partitions[] = {
+	{
+		.name		= "X-Loader-OneNAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE	 /* force read-only */
+	},
+	{
+		.name		= "U-Boot-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE	 /* force read-only */
+	},
+	{
+		.name		= "U-Boot Environment-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 1 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 16 * (64 * 2048),
+	},
+	{
+		.name		= "File System-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 2,	/* REVISIT: Is this the same for 2430 SDP? */
+	.parts		= board_onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(board_onenand_partitions),
+	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static void __init board_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#else
+
+static inline void board_onenand_init(void)
+{
+}
+
+#endif	/* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
+
+void __init sdp_flash_init(void)
+{
+	board_onenand_init();
+}
diff --git a/arch/arm/mach-omap2/board-sdp.h b/arch/arm/mach-omap2/board-sdp.h
new file mode 100644
index 0000000..ad72189
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp.h
@@ -0,0 +1,9 @@
+/*
+ *  arch/arm/plat-omap/include/mach/board-sdp.h
+ *
+ *  Information structures for SDP-specific board config data
+ *
+ *  Copyright (C) 2009 Nokia Corporation
+ */
+
+extern void sdp_flash_init(void);

--lrZ03NoBR/3+SXJZ--
