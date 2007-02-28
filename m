From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Adapt to 2.6.20.
Date: Wed, 28 Feb 2007 17:59:16 +0200
Message-ID: <1172678356543-git-send-email-sakari.ailus@nokia.com>
References: <45E5A489.2040108@nokia.com>
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
	<11726783562842-git-send-email-sakari.ailus@nokia.com>
	<11726783561918-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11726783561918-git-send-email-sakari.ailus@nokia.com>
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

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap/omap24xxcam-sensor.c |    6 ++++--
 drivers/media/video/omap/omap24xxcam.c        |   12 +++++++-----
 drivers/media/video/omap/omap24xxcam.h        |    2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/video/omap/omap24xxcam-sensor.c b/drivers/media/video/omap/omap24xxcam-sensor.c
index bde7429..3f1ab05 100644
--- a/drivers/media/video/omap/omap24xxcam-sensor.c
+++ b/drivers/media/video/omap/omap24xxcam-sensor.c
@@ -132,9 +132,11 @@ void omap24xxcam_sensor_disable(struct omap24xxcam_device *cam)
 		cam->sensor->power_off(cam->sensor);
 }
 
-void omap24xxcam_sensor_reset_work(void * data)
+void omap24xxcam_sensor_reset_work(struct work_struct *work)
 {
-	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;
+	struct omap24xxcam_device *cam =
+		container_of(work, struct omap24xxcam_device,
+			     sensor_reset_work);
 	
 	omap24xxcam_sensor_disable(cam);
 
diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
index 4f954ed..c8f1b74 100644
--- a/drivers/media/video/omap/omap24xxcam.c
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -148,9 +148,11 @@ static void omap24xxcam_reset_timer(unsigned long data)
 	omap24xxcam_camera_reset_schedule(cam);
 }
 
-void omap24xxcam_camera_reset_work(void * data)
+void omap24xxcam_camera_reset_work(struct work_struct *work)
 {
-	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;
+	struct omap24xxcam_device *cam =
+		container_of(work, struct omap24xxcam_device,
+			     sensor_reset_work);
 
 	/* Disable and reset the camera interface. */
 	omap24xxcam_core_disable(&cam->core);
@@ -190,7 +192,7 @@ void omap24xxcam_camera_reset_schedule(struct omap24xxcam_device *cam)
 	schedule_work(&cam->camera_reset_work);
 }
 
-static irqreturn_t omap24xxcam_isr(int irq, void *arg, struct pt_regs *regs)
+static irqreturn_t omap24xxcam_isr(int irq, void *arg)
 {
 	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)arg;
 	unsigned long irqstatus;
@@ -1061,9 +1063,9 @@ static int omap24xxcam_probe(struct platform_device *pdev)
 	cam->sgdma.reset_timer.function = omap24xxcam_reset_timer;
 	cam->sgdma.reset_timer.data = (unsigned long)cam;
 	INIT_WORK(&cam->camera_reset_work,
-		  omap24xxcam_camera_reset_work, cam);
+		  omap24xxcam_camera_reset_work);
 	INIT_WORK(&cam->sensor_reset_work,
-		  omap24xxcam_sensor_reset_work, cam);
+		  omap24xxcam_sensor_reset_work);
 
 	/* initialize the spinlock used to serialize access to the image 
 	 * parameters
diff --git a/drivers/media/video/omap/omap24xxcam.h b/drivers/media/video/omap/omap24xxcam.h
index eba5ea6..9defee3 100644
--- a/drivers/media/video/omap/omap24xxcam.h
+++ b/drivers/media/video/omap/omap24xxcam.h
@@ -615,7 +615,7 @@ int omap24xxcam_sensor_init(struct omap24xxcam_device *cam);
 void omap24xxcam_sensor_exit(struct omap24xxcam_device *cam);
 int omap24xxcam_sensor_enable(struct omap24xxcam_device *cam);
 void omap24xxcam_sensor_disable(struct omap24xxcam_device *cam);
-void omap24xxcam_sensor_reset_work(void * data);
+void omap24xxcam_sensor_reset_work(struct work_struct *work);
 void omap24xxcam_sensor_reset_schedule(struct omap_camera *oc,
 				       struct omap_camera_sensor *os);
 unsigned long omap24xxcam_sensor_calc_xclk(struct omap24xxcam_device *cam,
-- 
1.5.0.1
