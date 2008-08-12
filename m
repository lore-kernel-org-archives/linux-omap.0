From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] Build fix for n800_defconfig
Date: Tue, 12 Aug 2008 10:49:19 +0300
Message-ID: <1218527360-18295-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39143 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYHLHuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 03:50:00 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7C7niYU017630
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:49:58 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7C7nK8H003423
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:49:20 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Just updated from the latest header file.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/media/radio/radio-tea5761.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/radio-tea5761.c
index e8ccf29..1c6d8ab 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -1,7 +1,7 @@
 /*
  * drivers/media/radio/radio-tea5761.c
  *
- * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2005-2008 Nokia Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <media/v4l2-common.h>
+#include <media/v4l2-ioctl.h>
 
 #define DRIVER_NAME "tea5761"
 
@@ -255,11 +256,12 @@ static int tea5761_do_ioctl(struct inode *inode, struct file *file,
 	case VIDIOC_QUERYCAP:
 		dev_dbg(&client->dev, "VIDIOC_QUERYCAP\n");
 		memset(&u->c, 0, sizeof(u->c));
-		strlcpy(u->c.driver, dev->dev->driver->name,
+		strlcpy(u->c.driver,
+			dev->parent->driver->name,
 			sizeof(u->c.driver));
 		strlcpy(u->c.card, dev->name, sizeof(u->c.card));
 		snprintf(u->c.bus_info, sizeof(u->c.bus_info), "I2C:%s",
-			 dev->dev->bus_id);
+			 dev->parent->bus_id);
 		u->c.version = TEA5761_VERSION;
 		u->c.capabilities = V4L2_CAP_TUNER | V4L2_CAP_RADIO;
 		break;
@@ -406,9 +408,8 @@ static struct file_operations tea5761_fops = {
 };
 
 static struct video_device tea5761_video_device = {
-	.owner         = THIS_MODULE,
 	.name          = "TEA5761 FM-Radio",
-	.type          = VID_TYPE_TUNER,
+	.vfl_type      = VID_TYPE_TUNER,
 	.fops          = &tea5761_fops,
 	.release       = video_device_release
 };
@@ -434,7 +435,7 @@ static int tea5761_i2c_driver_probe(struct i2c_client *client,
 	tea->video_dev = video_dev;
 
 	*video_dev = tea5761_video_device;
-	video_dev->dev = &client->dev;
+	video_dev->parent = &client->dev;
 	i2c_set_clientdata(client, video_dev);
 
 	/* initialize and power off the chip */
-- 
1.5.5.1.357.g1af8b

