From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 19/28] OMAP4: HWMOD: change DSS main_clk scheme
Date: Thu,  9 Jun 2011 16:56:41 +0300
Message-ID: <1307627810-3768-20-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:38519 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758122Ab1FIN5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:45 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently using pm_runtime with DSS requires the DSS driver to enable
the DSS functional clock before calling pm_runtime_get(). That makes it
impossible to use pm_runtime in DSS as it is meant to be used, with
pm_runtime callbacks.

This patch changes the hwmod database for OMAP4 so that enabling the
hwmod via pm_runtime will also enable the DSS functional clock, allowing
us to use pm_runtime properly in DSS driver.

The DSS HWMOD side is not really correct, not before nor after this
patch, and getting DSS to retention will probably not work currently.
However, it is not supported in the mainline kernel anyway, so this
won't break anything.

So this patch allows us to write the pm_runtime adaptation for the DSS
driver the way it should be done, and the HWMOD/PM side can be fixed
later.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4f6ae94..857bdda 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1133,7 +1133,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1173,7 +1173,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 static struct omap_hwmod omap44xx_dss_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap44xx_dss_hwmod_class,
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1233,7 +1233,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dispc_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1282,7 +1282,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_irqs),
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1338,7 +1338,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dsi1_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1380,7 +1380,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_irqs),
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1415,7 +1415,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dsi2_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1452,7 +1452,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_irqs),
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1505,7 +1505,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_hdmi_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1547,7 +1547,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_irqs),
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1598,7 +1598,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_rfbi_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1637,7 +1637,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1673,7 +1673,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_venc_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_venc_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1710,7 +1710,7 @@ static struct omap_hwmod_opt_clk venc_opt_clks[] = {
 static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
-- 
1.7.4.1

