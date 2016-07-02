From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] fbdev: Remove deprecated create_singlethread_workqueue
Date: Sat, 2 Jul 2016 14:09:23 +0530
Message-ID: <20160702083923.GA27352@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tejun Heo <tj@kernel.org>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The workqueue "esd_wq" has only a single workitem(&md->esd_work)
and hence doesn't require ordering. Also, it is not being used on a
memory reclaim path. Hence, the singlethreaded workqueue has been
replaced with the use of system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

mipid_esd_stop_check () calls cancel_delayed_work() in mipid_cleanup()
to ensure that there are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index 0e4cee9..c81f150 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -60,7 +60,6 @@ struct mipid_device {
 	struct mutex		mutex;
 	struct lcd_panel	panel;

-	struct workqueue_struct	*esd_wq;
 	struct delayed_work	esd_work;
 	void			(*esd_check)(struct mipid_device *m);
 };
@@ -390,7 +389,7 @@ static void ls041y3_esd_check(struct mipid_device *md)
 static void mipid_esd_start_check(struct mipid_device *md)
 {
 	if (md->esd_check != NULL)
-		queue_delayed_work(md->esd_wq, &md->esd_work,
+		schedule_delayed_work(&md->esd_work,
 				   MIPID_ESD_CHECK_PERIOD);
 }

@@ -476,11 +475,6 @@ static int mipid_init(struct lcd_panel *panel,
 	struct mipid_device *md = to_mipid_device(panel);

 	md->fbdev = fbdev;
-	md->esd_wq = create_singlethread_workqueue("mipid_esd");
-	if (md->esd_wq == NULL) {
-		dev_err(&md->spi->dev, "can't create ESD workqueue\n");
-		return -ENOMEM;
-	}
 	INIT_DELAYED_WORK(&md->esd_work, mipid_esd_work);
 	mutex_init(&md->mutex);

@@ -500,7 +494,6 @@ static void mipid_cleanup(struct lcd_panel *panel)

 	if (md->enabled)
 		mipid_esd_stop_check(md);
-	destroy_workqueue(md->esd_wq);
 }

 static struct lcd_panel mipid_panel = {
--
2.1.4
