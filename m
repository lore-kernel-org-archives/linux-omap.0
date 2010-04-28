From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 14/19] DSPBRIDGE: dsp interface to enable ssi clocks
Date: Wed, 28 Apr 2010 10:29:52 -0500
Message-ID: <1272468597-6748-15-git-send-email-omar.ramirez@ti.com>
References: <1272468597-6748-1-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-2-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-3-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-4-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-5-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-6-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-7-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-8-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-9-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-10-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-11-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-12-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-13-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-14-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50196 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0D1PZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 11:25:00 -0400
In-Reply-To: <1272468597-6748-14-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch fixes the wrong name for ssi clock,
now it has been split into ssr and sst for fck. It
handle ick/ssr_fck/sst_fck clocks with one call to
disable/enable.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   56 ++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index ee85905..c72f574 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -55,20 +55,17 @@
 /* Bridge MCBSP id (6 - 10), OMAP Mcbsp id (1 - 5) */
 #define MCBSP_ID(id) ((id) - 13)
 
-struct dsp_clk_t {
-	struct clk *clk_handle;
-	const char *clk_name;
-	int id;
-};
-
 static struct omap_dm_timer *timer[4];
 
-static struct dsp_clk_t dsp_clks[] = {
-	{NULL, "ssi_ssr_sst_fck", -1},
-	{NULL, "ssi_ick", -1},
+struct clk *iva2_clk;
+
+struct dsp_ssi {
+	struct clk *sst_fck;
+	struct clk *ssr_fck;
+	struct clk *ick;
 };
 
-struct clk *iva2_clk;
+static struct dsp_ssi ssi;
 
 static s8 get_clk_type(u8 id)
 {
@@ -98,6 +95,9 @@ static s8 get_clk_type(u8 id)
 void dsp_clk_exit(void)
 {
 	clk_put(iva2_clk);
+	clk_put(ssi.sst_fck);
+	clk_put(ssi.ssr_fck);
+	clk_put(ssi.ick);
 }
 
 /*
@@ -114,6 +114,14 @@ void dsp_clk_init(void)
 	iva2_clk = clk_get(&dspbridge_device.dev, "iva2_ck");
 	if (IS_ERR(iva2_clk))
 		dev_err(bridge, "failed to get iva2 clock %p\n", iva2_clk);
+
+	ssi.sst_fck = clk_get(&dspbridge_device.dev, "ssi_sst_fck");
+	ssi.ssr_fck = clk_get(&dspbridge_device.dev, "ssi_ssr_fck");
+	ssi.ick = clk_get(&dspbridge_device.dev, "ssi_ick");
+
+	if (IS_ERR(ssi.sst_fck) || IS_ERR(ssi.ssr_fck) || IS_ERR(ssi.ick))
+		dev_err(bridge, "failed to get ssi: sst %p, ssr %p, ick %p\n",
+					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
 }
 
 /*
@@ -125,7 +133,6 @@ void dsp_clk_init(void)
 dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
-	struct clk *clk_handle;
 
 	switch (get_clk_type(clk_id)) {
 	case IVA2_CLK:
@@ -142,13 +149,9 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
 		break;
 	case SSI_CLK:
-		clk_handle = dsp_clks[clk_id].clk_handle;
-		if (clk_enable(clk_handle)) {
-			pr_err("dsp_clk_enable: failed to Enable CLK %s, "
-				"CLK dev id = %d\n", dsp_clks[clk_id].clk_name,
-				dsp_clks[clk_id].id);
-			status = -EPERM;
-		}
+		clk_enable(ssi.sst_fck);
+		clk_enable(ssi.ssr_fck);
+		clk_enable(ssi.ick);
 
 		/*
 		 * The SSI module need to configured not to have the Forced
@@ -157,8 +160,7 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		 * the client in the DSP hang waiting for the SSI module to
 		 * be active after enabling the clocks
 		 */
-		if (clk_id == DSP_CLK_SSI_ICK)
-			ssi_clk_prepare(true);
+		ssi_clk_prepare(true);
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for enable\n");
@@ -176,9 +178,6 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
-	struct clk *clk_handle;
-
-	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
 	switch (get_clk_type(clk_id)) {
 	case IVA2_CLK:
@@ -194,12 +193,11 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
 		break;
 	case SSI_CLK:
-		clk_handle = dsp_clks[clk_id].clk_handle;
-
-		if (clk_id == DSP_CLK_SSI_ICK)
-			ssi_clk_prepare(false);
-
-		clk_disable(clk_handle);
+		ssi_clk_prepare(false);
+		ssi_clk_prepare(false);
+		clk_disable(ssi.sst_fck);
+		clk_disable(ssi.ssr_fck);
+		clk_disable(ssi.ick);
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for disable\n");
-- 
1.6.2.4

