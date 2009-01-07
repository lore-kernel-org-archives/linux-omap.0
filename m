From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 2/2] OMAP3: CAM: PM: Set VPP constraints
Date: Tue, 6 Jan 2009 19:06:07 -0600
Message-ID: <A24693684029E5489D1D202277BE8944163282D8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36751 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbZAGBGP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 20:06:15 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n07169l4023988
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 19:06:14 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n07169GU021107
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 19:06:09 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 5d1e1906aa378df94e5934b34f310a94edea7cd4 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 18:43:41 -0600
Subject: [PATCH] OMAP3: CAM: PM: Set VPP constraints

This patch is for making camera work as expected when TI PM is enabled.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/omap34xxcam.c |   72 +++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/omap34xxcam.c b/drivers/media/video/omap34xxcam.c
index 7fe3981..04001ea 100755
--- a/drivers/media/video/omap34xxcam.c
+++ b/drivers/media/video/omap34xxcam.c
@@ -44,12 +44,35 @@
 /* global variables */
 static struct omap34xxcam_device *omap34xxcam;
 
+#ifdef CONFIG_OMAP3430_ES2
+	struct constraint_handle *co_opp_camera_vdd1;
+	struct constraint_handle *co_opp_camera_vdd2;
+	struct constraint_handle *co_opp_camera_latency;
+#endif
+
 /* module parameters */
 static int omap34xxcam_device_register(struct v4l2_int_device *s);
 static void omap34xxcam_device_unregister(struct v4l2_int_device *s);
 static int omap34xxcam_remove(struct platform_device *pdev);
 struct omap34xxcam_fh *camfh_saved;
 
+/* constraint */
+#ifdef CONFIG_OMAP3430_ES2
+	static struct constraint_id cnstr_id_vdd1 = {
+		.type = RES_OPP_CO,
+		.data = (void *)"vdd1_opp",
+	};
+
+	static struct constraint_id cnstr_id_vdd2 = {
+		.type = RES_OPP_CO,
+		.data = (void *)"vdd2_opp",
+	};
+
+	static struct constraint_id cnstr_id_latency = {
+		.type = RES_LATENCY_CO,
+		.data = (void *)"latency",
+	};
+#endif
 /*
  *
  * Sensor handling.
@@ -697,6 +720,17 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 	isph3a_notify(0);
 	isp_af_notify(0);
 	isp_sgdma_init();
+
+#ifdef CONFIG_OMAP3430_ES2
+	if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
+		/* Setting constraint for VDD1 */
+		constraint_set(co_opp_camera_vdd1, CO_VDD1_OPP3);
+	}
+	/* Setting constraint for VDD2 */
+	constraint_set(co_opp_camera_vdd2, CO_VDD2_OPP3);
+	constraint_set(co_opp_camera_latency, CO_LATENCY_WFI);
+#endif
+
 	rval = videobuf_streamon(&ofh->vbq);
 	if (rval) {
 		dev_dbg(vdev->cam->dev, "omap34xxcam_slave_power_set failed\n");
@@ -746,6 +780,16 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
 
+#ifdef CONFIG_OMAP3430_ES2
+	if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
+		/* Removing constraint for VDD1 */
+		constraint_remove(co_opp_camera_vdd1);
+	}
+	/* Removing constraint for VDD2 */
+	constraint_remove(co_opp_camera_vdd2);
+	constraint_remove(co_opp_camera_latency);
+#endif
+
 	mutex_unlock(&vdev->mutex);
 
 	return rval;
@@ -1384,6 +1428,7 @@ static int omap34xxcam_release(struct inode *inode, struct file *file)
 {
 	struct omap34xxcam_fh *fh = file->private_data;
 	struct omap34xxcam_videodev *vdev = fh->vdev;
+	int remove_constraints = 0;
 	int i;
 
 	mutex_lock(&vdev->mutex);
@@ -1394,6 +1439,7 @@ static int omap34xxcam_release(struct inode *inode, struct file *file)
 		videobuf_streamoff(&fh->vbq);
 		omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
 		vdev->streaming = NULL;
+		remove_constraints = 1;
 	}
 
 	if (atomic_dec_return(&vdev->users) == 0) {
@@ -1402,6 +1448,18 @@ static int omap34xxcam_release(struct inode *inode, struct file *file)
 	}
 	mutex_unlock(&vdev->mutex);
 
+#ifdef CONFIG_OMAP3430_ES2
+	if (remove_constraints) {
+		if (fh->pix.width >= 640 && fh->pix.height >= 480) {
+			/* Removing constraint for VDD1 */
+			constraint_remove(co_opp_camera_vdd1);
+		}
+		/* Removing constraint for VDD2 */
+		constraint_remove(co_opp_camera_vdd2);
+		constraint_remove(co_opp_camera_latency);
+	}
+#endif
+
 	file->private_data = NULL;
 
 	for (i = 0; i <= OMAP34XXCAM_SLAVE_FLASH; i++)
@@ -1760,6 +1818,14 @@ static int omap34xxcam_probe(struct platform_device *pdev)
 
 	omap34xxcam = cam;
 
+#ifdef CONFIG_OMAP3430_ES2
+	/* Getting constraint for VDD1 and VDD2 */
+	co_opp_camera_latency = constraint_get("omap34xxcam",
+							&cnstr_id_latency);
+	co_opp_camera_vdd1 = constraint_get("omap34xxcam", &cnstr_id_vdd1);
+	co_opp_camera_vdd2 = constraint_get("omap34xxcam", &cnstr_id_vdd2);
+#endif
+
 	return 0;
 
 err:
@@ -1804,6 +1870,12 @@ static int omap34xxcam_remove(struct platform_device *pdev)
 		cam->mmio_base_phys = 0;
 	}
 
+#ifdef CONFIG_OMAP3430_ES2
+	constraint_put(co_opp_camera_vdd1);
+	constraint_put(co_opp_camera_vdd2);
+	constraint_put(co_opp_camera_latency);
+#endif
+
 	kfree(cam);
 
 	return 0;
-- 
1.5.6.5

