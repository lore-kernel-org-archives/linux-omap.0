From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/20] OMAPDSS: DISPC: make _enable_mgr_out public as "dispc_mgr_enable"
Date: Wed, 24 Oct 2012 12:28:59 +0300
Message-ID: <1351070951-18616-9-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35465 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150Ab2JXJ3i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:38 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We need a low level manager-enable function for omapdrm. We have that
function as dispc internal func, _enable_mgr_out().

This patch exposes that function, and renames it to dispc_mgr_enable().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 +++++-----
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 600a412..b5cdbaf 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2595,7 +2595,7 @@ static void dispc_mgr_disable_isr(void *data, u32 mask)
 	complete(compl);
 }
 
-static void _enable_mgr_out(enum omap_channel channel, bool enable)
+void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
 	mgr_fld_write(channel, DISPC_MGR_FLD_ENABLE, enable);
 	/* flush posted write */
@@ -2609,7 +2609,7 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
 
 static void dispc_mgr_enable_lcd_out(enum omap_channel channel)
 {
-	_enable_mgr_out(channel, true);
+	dispc_mgr_enable(channel, true);
 }
 
 static void dispc_mgr_disable_lcd_out(enum omap_channel channel)
@@ -2633,7 +2633,7 @@ static void dispc_mgr_disable_lcd_out(enum omap_channel channel)
 	if (r)
 		DSSERR("failed to register FRAMEDONE isr\n");
 
-	_enable_mgr_out(channel, false);
+	dispc_mgr_enable(channel, false);
 
 	/* if we couldn't register for framedone, just sleep and exit */
 	if (r) {
@@ -2685,7 +2685,7 @@ static void dispc_mgr_enable_digit_out(void)
 		return;
 	}
 
-	_enable_mgr_out(OMAP_DSS_CHANNEL_DIGIT, true);
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, true);
 
 	/* wait for the first evsync */
 	if (!wait_for_completion_timeout(&vsync_compl, msecs_to_jiffies(100)))
@@ -2735,7 +2735,7 @@ static void dispc_mgr_disable_digit_out(void)
 	if (r)
 		DSSERR("failed to register %x isr\n", irq_mask);
 
-	_enable_mgr_out(OMAP_DSS_CHANNEL_DIGIT, false);
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, false);
 
 	/* if we couldn't register the irq, just sleep and exit */
 	if (r) {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index efe8984..b007aee 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -436,6 +436,7 @@ u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
 u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
+void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
 void dispc_mgr_enable_sync(enum omap_channel channel);
 void dispc_mgr_disable_sync(enum omap_channel channel);
-- 
1.7.9.5

