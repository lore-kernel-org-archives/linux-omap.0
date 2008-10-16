From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 13/28] [OMAPZOOM] OMAP: CAM: MT9P012: Misc Fixes
Date: Wed, 15 Oct 2008 20:25:53 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568845@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41581 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbYJPB0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:26:01 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1PtgN012518
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:26:00 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1PtZ1011940
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:25:55 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: MT9P012: Misc Fixes

This patch adds the following changes:
 - Removal of v4l2_ifparm use, as it is no longer needed.
 - Fix I2C writing of stream_off commands while XCLK wasn't available.
 - Fix for 30 fps capture on sizes lower than 3MP.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/mt9p012.c |   50 ++++++------------------------------------
 1 file changed, 8 insertions(+), 42 deletions(-)

Index: omapkernel/drivers/media/video/mt9p012.c
===================================================================
--- omapkernel.orig/drivers/media/video/mt9p012.c	2008-10-03 17:48:05.000000000 -0500
+++ omapkernel/drivers/media/video/mt9p012.c	2008-10-14 12:30:17.000000000 -0500
@@ -1391,30 +1391,6 @@
 }
 
 /**
- * ioctl_g_ifparm - V4L2 sensor interface handler for vidioc_int_g_ifparm_num
- * @s: pointer to standard V4L2 device structure
- * @p: pointer to standard V4L2 vidioc_int_g_ifparm_num ioctl structure
- *
- * Gets slave interface parameters.
- * Calculates the required xclk value to support the requested
- * clock parameters in p.  This value is returned in the p
- * parameter.
- */
-static int ioctl_g_ifparm(struct v4l2_int_device *s, struct v4l2_ifparm *p)
-{
-	struct mt9p012_sensor *sensor = s->priv;
-	int rval;
-
-	rval = sensor->pdata->ifparm(p);
-	if (rval)
-		return rval;
-
-	p->u.bt656.clock_curr = xclk_current;
-
-	return 0;
-}
-
-/**
  * ioctl_g_priv - V4L2 sensor interface handler for vidioc_int_g_priv_num
  * @s: pointer to standard V4L2 device structure
  * @p: void pointer to hold sensor's private data address
@@ -1426,7 +1402,6 @@
 	struct mt9p012_sensor *sensor = s->priv;
 
 	return sensor->pdata->priv_data_set(p);
-
 }
 
 /**
@@ -1440,24 +1415,15 @@
 {
 	struct mt9p012_sensor *sensor = s->priv;
 	struct i2c_client *c = sensor->i2c_client;
-	struct v4l2_ifparm p;
 	int rval;
 
-	rval = ioctl_g_ifparm(s, &p);
-	if (rval) {
-		dev_err(&c->dev, "Unable to get if params\n");
-		return rval;
-	}
-
-	if (((on == V4L2_POWER_OFF) || (on == V4L2_POWER_STANDBY))
-		&& (sensor->state == SENSOR_DETECTED))
+	if ((on == V4L2_POWER_STANDBY) && (sensor->state == SENSOR_DETECTED))
 		mt9p012_write_regs(c, stream_off_list);
 
-
 	if ((on != V4L2_POWER_ON) && (on != V4L2_POWER_RESUME))
 		isp_set_xclk(0, MT9P012_USE_XCLKA);
 	else
-		isp_set_xclk(p.u.bt656.clock_curr, MT9P012_USE_XCLKA);
+		isp_set_xclk(xclk_current, MT9P012_USE_XCLKA);
 
 
 	rval = sensor->pdata->power_set(on);
@@ -1588,10 +1554,12 @@
 
 	/* Do we already reached all discrete framesizes? */
 
-	if ((frmi->width == mt9p012_sizes[4].width) &&
-				(frmi->height == mt9p012_sizes[4].height)) {
-		/* FIXME: The only frameinterval supported by 5MP capture is
-		 * 1/11 fps
+	if (((frmi->width == mt9p012_sizes[4].width) &&
+				(frmi->height == mt9p012_sizes[4].height)) ||
+				((frmi->width == mt9p012_sizes[3].width) &&
+				(frmi->height == mt9p012_sizes[3].height))) {
+		/* FIXME: The only frameinterval supported by 5MP and 3MP
+		 * capture sizes is 1/11 fps
 		 */
 		if (frmi->index != 0)
 			return -EINVAL;
@@ -1622,8 +1590,6 @@
 	  .func = (v4l2_int_ioctl_func *)ioctl_s_power },
 	{ .num = vidioc_int_g_priv_num,
 	  .func = (v4l2_int_ioctl_func *)ioctl_g_priv },
-	{ .num = vidioc_int_g_ifparm_num,
-	  .func = (v4l2_int_ioctl_func *)ioctl_g_ifparm },
 	{ .num = vidioc_int_init_num,
 	  .func = (v4l2_int_ioctl_func *)ioctl_init },
 	{ .num = vidioc_int_enum_fmt_cap_num,
