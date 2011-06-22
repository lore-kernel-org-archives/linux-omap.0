From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: DSI: sync when disabling a display
Date: Wed, 22 Jun 2011 11:45:25 +0300
Message-ID: <1308732326-17278-4-git-send-email-tomi.valkeinen@ti.com>
References: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57178 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184Ab1FVIpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 04:45:50 -0400
In-Reply-To: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When the panel driver calls omapdss_dsi_display_disable() it is possible
that there are still some unsent packets in the TX fifo.

Add dsi_sync_vc() calls in the beginning of
omapdss_dsi_display_disable() to make sure the TX fifos are empty.

This allows us to remove the msleep(10) hack from panel-taal.c

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    5 +----
 drivers/video/omap2/dss/dsi.c             |    5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 4cb0449..4e888ac 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1247,11 +1247,8 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	int r;
 
 	r = taal_dcs_write_0(td, DCS_DISPLAY_OFF);
-	if (!r) {
+	if (!r)
 		r = taal_sleep_in(td);
-		/* HACK: wait a bit so that the message goes through */
-		msleep(10);
-	}
 
 	if (r) {
 		dev_err(&dssdev->dev,
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b6a57bb..62b11c5 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4263,6 +4263,11 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 
 	mutex_lock(&dsi->lock);
 
+	dsi_sync_vc(dsidev, 0);
+	dsi_sync_vc(dsidev, 1);
+	dsi_sync_vc(dsidev, 2);
+	dsi_sync_vc(dsidev, 3);
+
 	dsi_display_uninit_dispc(dssdev);
 
 	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
-- 
1.7.4.1

