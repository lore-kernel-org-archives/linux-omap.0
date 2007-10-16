From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Fix v4l2 int device detach
Date: Tue, 16 Oct 2007 18:08:28 +0300
Message-ID: <1192547308415-git-send-email-sakari.ailus@nokia.com>
References: <11925473082391-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11925473082391-git-send-email-sakari.ailus@nokia.com>
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
List-Id: linux-omap@vger.kernel.org

omap24xxcam_device_unregister expected the argument to be its own
device structure but it's actually that of its slave.

Also get master from slave's structure in omap24xxcam_device_register.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap24xxcam.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 7da1668..8fda9e1 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -46,7 +46,7 @@
 
 static void omap24xxcam_reset(struct omap24xxcam_device *cam);
 static int omap24xxcam_sensor_if_enable(struct omap24xxcam_device *cam);
-static void omap24xxcam_device_unregister(struct v4l2_int_device *ctl);
+static void omap24xxcam_device_unregister(struct v4l2_int_device *s);
 static int omap24xxcam_remove(struct platform_device *pdev);
 
 /* module parameters */
@@ -1603,10 +1603,9 @@ static int omap24xxcam_resume(struct platform_device *pdev)
  *
  */
 
-static int omap24xxcam_device_register(struct v4l2_int_device *ctl,
-				       struct v4l2_int_device *s)
+static int omap24xxcam_device_register(struct v4l2_int_device *s)
 {
-	struct omap24xxcam_device *cam = ctl->priv;
+	struct omap24xxcam_device *cam = s->u.slave->master->priv;
 	struct video_device *vfd;
 	int rval;
 
@@ -1681,14 +1680,14 @@ static int omap24xxcam_device_register(struct v4l2_int_device *ctl,
 	return 0;
 
 err:
-	omap24xxcam_device_unregister(ctl);
+	omap24xxcam_device_unregister(s);
 
 	return rval;
 }
 
-static void omap24xxcam_device_unregister(struct v4l2_int_device *ctl)
+static void omap24xxcam_device_unregister(struct v4l2_int_device *s)
 {
-	struct omap24xxcam_device *cam = ctl->priv;
+	struct omap24xxcam_device *cam = s->u.slave->master->priv;
 
 	omap24xxcam_sensor_exit(cam);
 
-- 
1.5.0.6
