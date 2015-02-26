From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/15] OMAPDSS: HDMI: hdmi synclost work-around
Date: Thu, 26 Feb 2015 14:49:08 +0200
Message-ID: <1424954949-12801-14-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49925 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243AbbBZMtv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 07:49:51 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC and HDMI have synchronization issues when enabling or disabling
the output. The symptoms are a lot of sync-lost errors and occasionally
dispc gets "stuck" and we never get FRAMEDONE when disabling.

Testing has shown that this is somehow related to the time when DISPC's
output gets enabled:

- If DISPC is disabled when HDMI is in vertical blanking area, DISPC
  often gets stuck.
- If DISPC is disabled after vertical blanking area, no sync lost errors
  are seen.
- If DISPC is enabled right after HDMI VSYNC event, no sync lost errors
  are seen.

This patch is a simple work-around for the above issues:

- Before enabling DISPC output, we wait for HDMI VSYNC.
- Before disabling DISPC output, we wait for HDMI VSYNC and VSW+VBP.

This is not perfect WA, as it relies on the enable/disable of DISPC
happening relatively soon after the wait has ended. In practice I
presume there is at least ~10ms timewindow to accomplish the DISPC
enable/disable, which I hope is enough.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c | 50 +++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi5.c | 50 +++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 916d47978f41..39cdd164d2ae 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -217,6 +217,26 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_vid_enable;
 
+	/*
+	 * XXX Seems that on we easily get a flood of sync-lost errors when
+	 * enabling the output. This seems to be related to the time between
+	 * HDMI VSYNC and enabling the DISPC output.
+	 *
+	 * Testing shows that the sync-lost errors do not happen if we enable
+	 * the DISPC output very soon after HDMI VBLANK. So wait here for
+	 * VBLANK to reduce the chances of sync-losts.
+	 */
+	hdmi_write_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS, HDMI_IRQ_VIDEO_VSYNC);
+
+	while (true) {
+		u32 v = hdmi_read_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS_RAW);
+
+		if (v & HDMI_IRQ_VIDEO_VSYNC)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
 	r = dss_mgr_enable(mgr);
 	if (r)
 		goto err_mgr_enable;
@@ -242,9 +262,39 @@ err_pll_enable:
 static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 {
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
+	const struct omap_video_timings *t;
+	unsigned vblank;
 
 	hdmi_wp_clear_irqenable(&hdmi.wp, 0xffffffff);
 
+	/*
+	 * XXX Seems that on we easily get a flood of sync-lost errors when
+	 * disabling the output, and sometimes the DISPC seems to get stuck and
+	 * we never get FRAMEDONE. This seems to happen if we disable DISPC
+	 * output during HDMI VBLANK.
+	 *
+	 * To reduce the possibility for sync-lost errors, calculate the time
+	 * for the vertical blanking, wait for VBLANK, then wait until VBLANK
+	 * ends.
+	 */
+	t = &hdmi.cfg.timings;
+	vblank = t->hfp + t->hsw + t->hbp + t->x_res;
+	vblank *= t->vsw + t->vbp;
+	vblank = (vblank * 1000) / (t->pixelclock / 1000);
+
+	hdmi_write_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS, HDMI_IRQ_VIDEO_VSYNC);
+
+	while (true) {
+		u32 v = hdmi_read_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS_RAW);
+
+		if (v & HDMI_IRQ_VIDEO_VSYNC)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
+	usleep_range(vblank, vblank + 1000);
+
 	dss_mgr_disable(mgr);
 
 	hdmi_wp_video_stop(&hdmi.wp);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 3f0b34a7031a..65a91ac87a6a 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -234,6 +234,26 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_vid_enable;
 
+	/*
+	 * XXX Seems that on we easily get a flood of sync-lost errors when
+	 * enabling the output. This seems to be related to the time between
+	 * HDMI VSYNC and enabling the DISPC output.
+	 *
+	 * Testing shows that the sync-lost errors do not happen if we enable
+	 * the DISPC output very soon after HDMI VBLANK. So wait here for
+	 * VBLANK to reduce the chances of sync-losts.
+	 */
+	hdmi_write_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS, HDMI_IRQ_VIDEO_VSYNC);
+
+	while (true) {
+		u32 v = hdmi_read_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS_RAW);
+
+		if (v & HDMI_IRQ_VIDEO_VSYNC)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
 	r = dss_mgr_enable(mgr);
 	if (r)
 		goto err_mgr_enable;
@@ -259,9 +279,39 @@ err_pll_enable:
 static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 {
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
+	const struct omap_video_timings *t;
+	unsigned vblank;
 
 	hdmi_wp_clear_irqenable(&hdmi.wp, 0xffffffff);
 
+	/*
+	 * XXX Seems that on we easily get a flood of sync-lost errors when
+	 * disabling the output, and sometimes the DISPC seems to get stuck and
+	 * we never get FRAMEDONE. This seems to happen if we disable DISPC
+	 * output during HDMI VBLANK.
+	 *
+	 * To reduce the possibility for sync-lost errors, calculate the time
+	 * for the vertical blanking, wait for VBLANK, then wait until VBLANK
+	 * ends.
+	 */
+	t = &hdmi.cfg.timings;
+	vblank = t->hfp + t->hsw + t->hbp + t->x_res;
+	vblank *= t->vsw + t->vbp;
+	vblank = (vblank * 1000) / (t->pixelclock / 1000);
+
+	hdmi_write_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS, HDMI_IRQ_VIDEO_VSYNC);
+
+	while (true) {
+		u32 v = hdmi_read_reg(hdmi.wp.base, HDMI_WP_IRQSTATUS_RAW);
+
+		if (v & HDMI_IRQ_VIDEO_VSYNC)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
+	usleep_range(vblank, vblank + 1000);
+
 	dss_mgr_disable(mgr);
 
 	hdmi_wp_video_stop(&hdmi.wp);
-- 
2.3.0

