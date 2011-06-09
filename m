From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 02/28] OMAP: DSS2: Taal: Make driver more fault tolerant
Date: Thu,  9 Jun 2011 16:56:24 +0300
Message-ID: <1307627810-3768-3-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45392 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757817Ab1FIN5I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:08 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

If ULPS exit fails, and the following reset fails also, Taal driver was
left in state where it thinks DSI is enabled while it really isn't,
leading to crash.

This patch checks the return value of taal_panel_reset, and if that
fails, ulps_enabled is left true, causing the driver to retry ulps exit
later.

Also the return value of taal_wake_up is checked at taal_disable, and if
wake up fails, we'll skip the power_off. This could leave the panel into
a not-quite-valid state, but there's nothing we can do about it in that
situation.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   33 ++++++++++++++++++----------
 1 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index fdd5d4ae..b82bcc1 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -504,14 +504,18 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 		return 0;
 
 	r = omapdss_dsi_display_enable(dssdev);
-	if (r)
-		goto err;
+	if (r) {
+		dev_err(&dssdev->dev, "failed to enable DSI\n");
+		goto err1;
+	}
 
 	omapdss_dsi_vc_enable_hs(dssdev, td->channel, true);
 
 	r = _taal_enable_te(dssdev, true);
-	if (r)
-		goto err;
+	if (r) {
+		dev_err(&dssdev->dev, "failed to re-enable TE");
+		goto err2;
+	}
 
 	enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
 
@@ -521,13 +525,15 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 
 	return 0;
 
-err:
-	dev_err(&dssdev->dev, "exit ULPS failed");
-	r = taal_panel_reset(dssdev);
-
-	enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
-	td->ulps_enabled = false;
+err2:
+	dev_err(&dssdev->dev, "failed to exit ULPS");
 
+	r = taal_panel_reset(dssdev);
+	if (!r) {
+		enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+		td->ulps_enabled = false;
+	}
+err1:
 	taal_queue_ulps_work(dssdev);
 
 	return r;
@@ -1317,8 +1323,11 @@ static void taal_disable(struct omap_dss_device *dssdev)
 	dsi_bus_lock(dssdev);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-		taal_wake_up(dssdev);
-		taal_power_off(dssdev);
+		int r;
+
+		r = taal_wake_up(dssdev);
+		if (!r)
+			taal_power_off(dssdev);
 	}
 
 	dsi_bus_unlock(dssdev);
-- 
1.7.4.1

