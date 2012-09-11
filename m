From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v9 1/3] ARM: OMAP2/3: hwmod data: add gpmc
Date: Tue, 11 Sep 2012 15:26:53 +0530
Message-ID: <eb0761d198e52ea7d39d201702e1eff84c511396.1347355380.git.afzal@ti.com>
References: <cover.1347355380.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51740 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab2IKJ5D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 05:57:03 -0400
In-Reply-To: <cover.1347355380.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Add gpmc hwmod and associated interconnect data

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   18 +++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 +++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   44 ++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 6 files changed, 136 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 4e81637..5fcd225 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -535,6 +535,15 @@ static struct omap_hwmod_addr_space omap2420_counter_32k_addrs[] = {
 	{ }
 };
 
+static struct omap_hwmod_addr_space omap2420_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x6800a000,
+		.pa_end		= 0x6800afff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__counter_32k = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_counter_32k_hwmod,
@@ -543,6 +552,14 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if omap2420_l3__gpmc = {
+	.master		= &omap2xxx_l3_main_hwmod,
+	.slave		= &omap2xxx_gpmc_hwmod,
+	.clk		= "core_l3_ck",
+	.addr		= omap2420_gpmc_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2xxx_l3_main__l4_core,
 	&omap2xxx_mpu__l3_main,
@@ -586,6 +603,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__msdi1,
 	&omap2420_l4_core__hdq1w,
 	&omap2420_l4_wkup__counter_32k,
+	&omap2420_l3__gpmc,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index ceb23c3..a560563 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -887,6 +887,15 @@ static struct omap_hwmod_addr_space omap2430_counter_32k_addrs[] = {
 	{ }
 };
 
+static struct omap_hwmod_addr_space omap2430_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x6e000000,
+		.pa_end		= 0x6e000fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__counter_32k = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_counter_32k_hwmod,
@@ -895,6 +904,14 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if omap2430_l3__gpmc = {
+	.master		= &omap2xxx_l3_main_hwmod,
+	.slave		= &omap2xxx_gpmc_hwmod,
+	.clk		= "core_l3_ck",
+	.addr		= omap2430_gpmc_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2xxx_l3_main__l4_core,
 	&omap2xxx_mpu__l3_main,
@@ -945,6 +962,7 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2430_l4_core__mcbsp5,
 	&omap2430_l4_core__hdq1w,
 	&omap2430_l4_wkup__counter_32k,
+	&omap2430_l3__gpmc,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index ceb3052..d848c7a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -173,6 +173,26 @@ struct omap_hwmod_class omap2xxx_mcspi_class = {
 };
 
 /*
+ * 'gpmc' class
+ * general purpose memory controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap2xxx_gpmc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2xxx_gpmc_hwmod_class = {
+	.name	= "gpmc",
+	.sysc	= &omap2xxx_gpmc_sysc,
+};
+
+/*
  * IP blocks
  */
 
@@ -724,7 +744,6 @@ struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 	.dev_attr	= &omap_mcspi2_dev_attr,
 };
 
-
 static struct omap_hwmod_class omap2xxx_counter_hwmod_class = {
 	.name	= "counter",
 };
@@ -743,3 +762,26 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod = {
 	},
 	.class		= &omap2xxx_counter_hwmod_class,
 };
+
+/* gpmc */
+static struct omap_hwmod_irq_info omap2xxx_gpmc_irqs[] = {
+	{ .irq = 20 },
+	{ .irq = -1 }
+};
+
+struct omap_hwmod omap2xxx_gpmc_hwmod = {
+	.name		= "gpmc",
+	.class		= &omap2xxx_gpmc_hwmod_class,
+	.mpu_irqs	= omap2xxx_gpmc_irqs,
+	.main_clk	= "gpmc_fck",
+	.flags		= HWMOD_INIT_NO_IDLE |
+				HWMOD_INIT_NO_RESET |
+				HWMOD_NO_IDLEST,
+	.prcm		= {
+		.omap2	= {
+			.prcm_reg_id = 3,
+			.module_bit = OMAP24XX_EN_GPMC_MASK,
+			.module_offs = CORE_MOD,
+		},
+	},
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 75fbbac..12f0491 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2059,6 +2059,42 @@ static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
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
+	.clkdm_name	= "core_l3_clkdm",
+	.mpu_irqs	= omap3xxx_gpmc_irqs,
+	.main_clk	= "gpmc_fck",
+	.flags		= HWMOD_INIT_NO_IDLE |
+				HWMOD_INIT_NO_RESET |
+				HWMOD_NO_IDLEST,
+};
+
+/*
  * interfaces
  */
 
@@ -3159,6 +3195,15 @@ static struct omap_hwmod_addr_space omap3xxx_counter_32k_addrs[] = {
 	{ }
 };
 
+static struct omap_hwmod_addr_space omap3xxx_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x6e000000,
+		.pa_end		= 0x6e000fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
 static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__counter_32k = {
 	.master		= &omap3xxx_l4_wkup_hwmod,
 	.slave		= &omap3xxx_counter_32k_hwmod,
@@ -3268,6 +3313,14 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__emac = {
 	.user		= OCP_USER_MPU,
 };
 
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
@@ -3313,6 +3366,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap34xx_l4_core__mcspi3,
 	&omap34xx_l4_core__mcspi4,
 	&omap3xxx_l4_wkup__counter_32k,
+	&omap3xxx_l3_main__gpmc,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index dddb677..6a033b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -77,6 +77,7 @@ extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
 extern struct omap_hwmod omap2xxx_counter_32k_hwmod;
+extern struct omap_hwmod omap2xxx_gpmc_hwmod;
 
 /* Common interface data across OMAP2xxx */
 extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index e5f0503..72df974 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -109,6 +109,8 @@
 #define OMAP2430_EN_MDM_INTC_MASK			(1 << 11)
 #define OMAP2430_EN_USBHS_SHIFT				6
 #define OMAP2430_EN_USBHS_MASK				(1 << 6)
+#define OMAP24XX_EN_GPMC_SHIFT				1
+#define OMAP24XX_EN_GPMC_MASK				(1 << 1)
 
 /* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
 #define OMAP2420_ST_MMC_SHIFT				26
-- 
1.7.0.4

