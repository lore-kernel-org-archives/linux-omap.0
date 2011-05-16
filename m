From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/4] OMAP: DSS2: DSI: Use system workqueue for delayed work instead of a private workqueue
Date: Mon, 16 May 2011 15:17:07 +0530
Message-ID: <1305539229-28560-3-git-send-email-archit@ti.com>
References: <1305539229-28560-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53157 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974Ab1EPJmX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 05:42:23 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gMBP027238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:22 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gMKX010452
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:22 -0500 (CDT)
In-Reply-To: <1305539229-28560-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In the previous DSI driver design, a private workqueue was needed to prevent a
deadlock as explained in the commit : 0f16aa0ae6b84d7ae72fbe8999e6a94cb78edd4e
. In the current design, the workqueue is only used for queueing delayed work in
the case where we don't get a FRAMEDONE interrupt for 250 milliseconds. It is
safe to remove the private workqueue amd use the system workqueue instead to
schedule the delayed work with the new design where the deadlock can't occur.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 091b318..f04244b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -294,8 +294,6 @@ struct dsi_data {
 	bool te_enabled;
 	bool ulps_enabled;
 
-	struct workqueue_struct *workqueue;
-
 	void (*framedone_callback)(int, void *);
 	void *framedone_data;
 
@@ -3753,8 +3751,8 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 
 	dsi_perf_mark_start(dsidev);
 
-	r = queue_delayed_work(dsi->workqueue, &dsi->framedone_timeout_work,
-			msecs_to_jiffies(250));
+	r = schedule_delayed_work(&dsi->framedone_timeout_work,
+		msecs_to_jiffies(250));
 	BUG_ON(r == 0);
 
 	dss_start_update(dssdev);
@@ -4369,12 +4367,6 @@ static int dsi_init(struct platform_device *dsidev)
 	mutex_init(&dsi->lock);
 	sema_init(&dsi->bus_lock, 1);
 
-	dsi->workqueue = create_singlethread_workqueue(dev_name(&dsidev->dev));
-	if (dsi->workqueue == NULL) {
-		r = -ENOMEM;
-		goto err1;
-	}
-
 	INIT_DELAYED_WORK_DEFERRABLE(&dsi->framedone_timeout_work,
 			dsi_framedone_timeout_work_callback);
 
@@ -4387,26 +4379,26 @@ static int dsi_init(struct platform_device *dsidev)
 	if (!dsi_mem) {
 		DSSERR("can't get IORESOURCE_MEM DSI\n");
 		r = -EINVAL;
-		goto err2;
+		goto err1;
 	}
 	dsi->base = ioremap(dsi_mem->start, resource_size(dsi_mem));
 	if (!dsi->base) {
 		DSSERR("can't ioremap DSI\n");
 		r = -ENOMEM;
-		goto err2;
+		goto err1;
 	}
 	dsi->irq = platform_get_irq(dsi->pdev, 0);
 	if (dsi->irq < 0) {
 		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
-		goto err3;
+		goto err2;
 	}
 
 	r = request_irq(dsi->irq, omap_dsi_irq_handler, IRQF_SHARED,
 		dev_name(&dsidev->dev), dsi->pdev);
 	if (r < 0) {
 		DSSERR("request_irq failed\n");
-		goto err3;
+		goto err2;
 	}
 
 	/* DSI VCs initialization */
@@ -4427,10 +4419,8 @@ static int dsi_init(struct platform_device *dsidev)
 	enable_clocks(0);
 
 	return 0;
-err3:
-	iounmap(dsi->base);
 err2:
-	destroy_workqueue(dsi->workqueue);
+	iounmap(dsi->base);
 err1:
 	kfree(dsi);
 err0:
@@ -4454,7 +4444,6 @@ static void dsi_exit(struct platform_device *dsidev)
 	free_irq(dsi->irq, dsi->pdev);
 	iounmap(dsi->base);
 
-	destroy_workqueue(dsi->workqueue);
 	kfree(dsi);
 
 	DSSDBG("omap_dsi_exit\n");
-- 
1.7.1

