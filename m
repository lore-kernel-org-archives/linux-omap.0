From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP 2: Camera: Fix device release
Date: Tue,  4 Dec 2007 17:48:59 +0200
Message-ID: <11967833392684-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If streaming wasn't stopped before a file handle was closed,
videobuf_streamoff got called after cam->streaming had been set NULL,
causing an oops. Call videobuf_streamoff a bit earlier instead.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap24xxcam.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index d394eab..96f4885 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -1510,12 +1510,13 @@ static int omap24xxcam_release(struct inode *inode, struct file *file)
 
 	flush_scheduled_work();
 
-	mutex_lock(&cam->mutex);
 	/* stop streaming capture */
+	videobuf_streamoff(&fh->vbq);
+
+	mutex_lock(&cam->mutex);
 	if (cam->streaming == file) {
 		cam->streaming = NULL;
 		mutex_unlock(&cam->mutex);
-		videobuf_streamoff(&fh->vbq);
 		sysfs_notify(&cam->dev->kobj, NULL, "streaming");
 	} else {
 		mutex_unlock(&cam->mutex);
-- 
1.5.0.6
