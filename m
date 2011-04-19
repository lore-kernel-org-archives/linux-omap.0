From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/19] OMAP: DSS2: Taal: Clean up ESD queueing
Date: Tue, 19 Apr 2011 12:22:18 +0300
Message-ID: <1303204942-25450-16-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47741 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754512Ab1DSJXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:06 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate the code which queues/cancels ESD work into their own
functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   36 ++++++++++++++++++----------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index cdb28a8..2787a51 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -420,6 +420,22 @@ static int taal_set_update_window(struct taal_data *td,
 	return r;
 }
 
+static void taal_queue_esd_work(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	if (td->esd_interval > 0)
+		queue_delayed_work(td->esd_wq, &td->esd_work,
+				msecs_to_jiffies(td->esd_interval));
+}
+
+static void taal_cancel_esd_work(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	cancel_delayed_work(&td->esd_work);
+}
+
 static int taal_bl_update_status(struct backlight_device *dev)
 {
 	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
@@ -841,7 +857,7 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	taal_bl_update_status(bldev);
 	backlight_device_unregister(bldev);
 
-	cancel_delayed_work(&td->esd_work);
+	taal_cancel_esd_work(dssdev);
 	destroy_workqueue(td->esd_wq);
 
 	/* reset, to be sure that the panel is in a valid state */
@@ -983,9 +999,7 @@ static int taal_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	if (td->esd_interval > 0)
-		queue_delayed_work(td->esd_wq, &td->esd_work,
-				msecs_to_jiffies(td->esd_interval));
+	taal_queue_esd_work(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -1006,7 +1020,7 @@ static void taal_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&td->lock);
 
-	cancel_delayed_work(&td->esd_work);
+	taal_cancel_esd_work(dssdev);
 
 	dsi_bus_lock();
 
@@ -1034,7 +1048,7 @@ static int taal_suspend(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	cancel_delayed_work(&td->esd_work);
+	taal_cancel_esd_work(dssdev);
 
 	dsi_bus_lock();
 
@@ -1076,9 +1090,7 @@ static int taal_resume(struct omap_dss_device *dssdev)
 		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 	} else {
 		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-		if (td->esd_interval > 0)
-			queue_delayed_work(td->esd_wq, &td->esd_work,
-					msecs_to_jiffies(td->esd_interval));
+		taal_queue_esd_work(dssdev);
 	}
 
 	mutex_unlock(&td->lock);
@@ -1521,8 +1533,7 @@ static void taal_esd_work(struct work_struct *work)
 
 	dsi_bus_unlock();
 
-	queue_delayed_work(td->esd_wq, &td->esd_work,
-		       msecs_to_jiffies(td->esd_interval));
+	taal_queue_esd_work(dssdev);
 
 	mutex_unlock(&td->lock);
 	return;
@@ -1535,8 +1546,7 @@ err:
 
 	dsi_bus_unlock();
 
-	queue_delayed_work(td->esd_wq, &td->esd_work,
-		       msecs_to_jiffies(td->esd_interval));
+	taal_queue_esd_work(dssdev);
 
 	mutex_unlock(&td->lock);
 }
-- 
1.7.1

