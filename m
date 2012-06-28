From: Archit Taneja <archit@ti.com>
Subject: [PATCH 11/12] OMAPDSS: RFBI: Use dss_mgr_enable to enable the overlay manager
Date: Thu, 28 Jun 2012 20:00:41 +0530
Message-ID: <1340893842-10626-13-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab2F1Ocw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:32:52 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The RFBI driver uses a direct DISPC register write to enable the overlay
manager. Replace this with dss_mgr_enable() which checks if the connected
overlay and managers are correctly configured, and configure DSS for
fifomerge.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 0376056..8c5d5df 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -300,10 +300,11 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
+static int rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 		u16 height, void (*callback)(void *data), void *data)
 {
 	u32 l;
+	int r;
 	struct omap_video_timings timings = {
 		.hsw		= 1,
 		.hfp		= 1,
@@ -322,7 +323,9 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 
 	dss_mgr_set_timings(dssdev->manager, &timings);
 
-	dispc_mgr_enable(dssdev->manager->id, true);
+	r = dss_mgr_enable(dssdev->manager);
+	if (r)
+		return r;
 
 	rfbi.framedone_callback = callback;
 	rfbi.framedone_callback_data = data;
@@ -335,6 +338,8 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 		l = FLD_MOD(l, 1, 4, 4); /* ITE */
 
 	rfbi_write_reg(RFBI_CONTROL, l);
+
+	return 0;
 }
 
 static void framedone_callback(void *data, u32 mask)
@@ -814,8 +819,11 @@ int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data)
 {
-	rfbi_transfer_area(dssdev, w, h, callback, data);
-	return 0;
+	int r;
+
+	r = rfbi_transfer_area(dssdev, w, h, callback, data);
+
+	return r;
 }
 EXPORT_SYMBOL(omap_rfbi_update);
 
-- 
1.7.9.5

