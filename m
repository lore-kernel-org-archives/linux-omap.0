From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 4/7] OMAP3 EVM: add onenand flash support
Date: Mon, 28 Apr 2008 16:29:14 -0700
Message-ID: <5e088bd90804281629n5bb4eb0cu3eb1704e521548cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43564 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbYD1X3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:29:14 -0400
Received: by ug-out-1314.google.com with SMTP id z38so953239ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 16:29:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Add onenand support for OMAP3 EVM

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/Makefile               |    3
 arch/arm/mach-omap2/board-omap3evm-flash.c |  117 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c       |    1
 include/asm-arm/arch-omap/board-omap3evm.h |    4 +
 4 files changed, 126 insertions(+), 1 deletion(-)
diff -uprN -X a/Documentation/dontdiff
a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
--- a/arch/arm/mach-omap2/board-omap3evm.c	2008-04-27 22:48:55.000000000 -0700
+++ b/arch/arm/mach-omap2/board-omap3evm.c	2008-04-28 09:21:22.000000000 -0700
@@ -71,6 +71,7 @@ static void __init omap3_evm_init(void)
 	hsmmc_init();
 	usb_musb_init();
 	usb_ehci_init();
+	omap3evm_flash_init();
 }

 arch_initcall(omap3_evm_i2c_init);
diff -uprN -X a/Documentation/dontdiff
a/arch/arm/mach-omap2/board-omap3evm-flash.c
b/arch/arm/mach-omap2/board-omap3evm-flash.c
--- a/arch/arm/mach-omap2/board-omap3evm-flash.c	1969-12-31
16:00:00.000000000 -0800
+++ b/arch/arm/mach-omap2/board-omap3evm-flash.c	2008-04-28
09:11:46.000000000 -0700
@@ -0,0 +1,117 @@
+/*
+ * board-omap3evm-flash.c
+ *
+ * Copyright (c) 2008 Texas Instruments,
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
+#include <linux/mtd/nand.h>
+#include <linux/mtd/onenand_regs.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+#include <asm/arch/onenand.h>
+#include <asm/arch/board.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/nand.h>
+
+static int omap3evm_onenand_setup(void __iomem *);
+
+static struct mtd_partition omap3evm_onenand_partitions[] = {
+	{
+		.name           = "xloader",
+		.offset         = 0,
+		.size           = 4*(64*2048),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           =  15*(64*2048),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "params",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 1*(64*2048),
+	},
+	{
+		.name           = "linux",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 40*(64*2048),
+	},
+	{
+		.name           = "jffs2",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data omap3evm_onenand_data = {
+	.parts = omap3evm_onenand_partitions,
+	.nr_parts = ARRAY_SIZE(omap3evm_onenand_partitions),
+	.onenand_setup = omap3evm_onenand_setup,
+	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device omap3evm_onenand_device = {
+	.name		= "omap2-onenand",
+	.id		= -1,
+	.dev = {
+		.platform_data = &omap3evm_onenand_data,
+	},
+};
+
+/*
+ *      omap3evm_onenand_setup - Set the onenand sync mode
+ *      @onenand_base:  The onenand base address in GPMC memory map
+ *
+ */
+
+static int omap3evm_onenand_setup(void __iomem *onenand_base)
+	{
+	/* nothing is required to be setup for onenand as of now */
+	return 0;
+}
+
+void __init omap3evm_flash_init(void)
+{
+	u8		cs = 0;
+	u8		onenandcs = GPMC_CS_NUM + 1;
+
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+
+		/*
+		* xloader/Uboot would have programmed the oneNAND
+		* base address for us This is a ugly hack. The proper
+		* way of doing this is to pass the setup of u-boot up
+		* to kernel using kernel params - something on the
+		* lines of machineID. Check if oneNAND is configured
+		*/
+		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
+			onenandcs = cs;
+		cs++;
+	}
+	if (onenandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "OneNAND: Unable to find configuration "
+				" in GPMC\n ");
+		return;
+	}
+
+	if (onenandcs < GPMC_CS_NUM) {
+		omap3evm_onenand_data.cs = onenandcs;
+		if (platform_device_register(&omap3evm_onenand_device) < 0)
+			printk(KERN_ERR "Unable to register OneNAND device\n");
+	}
+}
+
diff -uprN -X a/Documentation/dontdiff a/arch/arm/mach-omap2/Makefile
b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile	2008-04-28 07:29:24.000000000 -0700
+++ b/arch/arm/mach-omap2/Makefile	2008-04-28 09:11:46.000000000 -0700
@@ -39,7 +39,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= boar
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 					   hsmmc.o \
-					   usb-musb.o usb-ehci.o
+					   usb-musb.o usb-ehci.o \
+					   board-omap3evm-flash.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   usb-musb.o usb-ehci.o \
 					   hsmmc.o
diff -uprN -X a/Documentation/dontdiff
a/include/asm-arm/arch-omap/board-omap3evm.h
b/include/asm-arm/arch-omap/board-omap3evm.h
--- a/include/asm-arm/arch-omap/board-omap3evm.h	2008-04-26
06:32:31.000000000 -0700
+++ b/include/asm-arm/arch-omap/board-omap3evm.h	2008-04-28
09:21:19.000000000 -0700
@@ -29,7 +29,11 @@
 #ifndef __ASM_ARCH_OMAP3_EVM_H
 #define __ASM_ARCH_OMAP3_EVM_H

+extern void omap3evm_flash_init(void);
+
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ

+#define ONENAND_MAP		0x20000000
+
 #endif /* __ASM_ARCH_OMAP3_EVM_H */
