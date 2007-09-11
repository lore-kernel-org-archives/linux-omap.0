From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH 1/1] Export v4l2_int_device_{, un}register
Date: Tue, 11 Sep 2007 15:46:34 +0300
Message-ID: <11895147942548-git-send-email-sakari.ailus@nokia.com>
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
Cc: Adrian Bunk <bunk@stusta.de>
List-Id: linux-omap@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

This patch fixes the following build error:

<--  snip  -->

...
  MODPOST 2135 modules
make[2]: *** [__modpost] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/v4l2-int-device.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/v4l2-int-device.c b/drivers/media/video/v4l2-int-device.c
index 4ff17e3..f497c94 100644
--- a/drivers/media/video/v4l2-int-device.c
+++ b/drivers/media/video/v4l2-int-device.c
@@ -101,6 +101,7 @@ int v4l2_int_device_register(struct v4l2_int_device *d)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(v4l2_int_device_register);
 
 void v4l2_int_device_unregister(struct v4l2_int_device *d)
 {
@@ -114,6 +115,7 @@ void v4l2_int_device_unregister(struct v4l2_int_device *d)
 	}
 	mutex_unlock(&mutex);
 }
+EXPORT_SYMBOL_GPL(v4l2_int_device_unregister);
 
 /* Adapted from search_extable in extable.c. */
 static v4l2_int_ioctl_func *find_ioctl(struct v4l2_int_slave *slave, int cmd,
-- 
1.5.0.6
