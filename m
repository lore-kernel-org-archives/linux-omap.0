From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 10/19] DSPBRIDGE: function to get the type of clock requested by dsp
Date: Thu,  8 Apr 2010 18:15:59 -0500
Message-ID: <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933792Ab0DHXAN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 19:00:13 -0400
In-Reply-To: <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

DSP can request between 4 types of clocks: GPT (5-8), WDT (3),
MCBSP (1-5) or SSI clock. This function will be useful in case
a specific clock framework is associated with the clock.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   80 ++++++++++++++++++++++++++++---------
 1 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index babf043..6e76dd3 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -43,6 +43,12 @@
 #define SSI_SIDLE_SMARTIDLE		(2 << 3)
 #define SSI_MIDLE_NOIDLE		(1 << 12)
 
+/* Clk types requested by the dsp */
+#define GPT_CLK		0
+#define WDT_CLK		1
+#define MCBSP_CLK	2
+#define SSI_CLK		3
+
 struct dsp_clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
@@ -78,6 +84,24 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, ""}
 };
 
+static s8 get_clk_type(u8 id)
+{
+	s8 type;
+
+	if (id <= DSP_CLK_GPT8_ICK)
+		type = GPT_CLK;
+	else if (id <= DSP_CLK_WDT3_ICK)
+		type = WDT_CLK;
+	else if (id <= DSP_CLK_MCBSP5_ICK)
+		type = MCBSP_CLK;
+	else if (id < DSP_CLK_SSI_ICK)
+		type = SSI_CLK;
+	else
+		type = -1;
+
+	return type;
+}
+
 /*
  *  ======== dsp_clk_exit ========
  *  Purpose:
@@ -143,23 +167,32 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
 
-	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
+	switch (get_clk_type(clk_id)) {
+	case GPT_CLK:
+	case MCBSP_CLK:
+	case WDT_CLK:
+	case SSI_CLK:
+		clk_handle = dsp_clks[clk_id].clk_handle;
+		if (clk_enable(clk_handle)) {
+			pr_err("dsp_clk_enable: failed to Enable CLK %s, "
+				"CLK dev id = %d\n", dsp_clks[clk_id].clk_name,
+				dsp_clks[clk_id].id);
+				status = DSP_EFAIL;
+		}
 
-	clk_handle = dsp_clks[clk_id].clk_handle;
-	if (clk_enable(clk_handle)) {
-		pr_err("dsp_clk_enable: failed to Enable CLK %s, "
-		       "CLK dev id = %d\n",
-		       dsp_clks[clk_id].clk_name,
-		       dsp_clks[clk_id].id);
-		status = DSP_EFAIL;
+		/*
+		 * The SSI module need to configured not to have the Forced
+		 * idle for master interface. If it is set to forced idle,
+		 * the SSI module is transitioning to standby thereby causing
+		 * the client in the DSP hang waiting for the SSI module to
+		 * be active after enabling the clocks
+		 */
+		if (clk_id == DSP_CLK_SSI_ICK)
+			ssi_clk_prepare(true);
+		break;
+	default:
+		dev_err(bridge, "Invalid clock id for enable\n");
 	}
-	/* The SSI module need to configured not to have the Forced idle for
-	 * master interface. If it is set to forced idle, the SSI module is
-	 * transitioning to standby thereby causing the client in the DSP hang
-	 * waiting for the SSI module to be active after enabling the clocks
-	 */
-	if (clk_id == DSP_CLK_SSI_FCK)
-		ssi_clk_prepare(true);
 
 	return status;
 }
@@ -177,12 +210,21 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 
 	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
-	clk_handle = dsp_clks[clk_id].clk_handle;
+	switch (get_clk_type(clk_id)) {
+	case GPT_CLK:
+	case MCBSP_CLK:
+	case WDT_CLK:
+	case SSI_CLK:
+		clk_handle = dsp_clks[clk_id].clk_handle;
 
-	if (clk_id == DSP_CLK_SSI_ICK)
-		ssi_clk_prepare(false);
+		if (clk_id == DSP_CLK_SSI_ICK)
+			ssi_clk_prepare(false);
 
-	clk_disable(clk_handle);
+		clk_disable(clk_handle);
+		break;
+	default:
+		dev_err(bridge, "Invalid clock id for disable\n");
+	}
 
 	return status;
 }
-- 
1.6.2.4

