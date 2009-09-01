From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH 2/2] OMAP3: Add support for NAND on ZOOM2/LDP boards
Date: Tue, 1 Sep 2009 14:58:52 +0530 (IST)
Message-ID: <41810.192.168.10.89.1251797332.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37482 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbZIAJ24 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Sep 2009 05:28:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Adding NAND support for ZOOM2 and LDP board. I have tested it for ZOOM2
boards, someone can verify it for LDP, hopefully it should not have any
problem.

The size of the U-Boot environment partition was increased to 1.25MB.

Singned-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile                |    2
 arch/arm/mach-omap2/board-ldp-flash.c       |  196 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c             |    2
 arch/arm/mach-omap2/board-zoom2.c           |    2
 arch/arm/plat-omap/include/mach/board-ldp.h |   36 +++++
 arch/arm/plat-omap/include/mach/nand.h      |    1
 6 files changed, 239 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile
+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= boar
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
+					   board-ldp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o
@@ -69,6 +70,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+					   board-ldp-flash.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o

Index: linux-omap-2.6/arch/arm/mach-omap2/board-ldp-flash.c
===================================================================
--- /dev/null
+++ linux-omap-2.6/arch/arm/mach-omap2/board-ldp-flash.c
@@ -0,0 +1,196 @@
+/*
+ * arch/arm/mach-omap2/board-ldp-flash.c
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
+#include <mach/board.h>
+#include <mach/gpmc.h>
+#include <mach/nand.h>
+
+#include <mach/board-ldp.h>
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
+static int omap_ldp_nand_unlock(struct mtd_info *mtd, loff_t ofs, size_t len)
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
+void __init ldp_flash_init(void)
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
Index: linux-omap-2.6/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-ldp.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-ldp.c
@@ -42,6 +42,7 @@
 #include <mach/control.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
+#include <mach/board-ldp.h>

 #include "mmc-twl4030.h"

@@ -385,6 +386,7 @@ static void __init omap_ldp_init(void)
 	ads7846_dev_init();
 	omap_serial_init(&ldp_uart_config);
 	usb_musb_init();
+	ldp_flash_init();

 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
Index: linux-omap-2.6/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-zoom2.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-zoom2.c
@@ -20,6 +20,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>

+#include <mach/board-ldp.h>
 #include <mach/common.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
@@ -271,6 +272,7 @@ static void __init omap_zoom2_init(void)
 	omap_serial_init(&zoom2_uart_config);
 	omap_zoom2_debugboard_init();
 	usb_musb_init();
+	ldp_flash_init();
 }

 static void __init omap_zoom2_map_io(void)
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/board-ldp.h
===================================================================
--- /dev/null
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/board-ldp.h
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/plat-omap/include/mach/board-ldp.h
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
+extern void ldp_flash_init(void);
+
+#define LDP3430_NAND_CS               0
+
+#endif /* __ASM_ARCH_OMAP_LDP_H */
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/nand.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/nand.h
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/nand.h
@@ -18,6 +18,7 @@ struct omap_nand_platform_data {
 	int			nr_parts;
 	int			(*nand_setup)(void __iomem *);
 	int			(*dev_ready)(struct omap_nand_platform_data *);
+	int			(*unlock)(struct mtd_info *, loff_t, size_t);
 	int			dma_channel;
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;


