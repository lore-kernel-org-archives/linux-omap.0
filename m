From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/28] OMAP3: PM: GPMC context save/restore
Date: Thu,  1 Oct 2009 16:58:31 -0700
Message-ID: <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbZJAX65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:58:57 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:02 -0700 (PDT)
In-Reply-To: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds the context save restore functions for GPMC

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   93 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/gpmc.h |    3 +
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1587682..86ea936 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -62,10 +62,38 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
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
 
@@ -516,3 +544,68 @@ void __init gpmc_init(void)
 	gpmc_write_reg(GPMC_SYSCONFIG, l);
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
diff --git a/arch/arm/plat-omap/include/mach/gpmc.h b/arch/arm/plat-omap/include/mach/gpmc.h
index 9c99cda..696e0ca 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -52,6 +52,7 @@
 #define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
 #define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
+#define GPMC_CONFIG7_CSVALID		(1 << 6)
 
 /*
  * Note that all values in this struct are in nanoseconds, while
@@ -107,6 +108,8 @@ extern int gpmc_prefetch_enable(int cs, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern void gpmc_prefetch_reset(void);
 extern int gpmc_prefetch_status(void);
+extern void omap3_gpmc_save_context(void);
+extern void omap3_gpmc_restore_context(void);
 extern void __init gpmc_init(void);
 
 #endif
-- 
1.6.4.3

