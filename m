From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 03/14] OMAP2420: hwmod data: add system DMA
Date: Wed, 24 Nov 2010 18:21:39 +0530
Message-ID: <1290603110-14119-4-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53646 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970Ab0KXMwN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 07:52:13 -0500
In-Reply-To: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Add OMAP2420 DMA hwmod data and also add required
DMA device attributes.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   87 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h      |   11 ++++
 2 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a1a3dd6..81aa0d9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -38,6 +38,7 @@ static struct omap_hwmod omap2420_iva_hwmod;
 static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
 static struct omap_hwmod omap2420_wd_timer2_hwmod;
+static struct omap_hwmod omap2420_dma_system_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
@@ -557,6 +558,89 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };
 
+/* system dma */
+static struct omap_hwmod_class_sysconfig omap2420_dma_sysc = {
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
+static struct omap_hwmod_class omap2420_dma_hwmod_class = {
+	.name = "dma",
+	.sysc = &omap2420_dma_sysc,
+};
+
+/* dma attributes */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dev_caps  = RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
+						IS_CSSA_32 | IS_CDSA_32,
+	.lch_count = 32,
+};
+
+static struct omap_hwmod_irq_info omap2420_dma_system_irqs[] = {
+	{ .name = "0", .irq = 12 }, /* INT_24XX_SDMA_IRQ0 */
+	{ .name = "1", .irq = 13 }, /* INT_24XX_SDMA_IRQ1 */
+	{ .name = "2", .irq = 14 }, /* INT_24XX_SDMA_IRQ2 */
+	{ .name = "3", .irq = 15 }, /* INT_24XX_SDMA_IRQ3 */
+};
+
+static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] = {
+	{
+		.pa_start	= 0x48056000,
+		.pa_end		= 0x4a0560ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* dma_system -> L3 */
+static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
+	.master		= &omap2420_dma_system_hwmod,
+	.slave		= &omap2420_l3_main_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system master ports */
+static struct omap_hwmod_ocp_if *omap2420_dma_system_masters[] = {
+	&omap2420_dma_system__l3,
+};
+
+/* l4_cfg -> dma_system */
+static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_dma_system_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap2420_dma_system_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_dma_system_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system slave ports */
+static struct omap_hwmod_ocp_if *omap2420_dma_system_slaves[] = {
+	&omap2420_l4_core__dma_system,
+};
+
+static struct omap_hwmod omap2420_dma_system_hwmod = {
+	.name		= "dma",
+	.class		= &omap2420_dma_hwmod_class,
+	.mpu_irqs	= omap2420_dma_system_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dma_system_irqs),
+	.main_clk	= "l3_div_ck",
+	.slaves		= omap2420_dma_system_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_dma_system_slaves),
+	.masters	= omap2420_dma_system_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_dma_system_masters),
+	.dev_attr	= &dma_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -569,6 +653,9 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_uart3_hwmod,
 	&omap2420_i2c1_hwmod,
 	&omap2420_i2c2_hwmod,
+
+	/* dma_system class*/
+	&omap2420_dma_system_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 2378399..c466566 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -295,6 +295,13 @@
 #define DMA_ERRATA_3_3			BIT(0x5)
 #define DMA_ROMCODE_BUG			BIT(0x6)
 
+/* Attributes for OMAP DMA Contrller */
+#define DMA_LINKED_LCH			BIT(0x0)
+#define GLOBAL_PRIORITY			BIT(0x1)
+#define RESERVE_CHANNEL			BIT(0x2)
+#define IS_CSSA_32			BIT(0x3)
+#define IS_CDSA_32			BIT(0x4)
+
 enum omap_reg_offsets {
 
 GCR,		GSCR,		GRST1,		HW_ID,
@@ -389,6 +396,10 @@ struct omap_dma_channel_params {
 #endif
 };
 
+struct omap_dma_dev_attr {
+	u32 dev_caps;
+	u16 lch_count;
+};
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
-- 
1.7.1

