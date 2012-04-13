From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 2/3] ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod database
Date: Fri, 13 Apr 2012 15:09:06 +0530
Message-ID: <1334309947-25214-3-git-send-email-hvaibhav@ti.com>
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab2DMJjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 05:39:37 -0400
In-Reply-To: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>

Add 32k-sync timer hwmod-data and add ocp_if details to
omap2 & 3 hwmod table.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
This patch has been updated/migrated from last couple of revisions,
as recently Paul had submitted hwmod clean-up patches, which
changes the hwmod registration mechanism from
omap_hwmod => omap_hwmod_ocp_if.

 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   19 +++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   19 +++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   19 +++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 5 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2c087ff..b961b0d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -428,6 +428,24 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* l4_wkup -> 32ksync_counter */
+static struct omap_hwmod_addr_space omap2420_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48004000,
+		.pa_end		= 0x4800401f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__counter_32k = {
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_counter_32k_hwmod,
+	.clk		= "sync_32k_ick",
+	.addr		= omap2420_counter_32k_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2xxx_l3_main__l4_core,
 	&omap2xxx_mpu__l3_main,
@@ -468,6 +486,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__mailbox,
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
+	&omap2420_l4_wkup__counter_32k,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index b359bfb..c658ccd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -838,6 +838,24 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* l4_wkup -> 32ksync_counter */
+static struct omap_hwmod_addr_space omap2430_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x49020000,
+		.pa_end		= 0x4902001f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__counter_32k = {
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_counter_32k_hwmod,
+	.clk		= "sync_32k_ick",
+	.addr		= omap2430_counter_32k_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2xxx_l3_main__l4_core,
 	&omap2xxx_mpu__l3_main,
@@ -886,6 +904,7 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2430_l4_core__mcbsp3,
 	&omap2430_l4_core__mcbsp4,
 	&omap2430_l4_core__mcbsp5,
+	&omap2430_l4_wkup__counter_32k,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 45aaa07..8c37cb5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -732,3 +732,22 @@ struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi2_dev_attr,
 };
+
+static struct omap_hwmod_class omap2xxx_counter_hwmod_class = {
+	.name	= "counter",
+};
+
+struct omap_hwmod omap2xxx_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.main_clk	= "func_32k_ck",
+	.prcm		= {
+		.omap2	= {
+			.module_offs = WKUP_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_ST_32KSYNC_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_32KSYNC_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_counter_hwmod_class,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e6d944e..b3e4afb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1981,6 +1981,40 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 };

 /*
+ * '32K sync counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+static struct omap_hwmod_class_sysconfig omap3xxx_counter_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_counter_hwmod_class = {
+	.name	= "counter",
+	.sysc	= &omap3xxx_counter_sysc,
+};
+
+static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap3xxx_counter_hwmod_class,
+	.clkdm_name	= "wkup_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.main_clk	= "wkup_32k_fck",
+	.prcm		= {
+		.omap2	= {
+			.module_offs = WKUP_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_ST_32KSYNC_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_32KSYNC_SHIFT,
+		},
+	},
+};
+
+/*
  * interfaces
  */

@@ -3059,6 +3093,25 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_tll_hs = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* l4_wkup -> 32ksync_counter */
+static struct omap_hwmod_addr_space omap3xxx_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48320000,
+		.pa_end		= 0x4832001f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__counter_32k = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_counter_32k_hwmod,
+	.clk		= "omap_32ksync_ick",
+	.addr		= omap3xxx_counter_32k_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+
 static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
@@ -3103,6 +3156,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap34xx_l4_core__mcspi2,
 	&omap34xx_l4_core__mcspi3,
 	&omap34xx_l4_core__mcspi4,
+	&omap3xxx_l4_wkup__counter_32k,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 7aa9156..fd4fc62 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -74,6 +74,7 @@ extern struct omap_hwmod omap2xxx_gpio3_hwmod;
 extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
+extern struct omap_hwmod omap2xxx_counter_32k_hwmod;

 /* Common interface data across OMAP2xxx */
 extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
--
1.7.0.4

