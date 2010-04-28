From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: Balance the number of enable/disable
Date: Tue, 27 Apr 2010 20:29:25 -0500
Message-ID: <1272418167-12630-18-git-send-email-omar.ramirez@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-2-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-3-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-10-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-13-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-14-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-15-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-16-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-17-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44933 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab0D1BYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:32 -0400
In-Reply-To: <1272418167-12630-17-git-send-email-omar.ramirez@ti.com>
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
1.6.0.4

