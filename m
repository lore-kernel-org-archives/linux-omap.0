From: <hvaibhav@ti.com>
Subject: [RFC PATCH 2/3] ARM: AM33XX: hwmod: Add hwmod data for debugSS
Date: Mon, 4 Mar 2013 17:05:56 +0530
Message-ID: <1362396957-30113-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55498 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266Ab3CDLgk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 06:36:40 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@linaro.org, paul@pwsan.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

In the original hwmod data file, DebugSS entry was disabled,
since we didn't (and do not) have SW to control it.

This patch enables it back with right data, as now we will
have control through command line argument "omap_debugss_en".

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   69 +++++++++++++++++++---------
 1 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 50da58c..e2a0ed0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -415,7 +415,6 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
  *
  *    - cEFUSE (doesn't fall under any ocp_if)
  *    - clkdiv32k
- *    - debugss
  *    - ocmc ram
  *    - ocp watch point
  *    - aes0
@@ -462,27 +461,6 @@ static struct omap_hwmod am33xx_clkdiv32k_hwmod = {
 	},
 };

-/*
- * 'debugss' class
- * debug sub system
- */
-static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
-	.name		= "debugss",
-};
-
-static struct omap_hwmod am33xx_debugss_hwmod = {
-	.name		= "debugss",
-	.class		= &am33xx_debugss_hwmod_class,
-	.clkdm_name	= "l3_aon_clkdm",
-	.main_clk	= "debugss_ick",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /* ocmcram */
 static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
 	.name = "ocmcram",
@@ -572,6 +550,34 @@ static struct omap_hwmod am33xx_sha0_hwmod = {

 #endif

+/*
+ * 'debugss' class
+ * debug sub system
+ */
+static struct omap_hwmod_opt_clk debugss_opt_clks[] = {
+	{ .role = "dbg_sysclk", .clk = "dbg_sysclk_ck" },
+	{ .role = "dbg_clka", .clk = "dbg_clka_ck" },
+};
+
+static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
+	.name		= "debugss",
+};
+
+static struct omap_hwmod am33xx_debugss_hwmod = {
+	.name		= "debugss",
+	.class		= &am33xx_debugss_hwmod_class,
+	.clkdm_name	= "l3_aon_clkdm",
+	.main_clk	= "trace_clk_div_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= debugss_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(debugss_opt_clks),
+};
+
 /* 'smartreflex' class */
 static struct omap_hwmod_class am33xx_smartreflex_hwmod_class = {
 	.name		= "smartreflex",
@@ -2291,6 +2297,24 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* l3_main -> debugss */
+static struct omap_hwmod_addr_space am33xx_debugss_addrs[] = {
+	{
+		.pa_start	= 0x4b000000,
+		.pa_end		= 0x4b000000 + SZ_16M - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if am33xx_l3_main__debugss = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_debugss_hwmod,
+	.clk		= "dpll_core_m4_ck",
+	.addr		= am33xx_debugss_addrs,
+	.user		= OCP_USER_MPU,
+};
+
 /* l4 wkup -> smartreflex0 */
 static struct omap_hwmod_addr_space am33xx_smartreflex0_addrs[] = {
 	{
@@ -3360,6 +3384,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_pruss__l3_main,
 	&am33xx_wkup_m3__l4_wkup,
 	&am33xx_gfx__l3_main,
+	&am33xx_l3_main__debugss,
 	&am33xx_l4_wkup__wkup_m3,
 	&am33xx_l4_wkup__control,
 	&am33xx_l4_wkup__smartreflex0,
--
1.7.0.4

