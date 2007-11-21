From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/3] ARM: OMAP1: Camera: Fix v4l2 int device detach
Date: Wed, 21 Nov 2007 18:23:04 -0400
Message-ID: <1195683785-32132-3-git-send-email-edubezval@gmail.com>
References: <1195683785-32132-1-git-send-email-edubezval@gmail.com>
	<1195683785-32132-2-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1195683785-32132-2-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

camera_device_unregister expected the argument to be its own
device structure but it's actually that of its slave.

Also get master from slave's structure in camera_device_register.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/omap/camera_core.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 6e5d8bd..be033be 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -1007,17 +1007,16 @@ static ssize_t camera_streaming_show(struct device *dev,
 
 static DEVICE_ATTR(streaming, S_IRUGO, camera_streaming_show, NULL);
 
-static void camera_device_unregister(struct v4l2_int_device *ctl)
+static void camera_device_unregister(struct v4l2_int_device *s)
 {
-	struct camera_device *cam = ctl->priv;
+	struct camera_device *cam = s->u.slave->master->priv;
 
 	camera_sensor_exit(cam);
 }
 
-static int camera_device_register(struct v4l2_int_device *ctl,
-				  struct v4l2_int_device *s)
+static int camera_device_register(struct v4l2_int_device *s)
 {
-	struct camera_device *cam = ctl->priv;
+	struct camera_device *cam = s->u.slave->master->priv;
 	struct video_device *vfd;
 	int rval;
 
@@ -1092,7 +1091,7 @@ static int camera_device_register(struct v4l2_int_device *ctl,
 	return 0;
 
 err:
-	camera_device_unregister(ctl);
+	camera_device_unregister(s);
 
 	return rval;
 }
-- 
1.5.3.4.206.g58ba4
