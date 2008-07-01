From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 07/11] gpmc context save/restore
Date: Tue, 1 Jul 2008 19:46:22 +0530
Message-ID: <004401c8db85$0a3f6800$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45476 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759598AbYGAOQb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2008 10:16:31 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EGNw4004898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:16:30 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m61EGJGq011499
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 19:46:22 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the context save restore functions for GPMC 

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/gpmc.c       |   80 +++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/gpmc.h |   14 ++++++
 2 files changed, 94 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/gpmc.c	2008-06-09 18:04:48.408424442 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/gpmc.c	2008-06-09 18:07:05.952023290 +0530
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
@@ -429,3 +444,68 @@ void __init gpmc_init(void)
 
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
Index: linux-omap-2.6/include/asm-arm/arch-omap/gpmc.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/gpmc.h	2008-06-09 18:07:02.217142804 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/gpmc.h	2008-06-09 18:10:31.189455603 +0530
@@ -86,6 +86,18 @@ struct gpmc_timings {
 	u16 wr_cycle;		/* Total write cycle time */
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
@@ -99,5 +111,7 @@ extern int gpmc_cs_request(int cs, unsig
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
+extern void omap_save_gpmc_ctx(void);
+extern void omap_restore_gpmc_ctx(void);
 
 #endif

