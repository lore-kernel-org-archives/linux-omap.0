From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 10/12] ARM: OMAP1: board files: deduplicate and clean some
 NAND-related code
Date: Tue, 10 Apr 2012 18:35:59 -0600
Message-ID: <20120411003555.27059.96204.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43941 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759919Ab2DKAiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:22 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Imre Deak <imre.deak@nokia.com>, Brian Swetland <swetland@google.com>, Kevin Hilman <kjh@hilman.org>, Kevin Hilman <khilman@ti.com>, Greg Lonnon <glonnon@ridgerun.com>

The H2, H3, Perseus2, and FSample board files all contain the same
duplicated code to handle NAND commands.  That code is missing
some casts around conversions from unsigned long to void __iomem *.

Consolidate the duplicated code into a new file,
arch/arm/mach-omap1/board-nand.c.  Resolve the sparse warnings by
adding appropriate casts:

arch/arm/mach-omap1/board-h2.c:193:9: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap1/board-h2.c:193:9:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap1/board-h2.c:193:9:    got unsigned long
arch/arm/mach-omap1/board-perseus2.c:157:9: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap1/board-perseus2.c:157:9:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap1/board-perseus2.c:157:9:    got unsigned long
arch/arm/mach-omap1/board-fsample.c:199:9: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap1/board-fsample.c:199:9:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap1/board-fsample.c:199:9:    got unsigned long
arch/arm/mach-omap1/board-h3.c:195:9: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap1/board-h3.c:195:9:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap1/board-h3.c:195:9:    got unsigned long

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Imre Deak <imre.deak@nokia.com>
Cc: Greg Lonnon <glonnon@ridgerun.com>
Cc: Kevin Hilman <kjh@hilman.org>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/Makefile         |   10 +++++----
 arch/arm/mach-omap1/board-fsample.c  |   16 +-------------
 arch/arm/mach-omap1/board-h2.c       |   17 +--------------
 arch/arm/mach-omap1/board-h3.c       |   16 +-------------
 arch/arm/mach-omap1/board-nand.c     |   39 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-perseus2.c |   16 +-------------
 arch/arm/mach-omap1/common.h         |    4 +++
 7 files changed, 53 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-nand.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 20d65af..398e9e5 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -31,13 +31,15 @@ usb-fs-$(CONFIG_USB)			:= usb.o
 obj-y					+= $(usb-fs-m) $(usb-fs-y)
 
 # Specific board support
-obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o board-h2-mmc.o
+obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o board-h2-mmc.o \
+					   board-nand.o
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
-obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
-obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o
+obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o board-nand.o
+obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o board-nand.o
 obj-$(CONFIG_MACH_OMAP_OSK)		+= board-osk.o
-obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o board-h3-mmc.o
+obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o board-h3-mmc.o \
+					   board-nand.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
 obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 80bd43c..4a4afb3 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -185,20 +185,6 @@ static struct platform_device nor_device = {
 	.resource	= &nor_resource,
 };
 
-static void nand_cmd_ctl(struct mtd_info *mtd, int cmd,	unsigned int ctrl)
-{
-	struct nand_chip *this = mtd->priv;
-	unsigned long mask;
-
-	if (cmd == NAND_CMD_NONE)
-		return;
-
-	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
-	if (ctrl & NAND_ALE)
-		mask |= 0x04;
-	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
-}
-
 #define FSAMPLE_NAND_RB_GPIO_PIN	62
 
 static int nand_dev_ready(struct mtd_info *mtd)
@@ -216,7 +202,7 @@ static struct platform_nand_data nand_data = {
 		.part_probe_types	= part_probes,
 	},
 	.ctrl	= {
-		.cmd_ctrl	= nand_cmd_ctl,
+		.cmd_ctrl	= omap1_nand_cmd_ctl,
 		.dev_ready	= nand_dev_ready,
 	},
 };
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 553a2e5..057ec13 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -179,20 +179,6 @@ static struct mtd_partition h2_nand_partitions[] = {
 	},
 };
 
-static void h2_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
-{
-	struct nand_chip *this = mtd->priv;
-	unsigned long mask;
-
-	if (cmd == NAND_CMD_NONE)
-		return;
-
-	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
-	if (ctrl & NAND_ALE)
-		mask |= 0x04;
-	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
-}
-
 #define H2_NAND_RB_GPIO_PIN	62
 
 static int h2_nand_dev_ready(struct mtd_info *mtd)
@@ -212,9 +198,8 @@ static struct platform_nand_data h2_nand_platdata = {
 		.part_probe_types	= h2_part_probes,
 	},
 	.ctrl	= {
-		.cmd_ctrl	= h2_nand_cmd_ctl,
+		.cmd_ctrl	= omap1_nand_cmd_ctl,
 		.dev_ready	= h2_nand_dev_ready,
-
 	},
 };
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4c19f4c..f6ddf87 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -181,20 +181,6 @@ static struct mtd_partition nand_partitions[] = {
 	},
 };
 
-static void nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
-{
-	struct nand_chip *this = mtd->priv;
-	unsigned long mask;
-
-	if (cmd == NAND_CMD_NONE)
-		return;
-
-	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
-	if (ctrl & NAND_ALE)
-		mask |= 0x04;
-	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
-}
-
 #define H3_NAND_RB_GPIO_PIN	10
 
 static int nand_dev_ready(struct mtd_info *mtd)
@@ -214,7 +200,7 @@ static struct platform_nand_data nand_platdata = {
 		.part_probe_types	= part_probes,
 	},
 	.ctrl	= {
-		.cmd_ctrl	= nand_cmd_ctl,
+		.cmd_ctrl	= omap1_nand_cmd_ctl,
 		.dev_ready	= nand_dev_ready,
 
 	},
diff --git a/arch/arm/mach-omap1/board-nand.c b/arch/arm/mach-omap1/board-nand.c
new file mode 100644
index 0000000..dfa8aab
--- /dev/null
+++ b/arch/arm/mach-omap1/board-nand.c
@@ -0,0 +1,39 @@
+/*
+ * linux/arch/arm/mach-omap1/board-nand.c
+ *
+ * Common OMAP1 board NAND code
+ *
+ * Copyright (C) 2004, 2012 Texas Instruments, Inc.
+ * Copyright (C) 2002 MontaVista Software, Inc.
+ * Copyright (C) 2001 RidgeRun, Inc.
+ * Author: RidgeRun, Inc.
+ *         Greg Lonnon (glonnon@ridgerun.com) or info@ridgerun.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+
+#include "common.h"
+
+void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long mask;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |= 0x04;
+
+	mask |= (unsigned long)this->IO_ADDR_W;
+
+	writeb(cmd, (void __iomem *)mask);
+}
+
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 76d4ee0..a2c8889 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -143,20 +143,6 @@ static struct platform_device nor_device = {
 	.resource	= &nor_resource,
 };
 
-static void nand_cmd_ctl(struct mtd_info *mtd, int cmd,	unsigned int ctrl)
-{
-	struct nand_chip *this = mtd->priv;
-	unsigned long mask;
-
-	if (cmd == NAND_CMD_NONE)
-		return;
-
-	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
-	if (ctrl & NAND_ALE)
-		mask |= 0x04;
-	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
-}
-
 #define P2_NAND_RB_GPIO_PIN	62
 
 static int nand_dev_ready(struct mtd_info *mtd)
@@ -174,7 +160,7 @@ static struct platform_nand_data nand_data = {
 		.part_probe_types	= part_probes,
 	},
 	.ctrl	= {
-		.cmd_ctrl	= nand_cmd_ctl,
+		.cmd_ctrl	= omap1_nand_cmd_ctl,
 		.dev_ready	= nand_dev_ready,
 	},
 };
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index a90b9d7..8cc616e 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -27,6 +27,7 @@
 #define __ARCH_ARM_MACH_OMAP1_COMMON_H
 
 #include <plat/common.h>
+#include <linux/mtd/mtd.h>
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
@@ -58,6 +59,9 @@ void omap1_restart(char, const char *);
 
 extern void __init omap_check_revision(void);
 
+extern void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
+			       unsigned int ctrl);
+
 extern struct sys_timer omap1_timer;
 extern bool omap_32k_timer_init(void);
 


