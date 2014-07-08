From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] arm: dra7xx: Add hwmod data for MDIO and CPSW
Date: Tue,  8 Jul 2014 20:40:50 +0200
Message-ID: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34180 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbaGHSlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 14:41:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Praveen Rao <prao@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: Praveen Rao <prao@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 20b4398..0fa2c66 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1845,6 +1845,85 @@ static struct omap_hwmod dra7xx_vcp2_hwmod = {
 };
 
 /*
+ * 'gmac' class
+ * cpsw/gmac sub system
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_gmac_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x8,
+	.syss_offs	= 0x4,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | MSTANDBY_FORCE |
+			MSTANDBY_NO),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_gmac_hwmod_class = {
+	.name	= "gmac",
+	.sysc	= &dra7xx_gmac_sysc,
+};
+
+static struct omap_hwmod_irq_info dra7xx_gmac_irqs[] = {
+	{ .name = "c0_rx_thresh_pend", .irq = 50 + DRA7XX_IRQ_GIC_START, },
+	{ .name = "c0_rx_pend", .irq = 51 + DRA7XX_IRQ_GIC_START, },
+	{ .name = "c0_tx_pend", .irq = 52 + DRA7XX_IRQ_GIC_START, },
+	{ .name = "c0_misc_pend", .irq = 53 + DRA7XX_IRQ_GIC_START, },
+	{ .irq = -1 },
+};
+static struct omap_hwmod_addr_space dra7xx_gmac_addr_space[] = {
+	/* cpsw ss */
+	{
+		.pa_start	= 0x48484000,
+		.pa_end	= 0x48484000 + SZ_2K - 1,
+	},
+	/* cpsw wr */
+	{
+		.pa_start	= 0x48485200,
+		.pa_end	= 0x48485200 + SZ_256 - 1,
+		.flags	= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+static struct omap_hwmod dra7xx_gmac_hwmod = {
+	.name		= "gmac",
+	.class		= &dra7xx_gmac_hwmod_class,
+	.clkdm_name	= "gmac_clkdm",
+	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
+	.mpu_irqs	= dra7xx_gmac_irqs,
+	.main_clk	= "dpll_gmac_ck",
+	.prcm	= {
+		.omap4	= {
+			.clkctrl_offs	= DRA7XX_CM_GMAC_GMAC_CLKCTRL_OFFSET,
+			.context_offs	= DRA7XX_RM_GMAC_GMAC_CONTEXT_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
+ * 'mdio' class
+ */
+static struct omap_hwmod_class dra7xx_mdio_hwmod_class = {
+	.name	= "davinci_mdio",
+};
+
+static struct omap_hwmod_addr_space dra7xx_mdio_addr_space[] = {
+	{
+		.pa_start	= 0x48485000,
+		.pa_end		= 0x48485000 + SZ_256 - 1,
+	},
+	{ }
+};
+static struct omap_hwmod dra7xx_mdio_hwmod = {
+	.name		= "davinci_mdio",
+	.class		= &dra7xx_mdio_hwmod_class,
+	.clkdm_name	= "gmac_clkdm",
+	.main_clk	= "dpll_gmac_ck",
+};
+
+/*
  * 'wd_timer' class
  *
  */
@@ -2015,6 +2094,21 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__dcan2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__gmac = {
+	.master         = &dra7xx_l4_per2_hwmod,
+	.slave          = &dra7xx_gmac_hwmod,
+	.clk            = "dpll_gmac_ck",
+	.addr           = dra7xx_gmac_addr_space,
+	.user           = OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if dra7xx_gmac__mdio = {
+	.master         = &dra7xx_gmac_hwmod,
+	.slave          = &dra7xx_mdio_hwmod,
+	.addr           = dra7xx_mdio_addr_space,
+	.user           = OCP_USER_MPU,
+};
+
 static struct omap_hwmod_addr_space dra7xx_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x4a056000,
@@ -2642,6 +2736,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__ctrl_module_wkup,
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
+	&dra7xx_l4_per2__gmac,
+	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__dss,
 	&dra7xx_l3_main_1__dispc,
-- 
2.0.1

