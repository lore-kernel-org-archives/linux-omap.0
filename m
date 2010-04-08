From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 17/19] DSPBRIDGE: Balance the number of enable/disable
Date: Thu,  8 Apr 2010 18:16:06 -0500
Message-ID: <1270768568-10712-18-git-send-email-omar.ramirez@ti.com>
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
 <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-12-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-13-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-15-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-16-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-17-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59843 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933768Ab0DHW7g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:36 -0400
In-Reply-To: <1270768568-10712-17-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch ensure a balanced number of enable/disable
calls is made.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 711bae4..8f539fd 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -69,6 +69,23 @@ struct dsp_ssi {
 
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
@@ -182,6 +199,11 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 
+	if (is_dsp_clk_active(dsp_clocks, clk_id)) {
+		dev_err(bridge, "WARN: clock id %d already enabled\n", clk_id);
+		goto out;
+	}
+
 	switch (get_clk_type(clk_id)) {
 	case GPT_CLK:
 		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
@@ -210,8 +232,13 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for enable\n");
+		status = DSP_EFAIL;
 	}
 
+	if (DSP_SUCCEEDED(status))
+		set_dsp_clk_active(&dsp_clocks, clk_id);
+
+out:
 	return status;
 }
 
@@ -227,6 +254,11 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 
 	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
+	if (!is_dsp_clk_active(dsp_clocks, clk_id)) {
+		dev_err(bridge, "ERR: clock id %d already disabled\n", clk_id);
+		goto out;
+	}
+
 	switch (get_clk_type(clk_id)) {
 	case GPT_CLK:
 		omap_dm_timer_free(timer[clk_id]);
@@ -246,7 +278,12 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for disable\n");
+		status = DSP_EFAIL;
 	}
 
+	if (DSP_SUCCEEDED(status))
+		set_dsp_clk_inactive(&dsp_clocks, clk_id);
+
+out:
 	return status;
 }
-- 
1.6.2.4

