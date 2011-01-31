From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 03/13] OMAP2420: hwmod data: Add McBSP
Date: Mon, 31 Jan 2011 20:20:27 +0530
Message-ID: <1296485437-12806-4-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1AaOzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 09:55:20 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

From: Charulatha V <charu@ti.com>

Add McBSP hwmod data for OMAP2420.

Also add macros in prcm-common.h for idlest bit of OMAP24XX McBSP devices

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  167 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    4 +
 2 files changed, 171 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b85c630..6c8b6ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -87,6 +87,8 @@ static struct omap_hwmod omap2420_uart2_hwmod;
 static struct omap_hwmod omap2420_uart3_hwmod;
 static struct omap_hwmod omap2420_i2c1_hwmod;
 static struct omap_hwmod omap2420_i2c2_hwmod;
+static struct omap_hwmod omap2420_mcbsp1_hwmod;
+static struct omap_hwmod omap2420_mcbsp2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
@@ -864,6 +866,167 @@ static struct omap_hwmod omap2420_dma_system_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/*
+ * 'mcbsp' class
+ * multi channel buffered serial port controller
+ */
+
+static struct omap_hwmod_class omap2420_mcbsp_hwmod_class = {
+	.name = "mcbsp",
+};
+
+/* mcbsp1 */
+static struct omap_hwmod_irq_info omap2420_mcbsp1_irqs[] = {
+	{ .name = "tx", .irq = 59 },
+	{ .name = "rx", .irq = 60 },
+};
+
+static struct omap_hwmod_dma_info omap2420_mcbsp1_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 32 },
+	{ .name = "tx", .dma_req = 31 },
+};
+
+static struct omap_hwmod_addr_space omap2420_mcbsp1_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x48074000,
+		.pa_end		= 0x480740ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> mcbsp1 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mcbsp1_hwmod,
+	.clk		= "mcbsp1_ick",
+	.addr		= omap2420_mcbsp1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mcbsp1_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap2420_mcbsp1_dma_addrs[] = {
+	{
+		.name           = "dma",
+		.pa_start       = 0x48074000,
+		.pa_end         = 0x480740ff,
+		.flags          = ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1_dma = {
+	.master         = &omap2420_l4_core_hwmod,
+	.slave          = &omap2420_mcbsp1_hwmod,
+	.clk            = "mcbsp1_ick",
+	.addr           = omap2420_mcbsp1_dma_addrs,
+	.addr_cnt       = ARRAY_SIZE(omap2420_mcbsp1_dma_addrs),
+	.user           = OCP_USER_SDMA,
+};
+
+/* mcbsp1 slave ports */
+static struct omap_hwmod_ocp_if *omap2420_mcbsp1_slaves[] = {
+	&omap2420_l4_core__mcbsp1,
+	&omap2420_l4_core__mcbsp1_dma,
+};
+
+static struct omap_hwmod omap2420_mcbsp1_hwmod = {
+	.name		= "mcbsp1",
+	.class		= &omap2420_mcbsp_hwmod_class,
+	.mpu_irqs	= omap2420_mcbsp1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mcbsp1_irqs),
+	.sdma_reqs	= omap2420_mcbsp1_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcbsp1_sdma_chs),
+	.main_clk	= "mcbsp1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MCBSP1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mcbsp1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mcbsp1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* mcbsp2 */
+static struct omap_hwmod_irq_info omap2420_mcbsp2_irqs[] = {
+	{ .name = "tx", .irq = 62 },
+	{ .name = "rx", .irq = 63 },
+};
+
+static struct omap_hwmod_dma_info omap2420_mcbsp2_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 34 },
+	{ .name = "tx", .dma_req = 33 },
+};
+
+static struct omap_hwmod_addr_space omap2420_mcbsp2_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x48076000,
+		.pa_end		= 0x480760ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> mcbsp2 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mcbsp2_hwmod,
+	.clk		= "mcbsp2_ick",
+	.addr		= omap2420_mcbsp2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mcbsp2_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap2420_mcbsp2_dma_addrs[] = {
+	{
+		.name           = "dma",
+		.pa_start       = 0x48076000,
+		.pa_end         = 0x480760ff,
+		.flags          = ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2_dma = {
+	.master         = &omap2420_l4_core_hwmod,
+	.slave          = &omap2420_mcbsp2_hwmod,
+	.clk            = "mcbsp2_ick",
+	.addr           = omap2420_mcbsp2_dma_addrs,
+	.addr_cnt       = ARRAY_SIZE(omap2420_mcbsp2_dma_addrs),
+	.user           = OCP_USER_SDMA,
+};
+
+/* mcbsp2 slave ports */
+static struct omap_hwmod_ocp_if *omap2420_mcbsp2_slaves[] = {
+	&omap2420_l4_core__mcbsp2,
+	&omap2420_l4_core__mcbsp2_dma,
+};
+
+static struct omap_hwmod omap2420_mcbsp2_hwmod = {
+	.name		= "mcbsp2",
+	.class		= &omap2420_mcbsp_hwmod_class,
+	.mpu_irqs	= omap2420_mcbsp2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mcbsp2_irqs),
+	.sdma_reqs	= omap2420_mcbsp2_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcbsp2_sdma_chs),
+	.main_clk	= "mcbsp2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MCBSP2_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mcbsp2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mcbsp2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -885,6 +1048,10 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 
 	/* dma_system class*/
 	&omap2420_dma_system_hwmod,
+
+	/* mcbsp class */
+	&omap2420_mcbsp1_hwmod,
+	&omap2420_mcbsp2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 87486f5..d4af21d 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -121,6 +121,10 @@
 #define OMAP24XX_ST_MCSPI2_MASK				(1 << 18)
 #define OMAP24XX_ST_MCSPI1_SHIFT			17
 #define OMAP24XX_ST_MCSPI1_MASK				(1 << 17)
+#define OMAP24XX_ST_MCBSP2_SHIFT			16
+#define OMAP24XX_ST_MCBSP2_MASK				(1 << 16)
+#define OMAP24XX_ST_MCBSP1_SHIFT			15
+#define OMAP24XX_ST_MCBSP1_MASK				(1 << 15)
 #define OMAP24XX_ST_GPT12_SHIFT				14
 #define OMAP24XX_ST_GPT12_MASK				(1 << 14)
 #define OMAP24XX_ST_GPT11_SHIFT				13
-- 
1.7.0.4

