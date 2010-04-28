From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 17/19] DSPBRIDGE: Balance the number of enable/disable
Date: Wed, 28 Apr 2010 10:29:55 -0500
Message-ID: <1272468597-6748-18-git-send-email-omar.ramirez@ti.com>
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
 <1272468597-6748-15-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-16-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-17-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55479 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882Ab0D1PY7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 11:24:59 -0400
In-Reply-To: <1272468597-6748-17-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch ensure a balanced number of enable/disable
calls is made.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 763a599..c4f0874 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -71,6 +71,23 @@ struct dsp_ssi {
 
 static struct dsp_ssi ssi;
 
+static u32 dsp_clocks;
+
+static inline u32 is_dsp_clk_active(u32 clk, u8 id)
+{
+	return clk & (1 << id);
+}
+
+static inline void set_dsp_clk_active(u32 *clk, u8 id)
+{
+	*clk |= (1 << id);
+}
+
+static inline void set_dsp_clk_inactive(u32 *clk, u8 id)
+{
+	*clk &= ~(1 << id);
+}
+
 static s8 get_clk_type(u8 id)
 {
 	s8 type;
@@ -184,6 +201,11 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 
+	if (is_dsp_clk_active(dsp_clocks, clk_id)) {
+		dev_err(bridge, "WARN: clock id %d already enabled\n", clk_id);
+		goto out;
+	}
+
 	switch (get_clk_type(clk_id)) {
 	case IVA2_CLK:
 		clk_enable(iva2_clk);
@@ -215,8 +237,13 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for enable\n");
+		status = -EPERM;
 	}
 
+	if (DSP_SUCCEEDED(status))
+		set_dsp_clk_active(&dsp_clocks, clk_id);
+
+out:
 	return status;
 }
 
@@ -230,6 +257,11 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 
+	if (!is_dsp_clk_active(dsp_clocks, clk_id)) {
+		dev_err(bridge, "ERR: clock id %d already disabled\n", clk_id);
+		goto out;
+	}
+
 	switch (get_clk_type(clk_id)) {
 	case IVA2_CLK:
 		clk_disable(iva2_clk);
@@ -253,8 +285,13 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for disable\n");
+		status = -EPERM;
 	}
 
+	if (DSP_SUCCEEDED(status))
+		set_dsp_clk_inactive(&dsp_clocks, clk_id);
+
+out:
 	return status;
 }
 
-- 
1.6.2.4

