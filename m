From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v6 2/4] OMAP3: Add support for NAND on ZOOM/LDP boards
Date: Thu, 19 Nov 2009 19:46:43 +0530
Message-ID: <ce9ab5790911190616r6808feacr78d581dd958e6362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64359 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbZKSORD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 09:17:03 -0500
Received: by bwz27 with SMTP id 27so2385831bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 06:17:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

>From 43df1ee9e29d454100e59ee4902db157072b81b6 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 19 Nov 2009 14:37:44 +0530
Subject: [PATCH] OMAP3: Add support for NAND on ZOOM/LDP boards

Adding NAND support for ZOOM2/3 and LDP board.
I have tested it for ZOOM2 boards. Someone can verify it for LDP
and ZOOM3 boards, hopefully it should not have any problem.

The size of the U-Boot environment partition was increased to 1.25MB.

Vikram: Changed ldp name to zoom.
      Future boards will be called Zoom2/3/4 etc.
      LDP is a Zoom1. Somhow the LDP name got stuck to that.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile                 |    3 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-zoom-flash.c       |   92 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
 arch/arm/plat-omap/include/plat/board-zoom.h |   36 ++++++++++
 5 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
 create mode 100644 arch/arm/plat-omap/include/plat/board-zoom.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b0e5b46..c2ca76e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
+					   board-zoom-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o
@@ -78,10 +79,12 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+ 					   board-zoom-flash.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
+ 					   board-zoom-flash.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
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
index 0000000..1867d6a
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom-flash.c
@@ -0,0 +1,92 @@
+/*
+ * board-zoom-flash.c
+ *
+ * Copyright (C) 2008-09 Texas Instruments Inc.
+ *
+ * Modified from mach-omap2/board-2430sdp-flash.c
+ * Author(s): Vimal Singh <vimalsingh@ti.com>
+ *            Rohit Choraria <rohitkc@ti.com>
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
+static struct mtd_partition zoom_nand_partitions[] = {
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
+	{
+		.name		= "File System - NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+/* NAND chip access: 16 bit */
+static struct omap_nand_platform_data zoom_nand_data = {
+	.parts		= zoom_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(zoom_nand_partitions),
+	.nand_setup	= NULL,
+	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
+};
+
+/**
+ * zoom_flash_init - Identify devices connected to GPMC and register.
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
+	zoom_nand_data.cs = nandcs;
+	zoom_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+	zoom_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+	gpmc_nand_init(&zoom_nand_data);
+}
+
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index f14baa3..fcc2836 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>

+#include <plat/board-zoom.h>
 #include <plat/common.h>
 #include <plat/usb.h>

@@ -264,4 +265,5 @@ void __init zoom_peripherals_init(void)
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
+	zoom_flash_init();
 }
diff --git a/arch/arm/plat-omap/include/plat/board-zoom.h
b/arch/arm/plat-omap/include/plat/board-zoom.h
new file mode 100644
index 0000000..8d63f7e
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/board-zoom.h
@@ -0,0 +1,36 @@
+/*
+ * board-zoom.h
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
-- 
1.5.5
