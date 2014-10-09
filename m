From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH 3/6] ARM: OMAP4: hwmod: set DSS submodule parent hwmods
Date: Thu, 9 Oct 2014 17:03:16 +0300
Message-ID: <1412863399-9508-4-git-send-email-tomi.valkeinen@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbaJIODg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2014 10:03:36 -0400
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Set DSS core hwmod as the parent for all the DSS submodules.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 44e5634bba34..df8dc0f6530f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -647,7 +647,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.dev_attr	= &omap44xx_dss_dispc_dev_attr
+	.dev_attr	= &omap44xx_dss_dispc_dev_attr,
+	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
 /*
@@ -701,6 +702,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	},
 	.opt_clks	= dss_dsi1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
+	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
 /* dss_dsi2 */
@@ -733,6 +735,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	},
 	.opt_clks	= dss_dsi2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi2_opt_clks),
+	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
 /*
@@ -790,6 +793,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
 /*
@@ -836,6 +840,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	},
 	.opt_clks	= dss_rfbi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
+	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
 /*
@@ -859,6 +864,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
+	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
 /*
-- 
2.1.1

