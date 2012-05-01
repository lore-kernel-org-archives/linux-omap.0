From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 14/39] ARM: OMAP2xxx: hwmod data: add gpmc
Date: Tue, 1 May 2012 17:51:14 +0530
Message-ID: <3a2e4c8f26e4a0c5e4139f4530c021d2a43a07ca.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43546 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756326Ab2EAMiU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:38:20 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Add gpmc hwmod and associated interconnect data

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   18 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   41 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 5 files changed, 80 insertions(+)

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
index 45aaa07..e75da40 100644
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
 
@@ -732,3 +752,24 @@ struct omap_hwmod omap2xxx_mcspi2_hwmod = {
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
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.prcm		= {
+		.omap2	= {
+			.prcm_reg_id = 3,
+			.module_bit = OMAP24XX_EN_GPMC_MASK,
+			.module_offs = CORE_MOD,
+		},
+	},
+};
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

