From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 03/19] DSPBRIDGE: fail if clk handle is NULL
Date: Thu,  8 Apr 2010 18:15:52 -0500
Message-ID: <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933813Ab0DHW7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 18:59:32 -0400
In-Reply-To: <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If we fail if a clk handle is NULL during initialization
then there is no need to keep checking every time if the
handle is NULL for enable/disable/set_32k/get_use_cnt.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   54 +++++++++++--------------------------
 1 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 5ed6bb5..57cf6e3 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -132,7 +132,7 @@ bool services_clk_init(void)
 			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
 			       __func__, services_clks[i].clk_name,
 			       services_clks[i].id);
-			/* should we fail here?? */
+			return false;
 		}
 		services_clks[i].clk_handle = clk_handle;
 		i++;
@@ -155,17 +155,11 @@ dsp_status services_clk_enable(IN enum services_clk_id clk_id)
 	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
 
 	clk_handle = services_clks[clk_id].clk_handle;
-	if (clk_handle) {
-		if (clk_enable(clk_handle)) {
-			pr_err("services_clk_enable: failed to Enable CLK %s, "
-			       "CLK dev id = %d\n",
-			       services_clks[clk_id].clk_name,
-			       services_clks[clk_id].id);
-			status = DSP_EFAIL;
-		}
-	} else {
-		pr_err("%s: failed to get CLK %s, CLK dev id = %d\n", __func__,
-		     services_clks[clk_id].clk_name, services_clks[clk_id].id);
+	if (clk_enable(clk_handle)) {
+		pr_err("services_clk_enable: failed to Enable CLK %s, "
+		       "CLK dev id = %d\n",
+		       services_clks[clk_id].clk_name,
+		       services_clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	/* The SSI module need to configured not to have the Forced idle for
@@ -195,13 +189,11 @@ dsp_status clk_set32k_hz(IN enum services_clk_id clk_id)
 	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
 
 	clk_handle = services_clks[clk_id].clk_handle;
-	if (clk_handle) {
-		if (!(clk_set_parent(clk_handle, clk_parent) == 0x0)) {
-			pr_err("%s: failed for %s, dev id = %d\n", __func__,
-			       services_clks[clk_id].clk_name,
-			       services_clks[clk_id].id);
-			status = DSP_EFAIL;
-		}
+	if (!(clk_set_parent(clk_handle, clk_parent) == 0x0)) {
+		pr_err("%s: failed for %s, dev id = %d\n", __func__,
+		       services_clks[clk_id].clk_name,
+		       services_clks[clk_id].id);
+		status = DSP_EFAIL;
 	}
 	return status;
 }
@@ -233,36 +225,22 @@ dsp_status services_clk_disable(IN enum services_clk_id clk_id)
 	if (clk_id == SERVICESCLK_SSI_ICK)
 		ssi_clk_prepare(false);
 
-	if (clk_handle) {
-		clk_disable(clk_handle);
-	} else {
-		pr_err("services_clk_disable: failed to get CLK %s,"
-		       "CLK dev id = %d\n",
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
-		status = DSP_EFAIL;
-	}
+	clk_disable(clk_handle);
+
 	return status;
 }
 
 s32 clk_get_use_cnt(IN enum services_clk_id clk_id)
 {
-	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
 	s32 use_count = -1;
 	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
 
 	clk_handle = services_clks[clk_id].clk_handle;
 
-	if (clk_handle) {
-		/* FIXME: usecount shouldn't be used */
-		use_count = clk_handle->usecount;
-	} else {
-		pr_err("%s: failed to get %s, dev Id = %d\n", __func__,
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
-		status = DSP_EFAIL;
-	}
+	/* FIXME: usecount shouldn't be used */
+	use_count = clk_handle->usecount;
+
 	return use_count;
 }
 
-- 
1.6.2.4

