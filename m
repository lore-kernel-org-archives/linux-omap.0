From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 6/7] OMAP3: CAM: Lens position fix
Date: Tue, 6 Jan 2009 14:42:06 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328063@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59723 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbZAFUmO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:42:14 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06Kg8ht004983
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:13 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06Kg8Vj007733
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:08 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 21157b257c091404b34b97fc08299c5009c86238 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:17:34 -0600
Subject: [PATCH] OMAP3: CAM: Lens position fix

This change is to set the default value of the lens as INFINITE
position and set it each time the camera is opened also is to
keep the last value of the lens position after stream off call.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/dw9710.c      |    4 +++-
 drivers/media/video/omap34xxcam.c |    8 ++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 drivers/media/video/dw9710.c
 mode change 100644 => 100755 drivers/media/video/omap34xxcam.c

diff --git a/drivers/media/video/dw9710.c b/drivers/media/video/dw9710.c
old mode 100644
new mode 100755
index 9bcc904..60350df
--- a/drivers/media/video/dw9710.c
+++ b/drivers/media/video/dw9710.c
@@ -31,6 +31,7 @@
 static int
 dw9710_probe(struct i2c_client *client, const struct i2c_device_id *id);
 static int __exit dw9710_remove(struct i2c_client *client);
+int position_global;
 
 struct dw9710_device {
 	const struct dw9710_platform_data *pdata;
@@ -266,6 +267,7 @@ int dw9710_af_setfocus(u16 posn)
 	if (ret)
 		printk(KERN_ERR "Setfocus register write failed\n");
 	dw9710.current_lens_posn = posn;
+	position_global = dw9710.current_lens_posn;
 	return ret;
 }
 EXPORT_SYMBOL(dw9710_af_setfocus);
@@ -437,7 +439,7 @@ static int ioctl_s_power(struct v4l2_int_device *s, enum v4l2_power on)
 
 	if ((lens->power_state == V4L2_POWER_STANDBY) && (on == V4L2_POWER_ON)
 					&& (lens->state == LENS_DETECTED))
-		dw9710_af_setfocus(lens->current_lens_posn);
+		dw9710_af_setfocus(position_global);
 
 	lens->power_state = on;
 	return 0;
diff --git a/drivers/media/video/omap34xxcam.c b/drivers/media/video/omap34xxcam.c
old mode 100644
new mode 100755
index f14a531..7fe3981
--- a/drivers/media/video/omap34xxcam.c
+++ b/drivers/media/video/omap34xxcam.c
@@ -1286,6 +1286,7 @@ static int omap34xxcam_open(struct inode *inode, struct file *file)
 	struct omap34xxcam_device *cam = omap34xxcam;
 	struct omap34xxcam_fh *fh;
 	struct v4l2_format format;
+	struct v4l2_control vc;
 	int i;
 
 	for (i = 0; i < OMAP34XXCAM_VIDEODEVS; i++) {
@@ -1310,6 +1311,13 @@ static int omap34xxcam_open(struct inode *inode, struct file *file)
 			mutex_unlock(&vdev->mutex);
 			goto out_try_module_get;
 		}
+
+		/* set the default lens position, if applicable */
+		if (vdev->vdev_lens) {
+			vc.id = V4L2_CID_FOCUS_ABSOLUTE;
+			vc.value = 0;
+			vidioc_int_s_ctrl(vdev->vdev_lens, &vc);
+		}
 	}
 
 	if (atomic_inc_return(&vdev->users) == 1) {
-- 
1.5.6.5

