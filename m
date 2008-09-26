From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 02/16] OMAP3: GPMC context save/restore
Date: Fri, 26 Sep 2008 17:47:33 +0530
Message-ID: <01f301c91fd1$db2794c0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbYIZMRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:17:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds the context save restore functions for GPMC 

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   93 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/gpmc.h |    3 +
 2 files changed, 96 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/gpmc.c	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/gpmc.c	2008-09-25 16:27:13.000000000 +0530
@@ -54,10 +54,38 @@
 #define GPMC_CHUNK_SHIFT	24		/* 16 MB */
 #define GPMC_SECTION_SHIFT	28		/* 128 MB */
 
+/* Structure to save gpmc cs context */
+struct gpmc_cs_config {
+	u32 config1;
+	u32 config2;
+	u32 config3;
+	u32 config4;
+	u32 config5;
+	u32 config6;
+	u32 config7;
+	int is_valid;
+};
+
+/*
+ * Structure to save/restore gpmc context
+ * to support core off on OMAP3
+ */
+struct omap3_gpmc_regs {
+	u32 sysconfig;
+	u32 irqenable;
+	u32 timeout_ctrl;
+	u32 config;
+	u32 prefetch_config1;
+	u32 prefetch_config2;
+	u32 prefetch_control;
+	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
+};
+
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned		gpmc_cs_map;
+static struct omap3_gpmc_regs gpmc_context;
 
 static void __iomem *gpmc_base;
 
@@ -451,3 +479,68 @@ void __init gpmc_init(void)
 
 	gpmc_mem_init();
 }
+
+#ifdef CONFIG_ARCH_OMAP3
+void omap3_gpmc_save_context()
+{
+	int i;
+	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
+	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
+	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
+	gpmc_context.config = gpmc_read_reg(GPMC_CONFIG);
+	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
+	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
+	for (i = 0; i < GPMC_CS_NUM; i++) {
+		gpmc_context.cs_context[i].is_valid =
+				(gpmc_cs_read_reg(i, GPMC_CS_CONFIG7))
+							& GPMC_CONFIG7_CSVALID;
+		if (gpmc_context.cs_context[i].is_valid) {
+			gpmc_context.cs_context[i].config1 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
+			gpmc_context.cs_context[i].config2 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
+			gpmc_context.cs_context[i].config3 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
+			gpmc_context.cs_context[i].config4 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
+			gpmc_context.cs_context[i].config5 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
+			gpmc_context.cs_context[i].config6 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
+			gpmc_context.cs_context[i].config7 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
+		}
+	}
+}
+
+void omap3_gpmc_restore_context()
+{
+	int i;
+	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
+	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
+	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
+	gpmc_write_reg(GPMC_CONFIG, gpmc_context.config);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_context.prefetch_config1);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_context.prefetch_config2);
+	gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_context.prefetch_control);
+	for (i = 0; i < GPMC_CS_NUM; i++) {
+		if (gpmc_context.cs_context[i].is_valid) {
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
+				gpmc_context.cs_context[i].config1);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG2,
+				gpmc_context.cs_context[i].config2);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG3,
+				gpmc_context.cs_context[i].config3);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG4,
+				gpmc_context.cs_context[i].config4);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG5,
+				gpmc_context.cs_context[i].config5);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG6,
+				gpmc_context.cs_context[i].config6);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG7,
+				gpmc_context.cs_context[i].config7);
+		}
+	}
+}
+#endif /* CONFIG_ARCH_OMAP3 */
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpmc.h	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h	2008-09-25 16:27:13.000000000 +0530
@@ -52,6 +52,7 @@
 #define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
 #define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
+#define GPMC_CONFIG7_CSVALID		(1 << 6)
 
 /*
  * Note that all values in this struct are in nanoseconds, while
@@ -103,6 +104,8 @@ extern int gpmc_cs_request(int cs, unsig
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
+extern void omap3_gpmc_save_context(void);
+extern void omap3_gpmc_restore_context(void);
 extern void __init gpmc_init(void);
 
 #endif

