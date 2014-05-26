From: Archit Taneja <archit@ti.com>
Subject: [RFC 2/2] ARM: OMAP5: hwmod data: Make DSS hwmods share MODULEMODE fields
Date: Mon, 26 May 2014 16:14:55 +0530
Message-ID: <1401101095-27181-2-git-send-email-archit@ti.com>
References: <alpine.DEB.2.02.1405141939030.21921@utopia.booyaka.com>
 <1401101095-27181-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbaEZKqO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 May 2014 06:46:14 -0400
In-Reply-To: <1401101095-27181-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This is an example which shows how to use new 'shared modulemode' flag.

DSS hwmods share the MODULEMODE field. Add the new HWMOD_OMAP4_MODULEMODE_SHARED
flag, and create a modulemode_shared struct which the DSS hwmods refer to.

This will allow the hwmods to reset properly during boot, and not break things
when the DSS driver runs.

(Note: hdmi and rfbi hwmods still don't reset properly as they don't have their
mainclks as dss_dss_clk, this will be fixed later).

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 46 +++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index e8bdd7a..762d61f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -337,6 +337,9 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
  * 'dss' class
  * display sub-system
  */
+
+static struct modulemode_shared dss_modulemode_ref;
+
 static struct omap_hwmod_class_sysconfig omap54xx_dss_sysc = {
 	.rev_offs	= 0x0000,
 	.syss_offs	= 0x0014,
@@ -364,9 +367,11 @@ static struct omap_hwmod omap54xx_dss_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_DSS_DSS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs	= OMAP54XX_RM_DSS_DSS_CONTEXT_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.flags		= HWMOD_OMAP4_MODULEMODE_SHARED,
+			.modulemode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -414,8 +419,11 @@ static struct omap_hwmod omap54xx_dss_dispc_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT |
+					  HWMOD_OMAP4_MODULEMODE_SHARED,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.modulemode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_dispc_opt_clks,
@@ -456,8 +464,11 @@ static struct omap_hwmod omap54xx_dss_dsi1_a_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT |
+					  HWMOD_OMAP4_MODULEMODE_SHARED,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.modulemode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_dsi1_a_opt_clks,
@@ -476,8 +487,11 @@ static struct omap_hwmod omap54xx_dss_dsi1_c_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT |
+					  HWMOD_OMAP4_MODULEMODE_SHARED,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.modulemode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_dsi1_c_opt_clks,
@@ -515,8 +529,11 @@ static struct omap_hwmod omap54xx_dss_hdmi_hwmod = {
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT |
+					  HWMOD_OMAP4_MODULEMODE_SHARED,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.modulemode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
@@ -554,8 +571,11 @@ static struct omap_hwmod omap54xx_dss_rfbi_hwmod = {
 	.clkdm_name	= "dss_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT |
+					  HWMOD_OMAP4_MODULEMODE_SHARED,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.modulemode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_rfbi_opt_clks,
-- 
1.8.3.2

