From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 02/19] DSPBRIDGE: fail if clk handle is NULL
Date: Wed, 28 Apr 2010 10:29:40 -0500
Message-ID: <1272468597-6748-3-git-send-email-omar.ramirez@ti.com>
References: <1272468597-6748-1-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50192 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0D1PY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 11:24:57 -0400
In-Reply-To: <1272468597-6748-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If we fail if a clk handle is NULL during initialization
then there is no need to keep checking every time if the
handle is NULL for enable/disable/set_32k/get_use_cnt.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   68 +++++++++++--------------------------
 1 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index fb2ca81..1089e72 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -130,7 +130,7 @@ bool services_clk_init(void)
 			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
 			       __func__, services_clks[i].clk_name,
 			       services_clks[i].id);
-			/* should we fail here?? */
+			return false;
 		}
 		services_clks[i].clk_handle = clk_handle;
 		i++;
@@ -153,17 +153,11 @@ dsp_status services_clk_enable(IN enum services_clk_id clk_id)
 	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
 
 	clk_handle = services_clks[clk_id].clk_handle;
-	if (clk_handle) {
-		if (clk_enable(clk_handle)) {
-			pr_err("services_clk_enable: failed to Enable CLK %s, "
-			       "CLK dev id = %d\n",
-			       services_clks[clk_id].clk_name,
-			       services_clks[clk_id].id);
-			status = -EPERM;
-		}
-	} else {
-		pr_err("%s: failed to get CLK %s, CLK dev id = %d\n", __func__,
-		     services_clks[clk_id].clk_name, services_clks[clk_id].id);
+	if (clk_enable(clk_handle)) {
+		pr_err("services_clk_enable: failed to Enable CLK %s, "
+		       "CLK dev id = %d\n",
+		       services_clks[clk_id].clk_name,
+		       services_clks[clk_id].id);
 		status = -EPERM;
 	}
 	/* The SSI module need to configured not to have the Forced idle for
@@ -193,13 +187,11 @@ dsp_status clk_set32k_hz(IN enum services_clk_id clk_id)
 	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
 
 	clk_handle = services_clks[clk_id].clk_handle;
-	if (clk_handle) {
-		if (!(clk_set_parent(clk_handle, clk_parent) == 0x0)) {
-			pr_err("%s: failed for %s, dev id = %d\n", __func__,
-			       services_clks[clk_id].clk_name,
-			       services_clks[clk_id].id);
-			status = -EPERM;
-		}
+	if (!(clk_set_parent(clk_handle, clk_parent) == 0x0)) {
+		pr_err("%s: failed for %s, dev id = %d\n", __func__,
+		       services_clks[clk_id].clk_name,
+		       services_clks[clk_id].id);
+		status = -EPERM;
 	}
 	return status;
 }
@@ -231,15 +223,8 @@ dsp_status services_clk_disable(IN enum services_clk_id clk_id)
 	if (clk_id == SERVICESCLK_SSI_ICK)
 		ssi_clk_prepare(false);
 
-	if (clk_handle) {
-		clk_disable(clk_handle);
-	} else {
-		pr_err("services_clk_disable: failed to get CLK %s,"
-		       "CLK dev id = %d\n",
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
-		status = -EPERM;
-	}
+	clk_disable(clk_handle);
+
 	return status;
 }
 
@@ -260,38 +245,25 @@ dsp_status services_clk_get_rate(IN enum services_clk_id clk_id, u32 *speedKhz)
 	*speedKhz = 0x0;
 
 	clk_handle = services_clks[clk_id].clk_handle;
-	if (clk_handle) {
-		clk_speed_hz = clk_get_rate(clk_handle);
-		*speedKhz = clk_speed_hz / 1000;
-		dev_dbg(bridge, "%s: clk_speed_hz = %d, speedinKhz = %d\n",
+	clk_speed_hz = clk_get_rate(clk_handle);
+	*speedKhz = clk_speed_hz / 1000;
+	dev_dbg(bridge, "%s: clk_speed_hz = %d, speedinKhz = %d\n",
 			__func__, clk_speed_hz, *speedKhz);
-	} else {
-		pr_err("%s: failed to get %s, dev Id = %d\n", __func__,
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
-		status = -EPERM;
-	}
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
-		status = -EPERM;
-	}
+	/* FIXME: usecount shouldn't be used */
+	use_count = clk_handle->usecount;
+
 	return use_count;
 }
 
-- 
1.6.2.4

