From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/11] OMAPDSS: HDMI: wait for framedone when stopping video
Date: Wed, 17 Jun 2015 15:54:35 +0300
Message-ID: <1434545675-477-12-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43914 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755532AbbFQMzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:55:05 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment when HDMI video output is stopped, we just clear the
enable bit and return. While it's unclear if this can cause any issues,
I think it's still better to wait for FRAMEDONE interrupt after clearing
the enable bit so that we're sure the HDMI IP has finished.

As we don't have any ready-made irq handling for HDMI, and this only
needs to be done when disabling the HDMI output, this patch implements a
simple loop with sleep, polling the FRAMEDONE bit.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_wp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index c15377e242cc..7c544bc56fb5 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -110,7 +110,23 @@ int hdmi_wp_video_start(struct hdmi_wp_data *wp)
 
 void hdmi_wp_video_stop(struct hdmi_wp_data *wp)
 {
+	int i;
+
+	hdmi_write_reg(wp->base, HDMI_WP_IRQSTATUS, HDMI_IRQ_VIDEO_FRAME_DONE);
+
 	REG_FLD_MOD(wp->base, HDMI_WP_VIDEO_CFG, false, 31, 31);
+
+	for (i = 0; i < 50; ++i) {
+		u32 v;
+
+		msleep(20);
+
+		v = hdmi_read_reg(wp->base, HDMI_WP_IRQSTATUS_RAW);
+		if (v & HDMI_IRQ_VIDEO_FRAME_DONE)
+			return;
+	}
+
+	DSSERR("no HDMI FRAMEDONE when disabling output\n");
 }
 
 void hdmi_wp_video_config_format(struct hdmi_wp_data *wp,
-- 
2.1.4

