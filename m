From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 05/14] OMAP3: hwmod data: add system DMA
Date: Wed, 24 Nov 2010 18:21:41 +0530
Message-ID: <1290603110-14119-6-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44026 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab0KXMwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 07:52:24 -0500
In-Reply-To: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Add OMAP3 DMA hwmod data

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   96 ++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index a8bed84..a928024 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -45,6 +45,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
 static struct omap_hwmod omap3xxx_i2c1_hwmod;
 static struct omap_hwmod omap3xxx_i2c2_hwmod;
 static struct omap_hwmod omap3xxx_i2c3_hwmod;
+static struct omap_hwmod omap3xxx_dma_system_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -739,6 +740,98 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* dma_system -> L3 */
+static struct omap_hwmod_ocp_if omap3xxx_dma_system__l3 = {
+	.master		= &omap3xxx_dma_system_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma attributes */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dev_caps  = RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
+				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORITY,
+	.lch_count = 32,
+};
+
+static struct omap_hwmod_class_sysconfig omap3xxx_dma_sysc = {
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
+static struct omap_hwmod_class omap3xxx_dma_hwmod_class = {
+	.name = "dma",
+	.sysc = &omap3xxx_dma_sysc,
+};
+
+/* dma_system */
+static struct omap_hwmod_irq_info omap3xxx_dma_system_irqs[] = {
+	{ .name = "0", .irq = 12 }, /* INT_24XX_SDMA_IRQ0 */
+	{ .name = "1", .irq = 13 }, /* INT_24XX_SDMA_IRQ1 */
+	{ .name = "2", .irq = 14 }, /* INT_24XX_SDMA_IRQ2 */
+	{ .name = "3", .irq = 15 }, /* INT_24XX_SDMA_IRQ3 */
+};
+
+static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] = {
+	{
+		.pa_start	= 0x48056000,
+		.pa_end		= 0x4a0560ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* dma_system master ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dma_system_masters[] = {
+	&omap3xxx_dma_system__l3,
+};
+
+/* l4_cfg -> dma_system */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__dma_system = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_dma_system_hwmod,
+	.clk		= "core_l4_ick",
+	.addr		= omap3xxx_dma_system_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_dma_system_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dma_system_slaves[] = {
+	&omap3xxx_l4_core__dma_system,
+};
+
+static struct omap_hwmod omap3xxx_dma_system_hwmod = {
+	.name		= "dma",
+	.class		= &omap3xxx_dma_hwmod_class,
+	.mpu_irqs	= omap3xxx_dma_system_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
+	.main_clk	= "core_l3_ick",
+	.prcm = {
+		.omap2 = {
+			.module_offs		= CORE_MOD,
+			.prcm_reg_id		= 1,
+			.module_bit		= OMAP3430_ST_SDMA_SHIFT,
+			.idlest_reg_id		= 1,
+			.idlest_idle_bit	= OMAP3430_ST_SDMA_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_dma_system_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dma_system_slaves),
+	.masters	= omap3xxx_dma_system_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_dma_system_masters),
+	.dev_attr	= &dma_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -754,6 +847,9 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
+
+	/* dma_system class*/
+	&omap3xxx_dma_system_hwmod,
 	NULL,
 };
 
-- 
1.7.1

