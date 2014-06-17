From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 2/2] arm: omap5 hwmod data: Example: Make DSS hwmods share MODULEMODE fields
Date: Tue, 17 Jun 2014 15:24:34 +0530
Message-ID: <1402998874-1024-3-git-send-email-archit@ti.com>
References: <1401101095-27181-1-git-send-email-archit@ti.com>
 <1402998874-1024-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44211 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbaFQJ4L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 05:56:11 -0400
In-Reply-To: <1402998874-1024-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DSS hwmods share the MODULEMODE field. Create a new 'mmode_shared' struct which
the DSS hwmods refer to.

This will allow the hwmods to reset properly during boot, and not break things
when the omapdss module is inserted.

(Note: hdmi and rfbi hwmods still don't reset properly as they don't have their
mainclks as dss_dss_clk, this needs to be changed later).

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 40 ++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 290213f..e855cf5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -337,6 +337,9 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
  * 'dss' class
  * display sub-system
  */
+
+static struct mmode_shared dss_modulemode_ref;
+
 static struct omap_hwmod_class_sysconfig omap54xx_dss_sysc = {
 	.rev_offs	= 0x0000,
 	.syss_offs	= 0x0014,
@@ -364,9 +367,10 @@ static struct omap_hwmod omap54xx_dss_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_DSS_DSS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs	= OMAP54XX_RM_DSS_DSS_CONTEXT_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.mmode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -414,8 +418,10 @@ static struct omap_hwmod omap54xx_dss_dispc_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.mmode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_dispc_opt_clks,
@@ -456,8 +462,10 @@ static struct omap_hwmod omap54xx_dss_dsi1_a_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.mmode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_dsi1_a_opt_clks,
@@ -476,8 +484,10 @@ static struct omap_hwmod omap54xx_dss_dsi1_c_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.mmode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_dsi1_c_opt_clks,
@@ -515,8 +525,10 @@ static struct omap_hwmod omap54xx_dss_hdmi_hwmod = {
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.mmode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
@@ -554,8 +566,10 @@ static struct omap_hwmod omap54xx_dss_rfbi_hwmod = {
 	.clkdm_name	= "dss_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.clkctrl_offs	= OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags		= HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.modulemode	= MODULEMODE_SWCTRL,
+			.mmode_ref	= &dss_modulemode_ref,
 		},
 	},
 	.opt_clks	= dss_rfbi_opt_clks,
-- 
1.9.1

