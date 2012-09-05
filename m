From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Date: Wed,  5 Sep 2012 11:25:50 +0300
Message-ID: <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:48762 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758035Ab2IEI0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:34 -0400
Received: by lbbgj3 with SMTP id gj3so189919lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:32 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_mgr_set_timings() can only be called when the output is not active.
This means that most of the code in the function is extra, as there's no
need to write the values to registers, etc, because that will be handled
when the output will be enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 53629dd..1b49019 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1314,21 +1314,19 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings)
 {
 	unsigned long flags;
-
-	mutex_lock(&apply_lock);
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	dss_apply_mgr_timings(mgr, timings);
-
-	dss_write_regs();
-	dss_set_go_bits();
+	if (mp->enabled) {
+		DSSERR("cannot set timings for %s: manager needs to be disabled\n",
+			mgr->name);
+		goto out;
+	}
 
+	dss_apply_mgr_timings(mgr, timings);
+out:
 	spin_unlock_irqrestore(&data_lock, flags);
-
-	wait_pending_extra_info_updates();
-
-	mutex_unlock(&apply_lock);
 }
 
 static void dss_apply_mgr_lcd_config(struct omap_overlay_manager *mgr,
-- 
1.7.9.5

