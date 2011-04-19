From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/19] OMAP: DSS2: Taal: Rename esd_wq to workqueue
Date: Tue, 19 Apr 2011 12:22:21 +0300
Message-ID: <1303204942-25450-19-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58818 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753237Ab1DSJXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:09 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

ESD workqueue will be shared with other functionality also. Rename
"esd_wq" to "workqueue" to better reflect its usage.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 2f7a223..9626e49 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -227,7 +227,8 @@ struct taal_data {
 
 	bool intro_printed;
 
-	struct workqueue_struct *esd_wq;
+	struct workqueue_struct *workqueue;
+
 	struct delayed_work esd_work;
 	unsigned esd_interval;
 
@@ -425,7 +426,7 @@ static void taal_queue_esd_work(struct omap_dss_device *dssdev)
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 
 	if (td->esd_interval > 0)
-		queue_delayed_work(td->esd_wq, &td->esd_work,
+		queue_delayed_work(td->workqueue, &td->esd_work,
 				msecs_to_jiffies(td->esd_interval));
 }
 
@@ -768,8 +769,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_reg;
 
-	td->esd_wq = create_singlethread_workqueue("taal_esd");
-	if (td->esd_wq == NULL) {
+	td->workqueue = create_singlethread_workqueue("taal_esd");
+	if (td->workqueue == NULL) {
 		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
 		r = -ENOMEM;
 		goto err_wq;
@@ -868,7 +869,7 @@ err_irq:
 err_gpio:
 	backlight_device_unregister(bldev);
 err_bl:
-	destroy_workqueue(td->esd_wq);
+	destroy_workqueue(td->workqueue);
 err_wq:
 	free_regulators(panel_config->regulators, panel_config->num_regulators);
 err_reg:
@@ -900,7 +901,7 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	backlight_device_unregister(bldev);
 
 	taal_cancel_esd_work(dssdev);
-	destroy_workqueue(td->esd_wq);
+	destroy_workqueue(td->workqueue);
 
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
-- 
1.7.1

