From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 09/19] DSPBRIDGE: function to get the type of clock requested by dsp
Date: Wed, 28 Apr 2010 10:29:47 -0500
Message-ID: <1272468597-6748-10-git-send-email-omar.ramirez@ti.com>
References: <1272468597-6748-1-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-2-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-3-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-4-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-5-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-6-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-7-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-8-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-9-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55476 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab0D1PY7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 11:24:59 -0400
In-Reply-To: <1272468597-6748-9-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

DSP can request between 5 types of clocks: IVA2, GPT (5-8), WDT (3),
MCBSP (1-5) or SSI clock. This function will be useful in case
a specific clock framework is associated with the clock.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   89 ++++++++++++++++++++++++++++---------
 1 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index e35b929..d5c3d4e 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -40,6 +40,13 @@
 #define SSI_SIDLE_SMARTIDLE		(2 << 3)
 #define SSI_MIDLE_NOIDLE		(1 << 12)
 
+/* Clk types requested by the dsp */
+#define IVA2_CLK	0
+#define GPT_CLK		1
+#define WDT_CLK		2
+#define MCBSP_CLK	3
+#define SSI_CLK		4
+
 struct dsp_clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
@@ -76,6 +83,26 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, ""}
 };
 
+static s8 get_clk_type(u8 id)
+{
+	s8 type;
+
+	if (id == DSP_CLK_IVA2_CK)
+		type = IVA2_CLK;
+	else if (id <= DSP_CLK_GPT8_ICK)
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
@@ -141,23 +168,33 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
 
-	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
+	switch (get_clk_type(clk_id)) {
+	case IVA2_CLK:
+	case GPT_CLK:
+	case MCBSP_CLK:
+	case WDT_CLK:
+	case SSI_CLK:
+		clk_handle = dsp_clks[clk_id].clk_handle;
+		if (clk_enable(clk_handle)) {
+			pr_err("dsp_clk_enable: failed to Enable CLK %s, "
+				"CLK dev id = %d\n", dsp_clks[clk_id].clk_name,
+				dsp_clks[clk_id].id);
+			status = -EPERM;
+		}
 
-	clk_handle = dsp_clks[clk_id].clk_handle;
-	if (clk_enable(clk_handle)) {
-		pr_err("dsp_clk_enable: failed to Enable CLK %s, "
-		       "CLK dev id = %d\n",
-		       dsp_clks[clk_id].clk_name,
-		       dsp_clks[clk_id].id);
-		status = -EPERM;
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
@@ -175,12 +212,22 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 
 	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
-	clk_handle = dsp_clks[clk_id].clk_handle;
-
-	if (clk_id == DSP_CLK_SSI_ICK)
-		ssi_clk_prepare(false);
-
-	clk_disable(clk_handle);
+	switch (get_clk_type(clk_id)) {
+	case IVA2_CLK:
+	case GPT_CLK:
+	case MCBSP_CLK:
+	case WDT_CLK:
+	case SSI_CLK:
+		clk_handle = dsp_clks[clk_id].clk_handle;
+
+		if (clk_id == DSP_CLK_SSI_ICK)
+			ssi_clk_prepare(false);
+
+		clk_disable(clk_handle);
+		break;
+	default:
+		dev_err(bridge, "Invalid clock id for disable\n");
+	}
 
 	return status;
 }
-- 
1.6.2.4

