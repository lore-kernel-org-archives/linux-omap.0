From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 7/15] OMAP3 camera driver: V4L2: Export symbols to ease
 building as modules.
Date: Fri, 29 Aug 2008 18:28:14 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E32A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56192 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbYH2X2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:28:21 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNSFIR006634
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:28:20 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNSFlM017198
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:28:15 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/v4l2-int-device.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/v4l2-int-device.c b/drivers/media/video/v4l2-int-device.c
index 45086ea..a935bae 100644
--- a/drivers/media/video/v4l2-int-device.c
+++ b/drivers/media/video/v4l2-int-device.c
@@ -145,6 +145,7 @@ int v4l2_int_ioctl_0(struct v4l2_int_device *d, int cmd)
 		find_ioctl(d->u.slave, cmd,
 			   (v4l2_int_ioctl_func *)no_such_ioctl_0))(d);
 }
+EXPORT_SYMBOL_GPL(v4l2_int_ioctl_0);
 
 static int no_such_ioctl_1(struct v4l2_int_device *d, void *arg)
 {
@@ -157,5 +158,6 @@ int v4l2_int_ioctl_1(struct v4l2_int_device *d, int cmd, void *arg)
 		find_ioctl(d->u.slave, cmd,
 			   (v4l2_int_ioctl_func *)no_such_ioctl_1))(d, arg);
 }
+EXPORT_SYMBOL_GPL(v4l2_int_ioctl_1);
 
 MODULE_LICENSE("GPL");
-- 
1.5.0.6
