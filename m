From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH 4/6] ARM: OMAP4: hwmod: use MODULEMODE properly
Date: Thu, 9 Oct 2014 17:03:17 +0300
Message-ID: <1412863399-9508-5-git-send-email-tomi.valkeinen@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44058 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535AbaJIODi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2014 10:03:38 -0400
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using a hacky "dss_fck" clock (which toggles the MODULEMODE
bit) as DSS L3 interface clock, set the .modulemode field in the
omap44xx_dss_hwmod. This works now that the DSS core hwmod is enabled
during DSS submodule resets.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index df8dc0f6530f..8126f178d57e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -589,6 +589,7 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -3677,7 +3678,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
@@ -3713,7 +3714,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_dispc_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
@@ -3749,7 +3750,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_dsi1_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
@@ -3785,7 +3786,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_dsi2_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
@@ -3821,7 +3822,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_hdmi_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
@@ -3857,7 +3858,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_rfbi_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
@@ -3893,7 +3894,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
-	.clk		= "dss_fck",
+	.clk		= "l3_div_ck",
 	.addr		= omap44xx_dss_venc_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
-- 
2.1.1

