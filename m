From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v5 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
Date: Tue, 10 Nov 2009 15:38:27 +0530
Message-ID: <ce9ab5790911100208g42c886b3g13261ea8a1d79a04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50166 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbZKJKIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:08:43 -0500
Received: by fxm21 with SMTP id 21so794470fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 02:08:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 6f535d7128ca392458dd0cb31d138cda84747c06 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 10 Nov 2009 11:42:45 +0530
Subject: [PATCH] OMAP3: Add support for NAND on ZOOM2/LDP boards

Adding NAND support for ZOOM2 and LDP board. I have tested it for ZOOM2 boards,
someone can verify it for LDP, hopefully it should not have any problem.

The size of the U-Boot environment partition was increased to 1.25MB.

Vikram: Changed ldp name to zoom.
      Future boards will be called Zoom2/3/4 etc.
      LDP is a Zoom1. Somhow the LDP name got stuck to that.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-zoom-flash.c       |  196 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c            |    2 +
 arch/arm/plat-omap/include/plat/board-zoom.h |   36 +++++
 arch/arm/plat-omap/include/plat/nand.h       |    2 +
 6 files changed, 240 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
 create mode 100644 arch/arm/plat-omap/include/plat/board-zoom.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 627f500..b3a9d1c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
+					   board-zoom-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o
@@ -74,6 +75,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+					   board-zoom-flash.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c062238..8aebdf9 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -42,6 +42,7 @@
 #include <asm/delay.h>
 #include <plat/control.h>
 #include <plat/usb.h>
+#include <plat/board-zoom.h>

 #include "mmc-twl4030.h"

@@ -385,6 +386,7 @@ static void __init omap_ldp_init(void)
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
+	zoom_flash_init();

 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
b/arch/arm/mach-omap2/board-zoom-flash.c
new file mode 100644
index 0000000..1406a57
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom-flash.c
@@ -0,0 +1,196 @@
+/*
+ * arch/arm/mach-omap2/board-zoom-flash.c
+ *
+ * Copyright (C) 2008-09 Texas Instruments Inc.
+ *
+ * Modified from mach-omap2/board-2430sdp-flash.c
+ * Author(s): Rohit Choraria <rohitkc@ti.com>
+ *            Vimal Singh <vimalsingh@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+#include <plat/board.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+
+#include <plat/board-zoom.h>
+
+#define NAND_CMD_UNLOCK1	0x23
+#define NAND_CMD_UNLOCK2	0x24
+/**
+ * @brief platform specific unlock function
+ *
+ * @param mtd - mtd info
+ * @param ofs - offset to start unlock from
+ * @param len - length to unlock
+ *
+ * @return - unlock status
+ */
+static int omap_ldp_nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	int ret = 0;
+	int chipnr;
+	int status;
+	unsigned long page;
+	struct nand_chip *this = mtd->priv;
+	printk(KERN_INFO "nand_unlock: start: %08x, length: %d!\n",
+			(int)ofs, (int)len);
+
+	/* select the NAND device */
+	chipnr = (int)(ofs >> this->chip_shift);
+	this->select_chip(mtd, chipnr);
+	/* check the WP bit */
+	this->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+	if ((this->read_byte(mtd) & 0x80) == 0) {
+		printk(KERN_ERR "nand_unlock: Device is write protected!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if ((ofs & (mtd->writesize - 1)) != 0) {
+		printk(KERN_ERR "nand_unlock: Start address must be"
+				"beginning of nand page!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len == 0 || (len & (mtd->writesize - 1)) != 0) {
+		printk(KERN_ERR "nand_unlock: Length must be a multiple of "
+				"nand page size!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* submit address of first page to unlock */
+	page = (unsigned long)(ofs >> this->page_shift);
+	this->cmdfunc(mtd, NAND_CMD_UNLOCK1, -1, page & this->pagemask);
+
+	/* submit ADDRESS of LAST page to unlock */
+	page += (unsigned long)((ofs + len) >> this->page_shift) ;
+	this->cmdfunc(mtd, NAND_CMD_UNLOCK2, -1, page & this->pagemask);
+
+	/* call wait ready function */
+	status = this->waitfunc(mtd, this);
+	udelay(1000);
+	/* see if device thinks it succeeded */
+	if (status & 0x01) {
+		/* there was an error */
+		printk(KERN_ERR "nand_unlock: error status =0x%08x ", status);
+		ret = -EIO;
+		goto out;
+	}
+
+ out:
+	/* de-select the NAND device */
+	this->select_chip(mtd, -1);
+	return ret;
+}
+
+static struct mtd_partition ldp_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),	/* 512KB, 0x80000 */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 10 * (64 * 2048),	/* 1.25MB, 0x140000 */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+		.offset		= MTDPART_OFS_APPEND,   /* Offset = 0x1c0000 */
+		.size		= 2 * (64 * 2048),	/* 256KB, 0x40000 */
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x0200000*/
+		.size		= 240 * (64 * 2048),	/* 30M, 0x1E00000 */
+	},
+#ifdef CONFIG_MACH_OMAP_ZOOM2
+	{
+		.name		= "system",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
+		.size		= 1280 * (64 * 2048),   /* 160M, 0xA000000 */
+	},
+	{
+		.name		= "userdata",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0xC000000 */
+		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
+	},
+	{
+		.name		= "cache",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0xE000000 */
+		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
+	},
+#else
+	{
+		.name		= "File System - NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
+		.size		= MTDPART_SIZ_FULL,	/* 96MB, 0x6000000 */
+	},
+#endif
+};
+
+/* NAND chip access: 16 bit */
+static struct omap_nand_platform_data ldp_nand_data = {
+	.parts		= ldp_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(ldp_nand_partitions),
+	.nand_setup	= NULL,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+	.unlock		= omap_ldp_nand_unlock,
+};
+
+static struct resource ldp_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device ldp_nand_device = {
+	.name		= "omap2-nand",
+	.id		= 0,
+	.dev		= {
+	.platform_data	= &ldp_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &ldp_nand_resource,
+};
+
+/**
+ * ldp430_flash_init - Identify devices connected to GPMC and register.
+ *
+ * @return - void.
+ */
+void __init zoom_flash_init(void)
+{
+	u8 nandcs = GPMC_CS_NUM + 1;
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	/* pop nand part */
+	nandcs = LDP3430_NAND_CS;
+
+	ldp_nand_data.cs = nandcs;
+	ldp_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+	ldp_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+	if (platform_device_register(&ldp_nand_device) < 0)
+		printk(KERN_ERR "Unable to register NAND device\n");
+}
+
diff --git a/arch/arm/mach-omap2/board-zoom2.c
b/arch/arm/mach-omap2/board-zoom2.c
index 4ad9b94..b4101ae 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -21,6 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>

+#include <plat/board-zoom.h>
 #include <plat/common.h>
 #include <plat/usb.h>

@@ -273,6 +274,7 @@ static void __init omap_zoom2_init(void)
 	omap_serial_init();
 	omap_zoom2_debugboard_init();
 	usb_musb_init();
+	zoom_flash_init();
 }

 static void __init omap_zoom2_map_io(void)
diff --git a/arch/arm/plat-omap/include/plat/board-zoom.h
b/arch/arm/plat-omap/include/plat/board-zoom.h
new file mode 100644
index 0000000..d414ea5
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/board-zoom.h
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/plat-omap/include/plat/board-ldp.h
+ *
+ * Hardware definitions for TI OMAP3 LDP/ZOOM2.
+ *
+ * Copyright (C) 2008-09 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP_LDP_H
+#define __ASM_ARCH_OMAP_LDP_H
+
+extern void zoom_flash_init(void);
+
+#define LDP3430_NAND_CS               0
+
+#endif /* __ASM_ARCH_OMAP_LDP_H */
diff --git a/arch/arm/plat-omap/include/plat/nand.h
b/arch/arm/plat-omap/include/plat/nand.h
index 631a7be..3c2d434 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -18,6 +18,8 @@ struct omap_nand_platform_data {
 	int			nr_parts;
 	int			(*nand_setup)(void __iomem *);
 	int			(*dev_ready)(struct omap_nand_platform_data *);
+	int			(*unlock)(struct mtd_info *mtd, loff_t ofs,
+								uint64_t len);
 	int			dma_channel;
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;
-- 
1.5.5
