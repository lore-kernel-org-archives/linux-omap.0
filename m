From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v2 05/11] OMAP4: DMA: HWMOD: Add hwmod data structures
Date: Tue, 24 Aug 2010 16:34:20 +0530
Message-ID: <1282647866-6918-6-git-send-email-manjugk@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0HXLFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 07:05:43 -0400
In-Reply-To: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds OMAP4430 DMA hwmod structures.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 ++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e20b0ee..2f54adc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/dma.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -35,6 +36,7 @@
 #define OMAP44XX_DMA_REQ_START  1
 
 /* Backward references (IPs with Bus Master capability) */
+static struct omap_hwmod omap44xx_dma_system_hwmod;
 static struct omap_hwmod omap44xx_dmm_hwmod;
 static struct omap_hwmod omap44xx_emif_fw_hwmod;
 static struct omap_hwmod omap44xx_l3_instr_hwmod;
@@ -215,6 +217,14 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* dma_system -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
+	.master		= &omap44xx_dma_system_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -226,6 +236,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 /* l3_main_2 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
 	&omap44xx_l3_main_1__l3_main_2,
+	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
 };
 
@@ -452,6 +463,92 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'dma' class
+ * dma controller for data exchange between memory to memory (i.e. internal or
+ * external memory) and gp peripherals to memory or memory to gp peripherals
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x002c,
+	.syss_offs	= 0x0028,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
+	.name = "dma",
+	.sysc = &omap44xx_dma_sysc,
+};
+
+/* dma attributes */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dev_caps  = DMA_LINKED_LCH | GLOBAL_PRIORITY |
+				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORIY,
+	.lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT,
+};
+
+/* dma_system */
+static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
+	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
+	{
+		.pa_start	= 0x4a056000,
+		.pa_end		= 0x4a0560ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* dma_system master ports */
+static struct omap_hwmod_ocp_if *omap44xx_dma_system_masters[] = {
+	&omap44xx_dma_system__l3_main_2,
+};
+
+/* l4_cfg -> dma_system */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_dma_system_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_dma_system_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dma_system_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dma_system_slaves[] = {
+	&omap44xx_l4_cfg__dma_system,
+};
+
+static struct omap_hwmod omap44xx_dma_system_hwmod = {
+	.name		= "dma_system",
+	.class		= &omap44xx_dma_hwmod_class,
+	.mpu_irqs	= omap44xx_dma_system_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dma_system_irqs),
+	.main_clk	= "l3_div_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dma_system_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
+	.masters	= omap44xx_dma_system_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
+	.dev_attr	= &dma_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -472,6 +569,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
+	/* dma class */
+	&omap44xx_dma_system_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4

