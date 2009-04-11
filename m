From: Russ Dill <russ.dill@gmail.com>
Subject: [RFC] Save HSMMC registers if core is powered off
Date: Sat, 11 Apr 2009 00:32:10 -0700
Message-ID: <1239435130-30784-1-git-send-email-Russ.Dill@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:43972 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbZDKHcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Apr 2009 03:32:16 -0400
Received: by qyk16 with SMTP id 16so2739006qyk.33
        for <linux-omap@vger.kernel.org>; Sat, 11 Apr 2009 00:32:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com, linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@gmail.com>

I've noticed that if the core power domain gets powered off during
suspend, the MMC registers get reset. Which, among other things causes
the MMC host controller code to turn on VMMC1 even if no MMC card is
present.

I'm not sure if this is the right place to put this code. It also
doesn't work. If any of the __raw_readl commands execute, the board will
hang on a suspend attempt (assuming the core domain will be powered
off.) Strangely, the __raw_writel commands don't cause problems (other
than writing 0s to all the MMC registers.)

My platform is an OMAP3430 on a rev B7 Beagleboard. The patch is against
omap/pm.
---
 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/hsmmc.c             |   73 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c            |    5 ++
 arch/arm/plat-omap/include/mach/hsmmc.h |   15 ++++++
 4 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hsmmc.c
 create mode 100644 arch/arm/plat-omap/include/mach/hsmmc.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c58bab4..4dd8ec0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,6 +24,7 @@ obj-y					+= pm.o
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= hsmmc.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 endif
 
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
new file mode 100644
index 0000000..9ac6f91
--- /dev/null
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -0,0 +1,73 @@
+/*
+ * HSMMC context save/restore functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/io.h>
+
+#include <mach/mmc.h>
+
+#define HSMMC_SYSCONFIG	0x0010
+#define HSMMC_CON	0x002c
+#define HSMMC_HCTL	0x0128
+#define HSMMC_SYSCTL	0x012c
+#define HSMMC_IE	0x0134
+#define HSMMC_ISE	0x0138
+
+static const void __iomem *instances[] = {
+	OMAP2_IO_ADDRESS(OMAP2_MMC1_BASE),
+	OMAP2_IO_ADDRESS(OMAP2_MMC2_BASE),
+	OMAP2_IO_ADDRESS(OMAP3_MMC3_BASE),
+};
+
+struct omap3_hsmmc_regs {
+	u32 sysconfig;
+	u32 con;
+	u32 hctl;
+	u32 sysctl;
+	u32 ie;
+	u32 ise;
+};
+
+static struct omap3_hsmmc_regs hsmmc_context[ARRAY_SIZE(instances)];
+
+static void hsmmc_write_reg(int id, int idx, u32 val)
+{
+	__raw_writel(val, instances[id] + idx);
+}
+
+static u32 hsmmc_read_reg(int id, int idx)
+{
+	return 0;//__raw_readl(instances[id] + idx);
+}
+
+void omap3_hsmmc_save_context(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(instances); i++) {
+		hsmmc_context[i].sysconfig = hsmmc_read_reg(i, HSMMC_SYSCONFIG);
+		hsmmc_context[i].con = hsmmc_read_reg(i, HSMMC_CON);
+		hsmmc_context[i].hctl = hsmmc_read_reg(i, HSMMC_HCTL);
+		hsmmc_context[i].sysctl = hsmmc_read_reg(i, HSMMC_SYSCTL);
+		hsmmc_context[i].ie = hsmmc_read_reg(i, HSMMC_IE);
+		hsmmc_context[i].ise = hsmmc_read_reg(i, HSMMC_ISE);
+	}
+}
+
+void omap3_hsmmc_restore_context(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(instances); i++) {
+		hsmmc_write_reg(i, HSMMC_SYSCONFIG, hsmmc_context[i].sysconfig);
+		hsmmc_write_reg(i, HSMMC_CON, hsmmc_context[i].con);
+		hsmmc_write_reg(i, HSMMC_HCTL, hsmmc_context[i].hctl);
+		hsmmc_write_reg(i, HSMMC_SYSCTL, hsmmc_context[i].sysctl);
+		hsmmc_write_reg(i, HSMMC_IE, hsmmc_context[i].ie);
+		hsmmc_write_reg(i, HSMMC_ISE, hsmmc_context[i].ise);
+	}
+}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7474cfa..b2393c5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -41,6 +41,7 @@
 #include <mach/sdrc.h>
 #include <mach/dma.h>
 #include <mach/gpmc.h>
+#include <mach/hsmmc.h>
 #include <mach/dma.h>
 #include <asm/tlbflush.h>
 
@@ -148,6 +149,8 @@ static void omap3_core_save_context(void)
 	omap3_intc_save_context();
 	/* Save the GPMC context */
 	omap3_gpmc_save_context();
+	/* Save the HSMMC context */
+	omap3_hsmmc_save_context();
 	/* Save the system control module context, padconf already save above*/
 	omap3_control_save_context();
 	omap_dma_global_context_save();
@@ -159,6 +162,8 @@ static void omap3_core_restore_context(void)
 	omap3_control_restore_context();
 	/* Restore the GPMC context */
 	omap3_gpmc_restore_context();
+	/* Restore the HSMMC context */
+	omap3_hsmmc_restore_context();
 	/* Restore the interrupt controller context */
 	omap3_intc_restore_context();
 	omap_dma_global_context_restore();
diff --git a/arch/arm/plat-omap/include/mach/hsmmc.h b/arch/arm/plat-omap/include/mach/hsmmc.h
new file mode 100644
index 0000000..ae3caee
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/hsmmc.h
@@ -0,0 +1,15 @@
+/*
+ * HSMMC save/restore logic for OMAP3
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP3_HSMMC_H
+#define __OMAP3_HSMMC_H
+
+extern void omap3_hsmmc_save_context(void);
+extern void omap3_hsmmc_restore_context(void);
+
+#endif
-- 
1.6.0.4

