From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH 1/3] TCM825x: Include invertation of image mirroring in configuration
Date: Tue, 13 May 2008 19:04:21 +0300
Message-ID: <12106946631016-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18343 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbYEMQE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 12:04:59 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DG4hh7002099
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 19:04:57 +0300
Received: from kaali.localdomain (kaali.localdomain [192.168.239.7])
	by maxwell.research.nokia.com (Postfix) with ESMTP id 22BFF4674E
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 19:04:23 +0300 (EEST)
Received: from sailus by kaali.localdomain with local (Exim 4.63)
	(envelope-from <sakari.ailus@nokia.com>)
	id 1JvwzH-0005Mb-7w
	for linux-omap@vger.kernel.org; Tue, 13 May 2008 19:04:23 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add invertation of image mirroring register bits to default
configuration.

This is useful when the camera module is e.g. mounted upside down.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/tcm825x.c |    6 ++++++
 drivers/media/video/tcm825x.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/tcm825x.c b/drivers/media/video/tcm825x.c
index e57a646..216638e 100644
--- a/drivers/media/video/tcm825x.c
+++ b/drivers/media/video/tcm825x.c
@@ -523,6 +523,9 @@ static int ioctl_g_ctrl(struct v4l2_int_device *s,
 	if (val < 0)
 		return val;
 
+	if (vc->id == V4L2_CID_HFLIP || vc->id == V4L2_CID_VFLIP)
+		val ^= sensor->platform_data->is_upside_down();
+
 	vc->value = val;
 	return 0;
 }
@@ -556,6 +559,9 @@ static int ioctl_s_ctrl(struct v4l2_int_device *s,
 	if (lvc == NULL)
 		return -EINVAL;
 
+	if (vc->id == V4L2_CID_HFLIP || vc->id == V4L2_CID_VFLIP)
+		val ^= sensor->platform_data->is_upside_down();
+
 	val = val << lvc->start_bit;
 	if (tcm825x_write_reg_mask(client, lvc->reg, val))
 		return -EIO;
diff --git a/drivers/media/video/tcm825x.h b/drivers/media/video/tcm825x.h
index 966765b..770ebac 100644
--- a/drivers/media/video/tcm825x.h
+++ b/drivers/media/video/tcm825x.h
@@ -182,6 +182,7 @@ struct tcm825x_platform_data {
 	int (*needs_reset)(struct v4l2_int_device *s, void *buf,
 			   struct v4l2_pix_format *fmt);
 	int (*ifparm)(struct v4l2_ifparm *p);
+	int (*is_upside_down)(void);
 };
 
 /* Array of image sizes supported by TCM825X.  These must be ordered from
-- 
1.5.0.6

