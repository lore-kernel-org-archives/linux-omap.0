From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 2/3] ARM: OMAP2+: hwmod data: Add 32k-sync timer data to hwmod database
Date: Fri, 30 Mar 2012 19:24:14 +0530
Message-ID: <1333115655-28530-3-git-send-email-hvaibhav@ti.com>
References: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45653 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760801Ab2C3OF3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 10:05:29 -0400
In-Reply-To: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tom.leiming@gmail.com, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>

Add 32k-sync timer hwmod data to omap2 & 3 hwmod table
and also enable existing hwmod data for omap4 (was disabled before).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   53 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 4 files changed, 157 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a5409ce..2091a5c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -54,6 +54,7 @@ static struct omap_hwmod omap2420_gpio4_hwmod;
 static struct omap_hwmod omap2420_dma_system_hwmod;
 static struct omap_hwmod omap2420_mcspi1_hwmod;
 static struct omap_hwmod omap2420_mcspi2_hwmod;
+static struct omap_hwmod omap2420_counter_32k_hwmod;

 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
@@ -1513,6 +1514,55 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mcbsp2_slaves),
 };

+/*
+ * '32K sync counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+static struct omap_hwmod_class omap2420_counter_hwmod_class = {
+	.name = "counter",
+};
+
+/* counter_32k */
+static struct omap_hwmod_addr_space omap2420_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48004000,
+		.pa_end		= 0x48004000 + SZ_4K,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__counter_32k = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_counter_32k_hwmod,
+	.clk		= "l4_ck",
+	.addr		= omap2420_counter_32k_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap2420_counter_32k_slaves[] = {
+	&omap2420_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap2420_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap2420_counter_hwmod_class,
+	.main_clk	= "sync_32k_ick",
+	.prcm = {
+		.omap2	= {
+			.module_offs		= WKUP_MOD,
+			.prcm_reg_id		= 1,
+			.module_bit		= OMAP24XX_ST_32KSYNC_SHIFT,
+			.idlest_reg_id		= 1,
+			.idlest_idle_bit	= OMAP24XX_ST_32KSYNC_SHIFT,
+		},
+	},
+	.slaves		= omap2420_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_counter_32k_slaves),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -1565,6 +1615,9 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	/* mcspi class */
 	&omap2420_mcspi1_hwmod,
 	&omap2420_mcspi2_hwmod,
+
+	/* 32k sync timer */
+	&omap2420_counter_32k_hwmod,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c4f56cb..f7cc4bb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -64,6 +64,7 @@ static struct omap_hwmod omap2430_mcspi2_hwmod;
 static struct omap_hwmod omap2430_mcspi3_hwmod;
 static struct omap_hwmod omap2430_mmc1_hwmod;
 static struct omap_hwmod omap2430_mmc2_hwmod;
+static struct omap_hwmod omap2430_counter_32k_hwmod;

 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
@@ -2001,6 +2002,55 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.class		= &omap2430_mmc_class,
 };

+/*
+ * '32K sync counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+static struct omap_hwmod_class omap2430_counter_hwmod_class = {
+	.name = "counter",
+};
+
+/* counter_32k */
+static struct omap_hwmod_addr_space omap2430_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x49020000,
+		.pa_end		= 0x49020000 + SZ_4K,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__counter_32k = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_counter_32k_hwmod,
+	.clk		= "l4_ck",
+	.addr		= omap2430_counter_32k_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap2430_counter_32k_slaves[] = {
+	&omap2430_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap2430_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap2430_counter_hwmod_class,
+	.main_clk	= "sync_32k_ick",
+	.prcm		= {
+		.omap2	= {
+			.module_offs		= WKUP_MOD,
+			.prcm_reg_id		= 1,
+			.module_bit		= OMAP24XX_ST_32KSYNC_SHIFT,
+			.idlest_reg_id		= 1,
+			.idlest_idle_bit	= OMAP24XX_ST_32KSYNC_SHIFT,
+		},
+	},
+	.slaves		= omap2430_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_counter_32k_slaves),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -2064,6 +2114,8 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	/* usbotg class*/
 	&omap2430_usbhsotg_hwmod,

+	/* 32k sync timer */
+	&omap2430_counter_32k_hwmod,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3c8dd92..54738b0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -86,6 +86,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
 static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
 static struct omap_hwmod omap3xxx_usb_host_hs_hwmod;
 static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod;
+static struct omap_hwmod omap3xxx_counter_32k_hwmod;

 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -3520,6 +3521,55 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_usb_tll_hs_slaves),
 };

+/*
+ * '32K sync counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+static struct omap_hwmod_class omap3xxx_counter_hwmod_class = {
+	.name = "counter",
+};
+
+/* counter_32k */
+static struct omap_hwmod_addr_space omap3xxx_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48320000,
+		.pa_end		= 0x48320000 + SZ_4K,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__counter_32k = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_counter_32k_hwmod,
+	.clk		= "wkup_l4_ick",
+	.addr		= omap3xxx_counter_32k_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_counter_32k_slaves[] = {
+	&omap3xxx_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap3xxx_counter_hwmod_class,
+	.main_clk	= "omap_32ksync_ick",
+	.prcm		= {
+		.omap2	= {
+			.module_offs		= WKUP_MOD,
+			.prcm_reg_id		= 1,
+			.module_bit		= OMAP3430_ST_32KSYNC_SHIFT,
+			.idlest_reg_id		= 1,
+			.idlest_idle_bit	= OMAP3430_ST_32KSYNC_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_counter_32k_slaves),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -3577,6 +3627,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap34xx_mcspi3,
 	&omap34xx_mcspi4,

+	&omap3xxx_counter_32k_hwmod,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ef0524c..090bd59 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5512,7 +5512,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_bandgap_hwmod,

 	/* counter class */
-/*	&omap44xx_counter_32k_hwmod, */
+	&omap44xx_counter_32k_hwmod,

 	/* dma class */
 	&omap44xx_dma_system_hwmod,
--
1.7.0.4

