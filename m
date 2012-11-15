From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/32] OMAPDSS: DISPC: use WARN_ON() in dispc_mgr_go
Date: Thu, 15 Nov 2012 17:58:16 +0200
Message-ID: <1352995120-3288-9-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59116 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768199Ab2KOP7W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:22 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_go() should never be called with manager output disabled or if
the GO bit is already set. Change the current silent returns to
WARN_ONs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 662bf56..e219eda 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -565,20 +565,8 @@ bool dispc_mgr_go_busy(enum omap_channel channel)
 
 void dispc_mgr_go(enum omap_channel channel)
 {
-	bool enable_bit, go_bit;
-
-	/* if the channel is not enabled, we don't need GO */
-	enable_bit = mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE) == 1;
-
-	if (!enable_bit)
-		return;
-
-	go_bit = mgr_fld_read(channel, DISPC_MGR_FLD_GO) == 1;
-
-	if (go_bit) {
-		DSSERR("GO bit not down for channel %d\n", channel);
-		return;
-	}
+	WARN_ON(dispc_mgr_is_enabled(channel) == false);
+	WARN_ON(dispc_mgr_go_busy(channel));
 
 	DSSDBG("GO %s\n", mgr_desc[channel].name);
 
-- 
1.7.10.4

