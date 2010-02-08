From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 17/17] OMAP: DSS2: DSI: Add VC support for update
Date: Mon,  8 Feb 2010 17:57:41 +0200
Message-ID: <1265644661-3694-18-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-16-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-17-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65510 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab0BHP4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:56:03 -0500
In-Reply-To: <1265644661-3694-17-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Update was hardcoded to use virtual channel 0. This patch adds a parameter
that specifies the VC.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/dsi.c             |   13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index ccf35a8..cd7b769 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -564,6 +564,7 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 				    u16 *x, u16 *y, u16 *w, u16 *h);
 int omap_dsi_update(struct omap_dss_device *dssdev,
+		int channel,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(int, void *), void *data);
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 79d27de..624d53e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -233,6 +233,7 @@ static struct
 
 	struct completion bta_completion;
 
+	int update_channel;
 	struct dsi_update_region update_region;
 
 	bool te_enabled;
@@ -2721,7 +2722,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	unsigned packet_len;
 	u32 l;
 	bool use_te_trigger;
-	const unsigned channel = 0;
+	const unsigned channel = dsi.update_channel;
 	/* line buffer is 1024 x 24bits */
 	/* XXX: for some reason using full buffer size causes considerable TX
 	 * slowdown with update sizes that fill the whole buffer */
@@ -2732,6 +2733,8 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
 			x, y, w, h);
 
+	dsi_vc_config_vp(channel);
+
 	bytespp	= dssdev->ctrl.pixel_size / 8;
 	bytespl = w * bytespp;
 	bytespf = bytespl * h;
@@ -2799,7 +2802,7 @@ static void dsi_te_timeout(unsigned long arg)
 static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 {
 	int r;
-	const int channel = 0;
+	const int channel = dsi.update_channel;
 	bool use_te_trigger;
 
 	DSSERR("Framedone not received for 250ms!\n");
@@ -2852,7 +2855,7 @@ static void dsi_framedone_irq_callback(void *data, u32 mask)
 static void dsi_handle_framedone(void)
 {
 	int r;
-	const int channel = 0;
+	const int channel = dsi.update_channel;
 	bool use_te_trigger;
 
 	use_te_trigger = dsi.te_enabled && !dsi.use_ext_te;
@@ -2935,13 +2938,15 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 EXPORT_SYMBOL(omap_dsi_prepare_update);
 
 int omap_dsi_update(struct omap_dss_device *dssdev,
+		int channel,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(int, void *), void *data)
 {
+	dsi.update_channel = channel;
+
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 		dsi.framedone_callback = callback;
 		dsi.framedone_data = data;
-		dsi_vc_config_vp(0);
 
 		dsi.update_region.x = x;
 		dsi.update_region.y = y;
-- 
1.6.5

