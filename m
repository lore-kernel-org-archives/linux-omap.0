From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] OMAPDSS: APPLY: make ovl_enable/disable synchronous
Date: Wed, 29 Feb 2012 10:48:22 +0200
Message-ID: <1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:56836 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932247Ab2B2Isn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 03:48:43 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so4547349laa.38
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 00:48:41 -0800 (PST)
In-Reply-To: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

ovl->enable/disable are meant to be synchronous so that they can handle
the configuration of fifo sizes. The current kernel doesn't configure
fifo sizes yet, and so the code doesn't need to block to function (from
omapdss driver's perspective).

However, for the users of omapdss a non-blocking ovl->disable is
confusing, because they don't know when the memory area is not used
any more.

Furthermore, when the fifo size configuration is added in the next merge
window, the change from non-blocking to blocking could cause side
effects to the users of omapdss. So by making the functions block
already will keep them behaving in the same manner.

And, while not the main purpose of this patch, this will also remove the
compile warning:

drivers/video/omap2/dss/apply.c:350: warning:
'wait_pending_extra_info_updates' defined but not used

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 052dc87..87b3e25 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1276,6 +1276,9 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	/* wait for overlay to be enabled */
+	wait_pending_extra_info_updates();
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
@@ -1313,6 +1316,9 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	/* wait for the overlay to be disabled */
+	wait_pending_extra_info_updates();
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
-- 
1.7.4.1

