From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH 03/11] OMAP2430: DMA: HWMOD: Add hwmod data structures
Date: Thu, 29 Jul 2010 15:28:57 +0530
Message-ID: <1280397545-27323-4-git-send-email-manjugk@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53200 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378Ab0G2KBC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 06:01:02 -0400
In-Reply-To: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

This patch adds OMAP2430 DMA hwmod structures.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   89 ++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c0f3311..5463199 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -32,6 +32,7 @@
 static struct omap_hwmod omap2430_mpu_hwmod;
 static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
+static struct omap_hwmod omap2430_dma_system_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
@@ -138,11 +139,99 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* dma_system */
+static struct omap_hwmod_class_sysconfig omap2430_dma_sysc = {
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
+static struct omap_hwmod_class omap2430_dma_hwmod_class = {
+	.name = "dma",
+	.sysc = &omap2430_dma_sysc,
+};
+
+/* dma attributes */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dma_dev_attr = DMA_LINKED_LCH | GLOBAL_PRIORITY |
+				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORIY,
+	.dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT,
+};
+
+static struct omap_hwmod_irq_info omap2430_dma_system_irqs[] = {
+	{ .name = "dma_0", .irq = INT_24XX_SDMA_IRQ0 },
+	{ .name = "dma_1", .irq = INT_24XX_SDMA_IRQ1 },
+	{ .name = "dma_2", .irq = INT_24XX_SDMA_IRQ2 },
+	{ .name = "dma_3", .irq = INT_24XX_SDMA_IRQ3 },
+};
+
+static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] = {
+	{
+		.pa_start	= 0x48056000,
+		.pa_end		= 0x4a0560ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* dma_system -> L3 */
+static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
+	.master		= &omap2430_dma_system_hwmod,
+	.slave		= &omap2430_l3_main_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system master ports */
+static struct omap_hwmod_ocp_if *omap2430_dma_system_masters[] = {
+	&omap2430_dma_system__l3,
+};
+
+/* l4_cfg -> dma_system */
+static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_dma_system_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap2430_dma_system_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_dma_system_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system slave ports */
+static struct omap_hwmod_ocp_if *omap2430_dma_system_slaves[] = {
+	&omap2430_l4_core__dma_system,
+};
+
+static struct omap_hwmod omap2430_dma_system_hwmod = {
+	.name		= "dma",
+	.class		= &omap2430_dma_hwmod_class,
+	.mpu_irqs	= omap2430_dma_system_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dma_system_irqs),
+	.main_clk	= "l3_div_ck",
+	.prcm = {
+		.omap2 = {
+			/*.clkctrl_reg = NULL, */
+		},
+	},
+	.slaves		= omap2430_dma_system_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_dma_system_slaves),
+	.masters	= omap2430_dma_system_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_dma_system_masters),
+	.dev_attr	= &dma_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_dma_system_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4

