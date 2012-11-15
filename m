From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/32] OMAPDSS: DISPC: use get_framedone_irq in disable_digit_out
Date: Thu, 15 Nov 2012 17:58:13 +0200
Message-ID: <1352995120-3288-6-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52162 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768125Ab2KOP7Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:16 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_disable_digit_out() needs to wait until the DIGIT output is
turned off. This is done with either VSYNC irq on OMAP2/3 and
FRAMEDONETV on OMAP4+. It currently uses a rather hacky way to decide
what irq to use.

This patch changes dispc_mgr_disable_digit_out to use
dispc_mgr_get_framedone_irq to find out if there's framedone irq on this
SoC, and if not, uses VSYNC.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2ec6470..0972bd3 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2726,7 +2726,6 @@ static void dispc_mgr_enable_digit_out(void)
 static void dispc_mgr_disable_digit_out(void)
 {
 	DECLARE_COMPLETION_ONSTACK(framedone_compl);
-	enum dss_hdmi_venc_clk_source_select src;
 	int r, i;
 	u32 irq_mask;
 	int num_irqs;
@@ -2734,18 +2733,20 @@ static void dispc_mgr_disable_digit_out(void)
 	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == false)
 		return;
 
-	src = dss_get_hdmi_venc_clk_source();
-
 	/*
 	 * When we disable the digit output, we need to wait for FRAMEDONE to
-	 * know that DISPC has finished with the output. For analog tv out we'll
-	 * use vsync, as omap2/3 don't have framedone for TV.
+	 * know that DISPC has finished with the output.
 	 */
 
-	if (src == DSS_HDMI_M_PCLK) {
-		irq_mask = DISPC_IRQ_FRAMEDONETV;
-		num_irqs = 1;
-	} else {
+	irq_mask = dispc_mgr_get_framedone_irq(OMAP_DSS_CHANNEL_DIGIT);
+	num_irqs = 1;
+
+	if (!irq_mask) {
+		/*
+		 * omap 2/3 don't have framedone irq for TV, so we need to use
+		 * vsyncs for this.
+		 */
+
 		irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT);
 		/*
 		 * We need to wait for both even and odd vsyncs. Note that this
-- 
1.7.10.4

