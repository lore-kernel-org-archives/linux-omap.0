From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 13/39] ARM: OMAP3: hwmod data: add gpmc
Date: Tue, 1 May 2012 17:51:08 +0530
Message-ID: <1d1a0ae293834061a15f1b19f903b81bfa01befc.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43540 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756326Ab2EAMiP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:38:15 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Add gpmc hwmod and associated interconnect data

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0c65079..4da8394 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1981,6 +1981,40 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 };
 
 /*
+ * 'gpmc' class
+ * general purpose memory controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_gpmc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_gpmc_hwmod_class = {
+	.name	= "gpmc",
+	.sysc	= &omap3xxx_gpmc_sysc,
+};
+
+static struct omap_hwmod_irq_info omap3xxx_gpmc_irqs[] = {
+	{ .irq = 20 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap3xxx_gpmc_hwmod = {
+	.name		= "gpmc",
+	.class		= &omap3xxx_gpmc_hwmod_class,
+	.clkdm_name	= "l3_init_clkdm",
+	.mpu_irqs	= omap3xxx_gpmc_irqs,
+	.main_clk	= "gpmc_fck",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+};
+
+/*
  * interfaces
  */
 
@@ -3059,6 +3093,23 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_tll_hs = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap3xxx_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x6E000000,
+		.pa_end		= 0x6E000FFF,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__gpmc = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_gpmc_hwmod,
+	.clk		= "core_l3_ick",
+	.addr		= omap3xxx_gpmc_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
@@ -3103,6 +3154,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap34xx_l4_core__mcspi2,
 	&omap34xx_l4_core__mcspi3,
 	&omap34xx_l4_core__mcspi4,
+	&omap3xxx_l3_main__gpmc,
 	NULL,
 };
 
-- 
1.7.10

