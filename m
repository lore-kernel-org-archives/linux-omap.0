From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/29] gpmc context save/restore
Date: Thu, 11 Sep 2008 15:33:54 +0300
Message-ID: <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18897 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbYIKMeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:36 -0400
In-Reply-To: <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds the context save restore functions for GPMC
---
 arch/arm/mach-omap2/gpmc.c             |   80 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/gpmc.h |   14 ++++++
 2 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3e0271..32f36fa 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -54,6 +54,21 @@
 #define GPMC_CHUNK_SHIFT	24		/* 16 MB */
 #define GPMC_SECTION_SHIFT	28		/* 128 MB */
 
+/*
+ * Structure to save/restore gpmc context
+ * to support core off
+ */
+static struct gpmc_context {
+	u32 sysconfig;
+	u32 irqenable;
+	u32 timeout_ctrl;
+	u32 config;
+	u32 prefetch_config1;
+	u32 prefetch_config2;
+	u32 prefetch_control;
+	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
+} gpmc_ctx;
+
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
@@ -451,3 +466,68 @@ void __init gpmc_init(void)
 
 	gpmc_mem_init();
 }
+
+void omap_save_gpmc_ctx()
+{
+	int i;
+	gpmc_ctx.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
+	gpmc_ctx.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
+	gpmc_ctx.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
+	gpmc_ctx.config = gpmc_read_reg(GPMC_CONFIG);
+	gpmc_ctx.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+	gpmc_ctx.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
+	gpmc_ctx.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
+	for (i = 0; i < GPMC_CS_NUM; i++) {
+		gpmc_ctx.cs_context[i].is_valid =
+				(gpmc_cs_read_reg(i, GPMC_CS_CONFIG7))
+								& (1 << 6);
+		if (gpmc_ctx.cs_context[i].is_valid) {
+			gpmc_ctx.cs_context[i].gpmc_config1 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
+			gpmc_ctx.cs_context[i].gpmc_config2 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
+			gpmc_ctx.cs_context[i].gpmc_config3 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
+			gpmc_ctx.cs_context[i].gpmc_config4 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
+			gpmc_ctx.cs_context[i].gpmc_config5 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
+			gpmc_ctx.cs_context[i].gpmc_config6 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
+			gpmc_ctx.cs_context[i].gpmc_config7 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
+		}
+	}
+}
+
+void omap_restore_gpmc_ctx()
+{
+	int i;
+	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_ctx.sysconfig);
+	gpmc_write_reg(GPMC_IRQENABLE, gpmc_ctx.irqenable);
+	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_ctx.timeout_ctrl);
+	gpmc_write_reg(GPMC_CONFIG, gpmc_ctx.config);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_ctx.prefetch_config1);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_ctx.prefetch_config2);
+	gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_ctx.prefetch_control);
+	for (i = 0; i < GPMC_CS_NUM; i++) {
+		if (gpmc_ctx.cs_context[i].is_valid) {
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
+					gpmc_ctx.cs_context[i].gpmc_config1);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG2,
+					gpmc_ctx.cs_context[i].gpmc_config2);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG3,
+					gpmc_ctx.cs_context[i].gpmc_config3);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG4,
+					gpmc_ctx.cs_context[i].gpmc_config4);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG5,
+					gpmc_ctx.cs_context[i].gpmc_config5);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG6,
+					gpmc_ctx.cs_context[i].gpmc_config6);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG7,
+					gpmc_ctx.cs_context[i].gpmc_config7);
+		}
+	}
+}
+
+
diff --git a/arch/arm/plat-omap/include/mach/gpmc.h b/arch/arm/plat-omap/include/mach/gpmc.h
index 921b165..133991c 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -90,6 +90,18 @@ struct gpmc_timings {
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
+/* Structure to save gpmc cs context */
+struct gpmc_cs_config {
+	u32 gpmc_config1;
+	u32 gpmc_config2;
+	u32 gpmc_config3;
+	u32 gpmc_config4;
+	u32 gpmc_config5;
+	u32 gpmc_config6;
+	u32 gpmc_config7;
+	int is_valid;
+};
+
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
@@ -103,6 +115,8 @@ extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
+extern void omap_save_gpmc_ctx(void);
+extern void omap_restore_gpmc_ctx(void);
 extern void __init gpmc_init(void);
 
 #endif
-- 
1.6.0

