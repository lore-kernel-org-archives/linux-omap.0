From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] omapfb: omapfb-main: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 2 Jul 2016 14:00:56 +0530
Message-ID: <20160702083056.GA26936@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The workqueue auto_update_work is involved in auto updating mode for
manual-update displays. omapfb driver uses a delayed work item to update
the display at a constant rate.

Since these long-running work items aren't involved in memory reclaim in
any way, system_long_wq has been used.

Work item has been sync cancelled in omapfb_stop_auto_update() which gets
called in omapfb_free_resources() to ensure that nothing is pending when
the driver is disconnected.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 23 +----------------------
 drivers/video/fbdev/omap2/omapfb/omapfb.h      |  1 -
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index d3af01c..5c6eec7 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1693,8 +1693,7 @@ static void omapfb_auto_update_work(struct work_struct *work)
 	freq = auto_update_freq;
 	if (freq == 0)
 		freq = 20;
-	queue_delayed_work(fbdev->auto_update_wq,
-			&d->auto_update_work, HZ / freq);
+	queue_delayed_work(system_long_wq, &d->auto_update_work, HZ / freq);
 }

 void omapfb_start_auto_update(struct omapfb2_device *fbdev,
@@ -1702,20 +1701,6 @@ void omapfb_start_auto_update(struct omapfb2_device *fbdev,
 {
 	struct omapfb_display_data *d;

-	if (fbdev->auto_update_wq == NULL) {
-		struct workqueue_struct *wq;
-
-		wq = create_singlethread_workqueue("omapfb_auto_update");
-
-		if (wq == NULL) {
-			dev_err(fbdev->dev, "Failed to create workqueue for "
-					"auto-update\n");
-			return;
-		}
-
-		fbdev->auto_update_wq = wq;
-	}
-
 	d = get_display_data(fbdev, display);

 	INIT_DELAYED_WORK(&d->auto_update_work, omapfb_auto_update_work);
@@ -1867,12 +1852,6 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 		omap_dss_put_device(dssdev);
 	}

-	if (fbdev->auto_update_wq != NULL) {
-		flush_workqueue(fbdev->auto_update_wq);
-		destroy_workqueue(fbdev->auto_update_wq);
-		fbdev->auto_update_wq = NULL;
-	}
-
 	dev_set_drvdata(fbdev->dev, NULL);
 }

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb.h b/drivers/video/fbdev/omap2/omapfb/omapfb.h
index 623cd87..ff0cf79 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb.h
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb.h
@@ -106,7 +106,6 @@ struct omapfb2_device {
 	unsigned num_managers;
 	struct omap_overlay_manager *managers[10];

-	struct workqueue_struct *auto_update_wq;
 };

 struct omapfb_colormode {
--
2.1.4
