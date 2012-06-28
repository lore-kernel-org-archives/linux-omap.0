From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/12] OMAPDSS: DISPC: Remove a redundant function
Date: Thu, 28 Jun 2012 20:00:40 +0530
Message-ID: <1340893842-10626-12-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961Ab2F1Oco (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:44 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dss_mgr_is_lcd() available in dss.h does the same thing as dispc_mgr_is_lcd()
in dispc.c. Remove the function from dispc.c and replace it with the one in
dss.h.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b047fe6..0e0b89c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -387,15 +387,6 @@ void dispc_runtime_put(void)
 	WARN_ON(r < 0);
 }
 
-static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
-{
-	if (channel == OMAP_DSS_CHANNEL_LCD ||
-			channel == OMAP_DSS_CHANNEL_LCD2)
-		return true;
-	else
-		return false;
-}
-
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 {
 	switch (channel) {
@@ -430,7 +421,7 @@ bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	int bit;
 
-	if (dispc_mgr_is_lcd(channel))
+	if (dss_mgr_is_lcd(channel))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
@@ -446,7 +437,7 @@ void dispc_mgr_go(enum omap_channel channel)
 	int bit;
 	bool enable_bit, go_bit;
 
-	if (dispc_mgr_is_lcd(channel))
+	if (dss_mgr_is_lcd(channel))
 		bit = 0; /* LCDENABLE */
 	else
 		bit = 1; /* DIGITALENABLE */
@@ -460,7 +451,7 @@ void dispc_mgr_go(enum omap_channel channel)
 	if (!enable_bit)
 		return;
 
-	if (dispc_mgr_is_lcd(channel))
+	if (dss_mgr_is_lcd(channel))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
@@ -939,7 +930,7 @@ static void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 {
 	u32 coef_r, coef_g, coef_b;
 
-	if (!dispc_mgr_is_lcd(channel))
+	if (!dss_mgr_is_lcd(channel))
 		return;
 
 	coef_r = FLD_VAL(coefs->rr, 31, 22) | FLD_VAL(coefs->rg, 20, 11) |
@@ -1798,7 +1789,7 @@ static int check_horiz_timing_omap3(enum omap_channel channel,
 
 	nonactive = t->x_res + t->hfp + t->hsw + t->hbp - out_width;
 	pclk = dispc_mgr_pclk_rate(channel);
-	if (dispc_mgr_is_lcd(channel))
+	if (dss_mgr_is_lcd(channel))
 		lclk = dispc_mgr_lclk_rate(channel);
 	else
 		lclk = dispc_fclk_rate();
@@ -2398,7 +2389,7 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
 
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
-	if (dispc_mgr_is_lcd(channel))
+	if (dss_mgr_is_lcd(channel))
 		dispc_mgr_enable_lcd_out(channel, enable);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		dispc_mgr_enable_digit_out(enable);
@@ -2610,7 +2601,7 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
 
 	timings_ok = _dispc_mgr_size_ok(timings->x_res, timings->y_res);
 
-	if (dispc_mgr_is_lcd(channel))
+	if (dss_mgr_is_lcd(channel))
 		timings_ok =  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
 						timings->hfp, timings->hbp,
 						timings->vsw, timings->vfp,
@@ -2702,7 +2693,7 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 		return;
 	}
 
-	if (dispc_mgr_is_lcd(channel)) {
+	if (dss_mgr_is_lcd(channel)) {
 		_dispc_mgr_set_lcd_timings(channel, t.hsw, t.hfp, t.hbp, t.vsw,
 				t.vfp, t.vbp, t.vsync_level, t.hsync_level,
 				t.pclk_edge, t.de_level, t.hsync_vsync_edge);
@@ -2808,7 +2799,7 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 {
 	unsigned long r;
 
-	if (dispc_mgr_is_lcd(channel)) {
+	if (dss_mgr_is_lcd(channel)) {
 		int pcd;
 		u32 l;
 
-- 
1.7.9.5

