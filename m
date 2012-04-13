From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4: DSS hwmods: Add OCPIF_SWSUP_IDLE to all DSS L3 slave interfaces
Date: Fri, 13 Apr 2012 13:31:56 +0530
Message-ID: <1334304116-18872-3-git-send-email-archit@ti.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188Ab2DMICp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 04:02:45 -0400
In-Reply-To: <1334304116-18872-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

The clock for all DSS L3 slave interfaces had been recently changed to
"dss_fck" from "l3_div_ck". "dss_fck" is an optional clock in DSS clock domain
which can't autoidle when enabled.

Add OCPIF_SWSUP_IDLE flag to all the L3 slave interfaces used by DSS hwmods so
that clock is explicitly enabled and disabled by software. Without this,
"dss_fck" would be left as enabled and the OMAP4 device won't idle even when
DSS is not in use.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index cc9bd10..f928347 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1216,6 +1216,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -1319,6 +1320,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
 	.slave		= &omap44xx_dss_dispc_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dispc_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -1417,6 +1419,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
 	.slave		= &omap44xx_dss_dsi1_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dsi1_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -1494,6 +1497,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dsi2_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -1591,6 +1595,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 	.slave		= &omap44xx_dss_hdmi_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_hdmi_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -1683,6 +1688,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
 	.slave		= &omap44xx_dss_rfbi_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_rfbi_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -1758,6 +1764,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
 	.slave		= &omap44xx_dss_venc_hwmod,
 	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_venc_dma_addrs,
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_SDMA,
 };
 
-- 
1.7.5.4

