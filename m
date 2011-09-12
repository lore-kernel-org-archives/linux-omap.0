From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 7/8] OMAP: DSS2: DISPC: improve dispc_mgr_enable_digit_out()
Date: Mon, 12 Sep 2011 12:12:52 +0300
Message-ID: <1315818773-18660-8-git-send-email-tomi.valkeinen@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:36587 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab1ILJNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:24 -0400
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

dispc_mgr_enable_digit_out() didn't handle HDMI case very well.

Improve the function to use FRAMEDONETV interrupt to see when HDMI has
been disabled.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   49 +++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4e9f87f..38d6595 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1924,11 +1924,16 @@ static void _enable_digit_out(bool enable)
 static void dispc_mgr_enable_digit_out(bool enable)
 {
 	struct completion frame_done_completion;
-	int r;
+	enum dss_hdmi_venc_clk_source_select src;
+	int r, i;
+	u32 irq_mask;
+	int num_irqs;
 
 	if (REG_GET(DISPC_CONTROL, 1, 1) == enable)
 		return;
 
+	src = dss_get_hdmi_venc_clk_source();
+
 	if (enable) {
 		unsigned long flags;
 		/* When we enable digit output, we'll get an extra digit
@@ -1945,36 +1950,40 @@ static void dispc_mgr_enable_digit_out(bool enable)
 	 * wait for the extra sync losts */
 	init_completion(&frame_done_completion);
 
+	if (src == DSS_HDMI_M_PCLK && enable == false) {
+		irq_mask = DISPC_IRQ_FRAMEDONETV;
+		num_irqs = 1;
+	} else {
+		irq_mask = DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD;
+		/* XXX I understand from TRM that we should only wait for the
+		 * current field to complete. But it seems we have to wait for
+		 * both fields */
+		num_irqs = 2;
+	}
+
 	r = omap_dispc_register_isr(dispc_disable_isr, &frame_done_completion,
-			DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD);
+			irq_mask);
 	if (r)
-		DSSERR("failed to register EVSYNC isr\n");
+		DSSERR("failed to register %x isr\n", irq_mask);
 
 	_enable_digit_out(enable);
 
-	/* XXX I understand from TRM that we should only wait for the
-	 * current field to complete. But it seems we have to wait
-	 * for both fields */
-	if (!wait_for_completion_timeout(&frame_done_completion,
-				msecs_to_jiffies(100)))
-		DSSERR("timeout waiting for EVSYNC\n");
-
-	if (!wait_for_completion_timeout(&frame_done_completion,
-				msecs_to_jiffies(100)))
-		DSSERR("timeout waiting for EVSYNC\n");
+	for (i = 0; i < num_irqs; ++i) {
+		if (!wait_for_completion_timeout(&frame_done_completion,
+					msecs_to_jiffies(100)))
+			DSSERR("timeout waiting for digit out to %s\n",
+					enable ? "start" : "stop");
+	}
 
-	r = omap_dispc_unregister_isr(dispc_disable_isr,
-			&frame_done_completion,
-			DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD);
+	r = omap_dispc_unregister_isr(dispc_disable_isr, &frame_done_completion,
+			irq_mask);
 	if (r)
-		DSSERR("failed to unregister EVSYNC isr\n");
+		DSSERR("failed to unregister %x isr\n", irq_mask);
 
 	if (enable) {
 		unsigned long flags;
 		spin_lock_irqsave(&dispc.irq_lock, flags);
-		dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
-		if (dss_has_feature(FEAT_MGR_LCD2))
-			dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
+		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST_DIGIT;
 		dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 		_omap_dispc_set_irqs();
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
-- 
1.7.4.1

