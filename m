From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] ARM: OMAP2/3: hwmod data: add gpmc
Date: Tue, 8 May 2012 18:19:42 +0530
Message-ID: <1336481382-28583-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37943 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843Ab2EHNGW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 09:06:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Add gpmc hwmod and associated interconnect data

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Hi Paul,

This is patch 13/39 & 14/39 of v4 OMAP GPMC driver conversion
series modified and squashed into one.

Regards
Afzal

 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   18 ++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 ++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   47 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   58 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 6 files changed, 144 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2c087ff..55c8c7b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -428,6 +428,23 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap2420_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x6800A000,
+		.pa_end		= 0x6800AFFF,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
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
@@ -468,6 +485,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__mailbox,
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
+	&omap2420_l3__gpmc,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 71d9f88..dd224cca 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -838,6 +838,23 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap2430_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x6E000000,
+		.pa_end		= 0x6E000FFF,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
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
@@ -886,6 +903,7 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2430_l4_core__mcbsp3,
 	&omap2430_l4_core__mcbsp4,
 	&omap2430_l4_core__mcbsp5,
+	&omap2430_l3__gpmc,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 45aaa07..091ea65 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -175,6 +175,26 @@ struct omap_hwmod_class omap2xxx_mcspi_class = {
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
 
@@ -732,3 +752,30 @@ struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi2_dev_attr,
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
+	/* HWMOD_INIT_NO_RESET can be removed once kernel is updated
+	 * to configure GPMC for all peripherals, right now many
+	 * peripherals depend on bootloader configuration, removing
+	 * this flag would break GPMC on many boards
+	 */
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_NO_IDLEST |
+				HWMOD_INIT_NO_RESET,
+	.prcm		= {
+		.omap2	= {
+			.prcm_reg_id = 3,
+			.module_bit = OMAP24XX_EN_GPMC_MASK,
+			.module_offs = CORE_MOD,
+		},
+	},
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0c65079..19ac1d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1981,6 +1981,46 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
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
+	/* HWMOD_INIT_NO_RESET can be removed once kernel is updated
+	 * to configure GPMC for all peripherals, right now many
+	 * peripherals depend on bootloader configuration, removing
+	 * this flag would break GPMC on many boards
+	 */
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_NO_IDLEST |
+				HWMOD_INIT_NO_RESET,
+};
+
+/*
  * interfaces
  */
 
@@ -3059,6 +3099,23 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_tll_hs = {
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
@@ -3103,6 +3160,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap34xx_l4_core__mcspi2,
 	&omap34xx_l4_core__mcspi3,
 	&omap34xx_l4_core__mcspi4,
+	&omap3xxx_l3_main__gpmc,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 7aa9156..63e0134 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -74,6 +74,7 @@ extern struct omap_hwmod omap2xxx_gpio3_hwmod;
 extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
+extern struct omap_hwmod omap2xxx_gpmc_hwmod;
 
 /* Common interface data across OMAP2xxx */
 extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 5aa5435..48c722a 100644
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
1.7.10

