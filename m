From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/19] OMAP: DSS2: Taal: Separate panel reset
Date: Tue, 19 Apr 2011 12:22:20 +0300
Message-ID: <1303204942-25450-18-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57029 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754491Ab1DSJXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:07 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate panel reset code to a function of its own. This will keep the
code cleaner in the future when panel reset is called from multiple
locations.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 3192dd7..2f7a223 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1018,6 +1018,15 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	td->enabled = 0;
 }
 
+static int taal_panel_reset(struct omap_dss_device *dssdev)
+{
+	dev_err(&dssdev->dev, "performing LCD reset\n");
+
+	taal_power_off(dssdev);
+	taal_hw_reset(dssdev);
+	return taal_power_on(dssdev);
+}
+
 static int taal_enable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
@@ -1582,9 +1591,7 @@ static void taal_esd_work(struct work_struct *work)
 err:
 	dev_err(&dssdev->dev, "performing LCD reset\n");
 
-	taal_power_off(dssdev);
-	taal_hw_reset(dssdev);
-	taal_power_on(dssdev);
+	taal_panel_reset(dssdev);
 
 	dsi_bus_unlock();
 
-- 
1.7.1

