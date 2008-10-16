From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 19/28] [OMAPZOOM] OMAP: CAM: MT9P012: RESUME Removal
Date: Wed, 15 Oct 2008 20:31:47 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568852@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36905 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbYJPBbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:31:55 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1Vn87031560
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:31:54 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1Vnik017689
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:31:49 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: MT9P012: RESUME Removal

This patch removes the use of the V4L2_POWER_RESUME state, as it has
been rejected in video4linux list

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/mt9p012.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: omapkernel/drivers/media/video/mt9p012.c
===================================================================
--- omapkernel.orig/drivers/media/video/mt9p012.c	2008-10-15 20:03:08.000000000 -0500
+++ omapkernel/drivers/media/video/mt9p012.c	2008-10-15 20:04:05.000000000 -0500
@@ -1243,8 +1243,7 @@
 	struct i2c_client *client = sensor->i2c_client;
 	u32 coarse_int_time = 0;
 
-	if ((current_power_state == V4L2_POWER_ON) ||
-				(current_power_state == V4L2_POWER_RESUME)) {
+	if (current_power_state == V4L2_POWER_ON) {
 		if ((exp_time < min_exposure_time) ||
 				(exp_time > max_exposure_time)) {
 			dev_err(&client->dev, "Exposure time not within the "
@@ -1312,8 +1311,7 @@
 	struct mt9p012_sensor *sensor = s->priv;
 	struct i2c_client *client = sensor->i2c_client;
 
-	if ((current_power_state == V4L2_POWER_ON) ||
-		(current_power_state == V4L2_POWER_RESUME)) {
+	if (current_power_state == V4L2_POWER_ON) {
 		if ((gain < MIN_GAIN) || (gain > MAX_GAIN)) {
 			dev_err(&client->dev, "Gain not within the legal"
 								" range\n");
@@ -2006,7 +2004,7 @@
 		mt9p012_write_regs(c, stream_off_list,
 						I2C_STREAM_OFF_LIST_SIZE);
 
-	if ((on != V4L2_POWER_ON) && (on != V4L2_POWER_RESUME))
+	if (on != V4L2_POWER_ON)
 		isp_set_xclk(0, MT9P012_USE_XCLKA);
 	else
 		isp_set_xclk(xclk_current, MT9P012_USE_XCLKA);
@@ -2019,8 +2017,9 @@
 		isp_set_xclk(0, MT9P012_USE_XCLKA);
 		return rval;
 	}
-	current_power_state = on;
-	if ((on == V4L2_POWER_RESUME) && (sensor->state == SENSOR_DETECTED))
+	if ((current_power_state == V4L2_POWER_STANDBY) &&
+					(on == V4L2_POWER_ON) &&
+					(sensor->state == SENSOR_DETECTED))
 		mt9p012_configure(s);
 
 	if ((on == V4L2_POWER_ON) && (sensor->state == SENSOR_NOT_DETECTED)) {
@@ -2037,6 +2036,7 @@
 								sensor->ver);
 	}
 
+	current_power_state = on;
 	return 0;
 }

