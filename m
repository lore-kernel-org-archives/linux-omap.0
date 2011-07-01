From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 18/18] OMAP4: hwmod data: Change DSS main_clk scheme
Date: Fri, 1 Jul 2011 22:41:41 +0200
Message-ID: <1309552901-8944-19-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756524Ab1GAUmY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:42:24 -0400
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ce4259d..4bb12b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1134,7 +1134,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1175,7 +1175,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 static struct omap_hwmod omap44xx_dss_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap44xx_dss_hwmod_class,
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1235,7 +1235,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dispc_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1280,7 +1280,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_irqs),
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1336,7 +1336,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dsi1_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1378,7 +1378,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_irqs),
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1413,7 +1413,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_dsi2_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1455,7 +1455,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_irqs),
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1510,7 +1510,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_hdmi_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1552,7 +1552,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_irqs),
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1603,7 +1603,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_rfbi_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1642,7 +1642,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_sdma_reqs),
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
@@ -1678,7 +1678,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
-	.clk		= "l3_div_ck",
+	.clk		= "dss_fck",
 	.addr		= omap44xx_dss_venc_dma_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_venc_dma_addrs),
 	.user		= OCP_USER_SDMA,
@@ -1715,7 +1715,7 @@ static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
 static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
-	.main_clk	= "dss_fck",
+	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
-- 
1.7.0.4

