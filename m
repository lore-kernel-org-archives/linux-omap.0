From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH 2/6] ARM: OMAP5: hwmod: set DSS submodule parent hwmods
Date: Thu, 9 Oct 2014 17:03:15 +0300
Message-ID: <1412863399-9508-3-git-send-email-tomi.valkeinen@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48941 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbaJIODe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2014 10:03:34 -0400
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Set DSS core hwmod as the parent for all the DSS submodules.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 1103aa0e0d29..229c7fb7e1c3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -421,6 +421,7 @@ static struct omap_hwmod omap54xx_dss_dispc_hwmod = {
 	.opt_clks	= dss_dispc_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.dev_attr	= &dss_dispc_dev_attr,
+	.parent_hwmod	= &omap54xx_dss_hwmod,
 };
 
 /*
@@ -462,6 +463,7 @@ static struct omap_hwmod omap54xx_dss_dsi1_a_hwmod = {
 	},
 	.opt_clks	= dss_dsi1_a_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_a_opt_clks),
+	.parent_hwmod	= &omap54xx_dss_hwmod,
 };
 
 /* dss_dsi1_c */
@@ -482,6 +484,7 @@ static struct omap_hwmod omap54xx_dss_dsi1_c_hwmod = {
 	},
 	.opt_clks	= dss_dsi1_c_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_c_opt_clks),
+	.parent_hwmod	= &omap54xx_dss_hwmod,
 };
 
 /*
@@ -521,6 +524,7 @@ static struct omap_hwmod omap54xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &omap54xx_dss_hwmod,
 };
 
 /*
@@ -560,6 +564,7 @@ static struct omap_hwmod omap54xx_dss_rfbi_hwmod = {
 	},
 	.opt_clks	= dss_rfbi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
+	.parent_hwmod	= &omap54xx_dss_hwmod,
 };
 
 /*
-- 
2.1.1

