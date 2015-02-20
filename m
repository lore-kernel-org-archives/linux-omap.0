From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] ARM: DRA7: hwmod_data: Fix hwmod data for pcie
Date: Fri, 20 Feb 2015 14:21:13 +0530
Message-ID: <1424422274-27946-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52602 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbbBTIvw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2015 03:51:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com
Cc: linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com, kishon@ti.com, Grygorii Strashko <Grygorii.Strashko@linaro.org>

Fixed hwmod data for pcie by having the correct module mode offset.
Previously this module mode offset was part of pcie PHY which was wrong.
Now this module mode offset was moved to pcie hwmod and removed the hwmod data
for pcie phy. While at that renamed pcie_hwmod to pciess_hwmod in order
to match with the name given in TRM.

This helps to get rid of the following warning
"omap_hwmod: pcie1: _wait_target_disable failed"

[Grygorii.Strashko@linaro.org: Found the issue that actually caused
 "omap_hwmod: pcie1: _wait_target_disable failed"]
Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  103 +++++++----------------------
 1 file changed, 24 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index e8692e7..16fe7a1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1466,55 +1466,18 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
  *
  */
 
-static struct omap_hwmod_class dra7xx_pcie_hwmod_class = {
+static struct omap_hwmod_class dra7xx_pciess_hwmod_class = {
 	.name	= "pcie",
 };
 
 /* pcie1 */
-static struct omap_hwmod dra7xx_pcie1_hwmod = {
+static struct omap_hwmod dra7xx_pciess1_hwmod = {
 	.name		= "pcie1",
-	.class		= &dra7xx_pcie_hwmod_class,
+	.class		= &dra7xx_pciess_hwmod_class,
 	.clkdm_name	= "pcie_clkdm",
 	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* pcie2 */
-static struct omap_hwmod dra7xx_pcie2_hwmod = {
-	.name		= "pcie2",
-	.class		= &dra7xx_pcie_hwmod_class,
-	.clkdm_name	= "pcie_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/*
- * 'PCIE PHY' class
- *
- */
-
-static struct omap_hwmod_class dra7xx_pcie_phy_hwmod_class = {
-	.name	= "pcie-phy",
-};
-
-/* pcie1 phy */
-static struct omap_hwmod dra7xx_pcie1_phy_hwmod = {
-	.name		= "pcie1-phy",
-	.class		= &dra7xx_pcie_phy_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_SWCTRL,
@@ -1522,11 +1485,11 @@ static struct omap_hwmod dra7xx_pcie1_phy_hwmod = {
 	},
 };
 
-/* pcie2 phy */
-static struct omap_hwmod dra7xx_pcie2_phy_hwmod = {
-	.name		= "pcie2-phy",
-	.class		= &dra7xx_pcie_phy_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
+/* pcie2 */
+static struct omap_hwmod dra7xx_pciess2_hwmod = {
+	.name		= "pcie2",
+	.class		= &dra7xx_pciess_hwmod_class,
+	.clkdm_name	= "pcie_clkdm",
 	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
@@ -2877,50 +2840,34 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3_main_1 -> pcie1 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pcie1 = {
+/* l3_main_1 -> pciess1 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_pcie1_hwmod,
+	.slave		= &dra7xx_pciess1_hwmod,
 	.clk		= "l3_iclk_div",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> pcie1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1 = {
+/* l4_cfg -> pciess1 */
+static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess1 = {
 	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_pcie1_hwmod,
+	.slave		= &dra7xx_pciess1_hwmod,
 	.clk		= "l4_root_clk_div",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3_main_1 -> pcie2 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pcie2 = {
+/* l3_main_1 -> pciess2 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess2 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_pcie2_hwmod,
+	.slave		= &dra7xx_pciess2_hwmod,
 	.clk		= "l3_iclk_div",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> pcie2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2 = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_pcie2_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> pcie1 phy */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1_phy = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_pcie1_phy_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> pcie2 phy */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2_phy = {
+/* l4_cfg -> pciess2 */
+static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess2 = {
 	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_pcie2_phy_hwmod,
+	.slave		= &dra7xx_pciess2_hwmod,
 	.clk		= "l4_root_clk_div",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -3327,12 +3274,10 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l4_cfg__ocp2scp1,
 	&dra7xx_l4_cfg__ocp2scp3,
-	&dra7xx_l3_main_1__pcie1,
-	&dra7xx_l4_cfg__pcie1,
-	&dra7xx_l3_main_1__pcie2,
-	&dra7xx_l4_cfg__pcie2,
-	&dra7xx_l4_cfg__pcie1_phy,
-	&dra7xx_l4_cfg__pcie2_phy,
+	&dra7xx_l3_main_1__pciess1,
+	&dra7xx_l4_cfg__pciess1,
+	&dra7xx_l3_main_1__pciess2,
+	&dra7xx_l4_cfg__pciess2,
 	&dra7xx_l3_main_1__qspi,
 	&dra7xx_l4_per3__rtcss,
 	&dra7xx_l4_cfg__sata,
-- 
1.7.9.5

