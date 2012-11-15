From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/32] OMAPDSS: cleanup WB enable/is_enabled functions
Date: Thu, 15 Nov 2012 17:58:15 +0200
Message-ID: <1352995120-3288-8-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933340Ab2KOP7U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:20 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of doing direct register reads/writes, dispc_wb_enable() and
dispc_wb_is_enabled() functions can use the common overlay functions to
set and check the enable bit.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0dca3ff..662bf56 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2804,12 +2804,12 @@ void dispc_mgr_disable_sync(enum omap_channel channel)
 
 void dispc_wb_enable(bool enable)
 {
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(OMAP_DSS_WB), enable ? 1 : 0, 0, 0);
+	dispc_ovl_enable(OMAP_DSS_WB, enable);
 }
 
 bool dispc_wb_is_enabled(void)
 {
-	return REG_GET(DISPC_OVL_ATTRIBUTES(OMAP_DSS_WB), 0, 0);
+	return dispc_ovl_enabled(OMAP_DSS_WB);
 }
 
 static void dispc_lcd_enable_signal_polarity(bool act_high)
-- 
1.7.10.4

