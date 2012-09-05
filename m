From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/17] OMAPDSS: clean up dss_mgr_set_lcd_config
Date: Wed,  5 Sep 2012 11:25:49 +0300
Message-ID: <1346833555-31258-12-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:52026 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758111Ab2IEI0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:34 -0400
Received: by lbbgj3 with SMTP id gj3so189905lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:31 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_mgr_set_lcd_config() can only be called when the output is not
active. This means that most of the code in the function is extra, as
there's no need to write the values to registers, etc, because that will
be handled when the output will be enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 52a5940..53629dd 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1346,7 +1346,7 @@ void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 	unsigned long flags;
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
-	mutex_lock(&apply_lock);
+	spin_lock_irqsave(&data_lock, flags);
 
 	if (mp->enabled) {
 		DSSERR("cannot apply lcd config for %s: manager needs to be disabled\n",
@@ -1354,19 +1354,9 @@ void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 		goto out;
 	}
 
-	spin_lock_irqsave(&data_lock, flags);
-
 	dss_apply_mgr_lcd_config(mgr, config);
-
-	dss_write_regs();
-	dss_set_go_bits();
-
-	spin_unlock_irqrestore(&data_lock, flags);
-
-	wait_pending_extra_info_updates();
-
 out:
-	mutex_unlock(&apply_lock);
+	spin_unlock_irqrestore(&data_lock, flags);
 }
 
 int dss_ovl_set_info(struct omap_overlay *ovl,
-- 
1.7.9.5

