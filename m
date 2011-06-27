From: Dima Zavin <dima@android.com>
Subject: [PATCH] OMAP: DSS: dispc: enable/disable clocks in error handler
Date: Mon, 27 Jun 2011 10:31:05 -0700
Message-ID: <1309195865-23808-1-git-send-email-dima@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:54151 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab1F0Rbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 13:31:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>

There's no guarantee that the error handler worker thread
will run while the dispc clocks are on. Explicitly enable/disable
them.

Signed-off-by: Dima Zavin <dima@android.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 62aa77c..2458248 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3292,6 +3292,8 @@ static void dispc_error_worker(struct work_struct *work)
 	dispc.error_irqs = 0;
 	spin_unlock_irqrestore(&dispc.irq_lock, flags);
 
+	dispc_runtime_get();
+
 	if (errors & DISPC_IRQ_GFX_FIFO_UNDERFLOW) {
 		DSSERR("GFX_FIFO_UNDERFLOW, disabling GFX\n");
 		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
@@ -3478,6 +3480,8 @@ static void dispc_error_worker(struct work_struct *work)
 	dispc.irq_error_mask |= errors;
 	_omap_dispc_set_irqs();
 	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+
+	dispc_runtime_put();
 }
 
 int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout)
-- 
1.7.3.1

