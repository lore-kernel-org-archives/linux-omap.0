From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 30/65] OMAPDSS: DISPC: Add dispc_mgr_get_vsync_irq()
Date: Tue, 22 Nov 2011 11:21:29 +0200
Message-ID: <1321953724-6350-31-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56010 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757798Ab1KVJXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:42 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dispc_mgr_get_vsync_irq() which returns the irq number for vsync on
the given channel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   14 ++++++++++++++
 drivers/video/omap2/dss/dss.h   |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5ac00a2..27a2cff 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -438,6 +438,20 @@ static struct omap_dss_device *dispc_mgr_get_device(enum omap_channel channel)
 	return mgr ? mgr->device : NULL;
 }
 
+u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_IRQ_VSYNC;
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_IRQ_VSYNC2;
+	case OMAP_DSS_CHANNEL_DIGIT:
+		return DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
+	default:
+		BUG();
+	}
+}
+
 bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	int bit;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 66fed79..5a6f1db 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -409,9 +409,9 @@ int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
 
-
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
 void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
+u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
-- 
1.7.4.1

