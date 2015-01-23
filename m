From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Fri, 23 Jan 2015 17:11:41 -0600
Message-ID: <1422054704-14915-2-git-send-email-balbi@ti.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54501 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbbAWXMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 18:12:14 -0500
In-Reply-To: <1422054704-14915-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Without hwmod data for DebugSS, performance monitors
have no chance of running on AM43xx devices.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  1 +
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 5c6c8410160e..6709704dd5b5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -19,6 +19,7 @@
 #include "omap_hwmod.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 #include "prcm43xx.h"
+#include "prm44xx.h"
 #include "omap_hwmod_common_data.h"
 
 
@@ -60,6 +61,44 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod = {
 	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
 };
 
+/*
+ * 'debugss' class
+ * debug and emulation sub system
+ */
+static struct omap_hwmod_opt_clk am43xx_debugss_opt_clks[] = {
+	{ .role = "dbg_sysclk", .clk = "dbg_sysclk_ck" },
+	{ .role = "dbg_clka", .clk = "dbg_clka_ck", },
+	{ .role = "dbg_clkb", .clk = "dbg_clkb_ck", },
+	{ .role = "dbg_clkc", .clk = "dbg_clkc_ck", },
+};
+
+static struct omap_hwmod_class am43xx_debugss_hwmod_class = {
+	.name	= "debugss",
+};
+
+/* debugss */
+static struct omap_hwmod am43xx_debugss_hwmod = {
+	.name		= "debugss",
+	.class		= &am43xx_debugss_hwmod_class,
+	.clkdm_name	= "l3_aon_clkdm",
+	.main_clk	= "trace_clk_div_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET,
+		},
+	},
+	.opt_clks	= am43xx_debugss_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(am43xx_debugss_opt_clks),
+};
+
+/* debugss -> l3_main_2 */
+static struct omap_hwmod_ocp_if am43xx_debugss__l3_main = {
+	.master		= &am43xx_debugss_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod am43xx_control_hwmod = {
 	.name		= "control",
 	.class		= &am33xx_control_hwmod_class,
@@ -875,6 +914,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__tptc1,
 	&am33xx_l3_main__tptc2,
 	&am33xx_l3_main__ocmc,
+	&am43xx_debugss__l3_main,
 	&am43xx_l4_hs__cpgmac0,
 	&am33xx_cpgmac0__mdio,
 	&am33xx_l3_main__sha0,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index ad7b3e9977f8..bb42cd80526d 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -93,6 +93,7 @@
 #define AM43XX_CM_PER_TIMER5_CLKCTRL_OFFSET		0x0548
 #define AM43XX_CM_PER_TIMER6_CLKCTRL_OFFSET		0x0550
 #define AM43XX_CM_PER_TIMER7_CLKCTRL_OFFSET		0x0558
+#define AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET		0x0020
 #define AM43XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET		0x0228
 #define AM43XX_CM_WKUP_CONTROL_CLKCTRL_OFFSET		0x0360
 #define AM43XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET	0x0350
-- 
2.3.0-rc1

