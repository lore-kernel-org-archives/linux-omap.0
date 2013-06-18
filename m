From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 2/2] ARM: AM33XX: hwmod: Add hwmod data for debugSS
Date: Tue, 18 Jun 2013 10:38:00 +0530
Message-ID: <1371532080-27714-3-git-send-email-hvaibhav@ti.com>
References: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37382 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab3FRFId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 01:08:33 -0400
In-Reply-To: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

In the original hwmod data file, DebugSS entry was disabled,
since we didn't (and do not) have SW to control it.

This patch enables it back with right data, so that it can be
controlled by different ways; and the suggested method it to
have modular driver for debugSS as well.

Refer to the link for more discussion on handling of debugSS -
https://patchwork.kernel.org/patch/2212111/

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   69 +++++++++++++++++++---------
 1 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 075f7cc..2a4bf69 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -416,7 +416,6 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
  *
  *    - cEFUSE (doesn't fall under any ocp_if)
  *    - clkdiv32k
- *    - debugss
  *    - ocp watch point
  */
 #if 0
@@ -460,27 +459,6 @@ static struct omap_hwmod am33xx_clkdiv32k_hwmod = {
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
 /* ocpwp */
 static struct omap_hwmod_class am33xx_ocpwp_hwmod_class = {
 	.name		= "ocpwp",
@@ -598,6 +576,34 @@ static struct omap_hwmod am33xx_ocmcram_hwmod = {
 	},
 };
 
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
@@ -2382,6 +2388,24 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
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
@@ -3533,6 +3557,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_pruss__l3_main,
 	&am33xx_wkup_m3__l4_wkup,
 	&am33xx_gfx__l3_main,
+	&am33xx_l3_main__debugss,
 	&am33xx_l4_wkup__wkup_m3,
 	&am33xx_l4_wkup__control,
 	&am33xx_l4_wkup__smartreflex0,
-- 
1.7.0.4

