From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 6/15] OMAP3 camera driver: V4L2: Allowing device
 initialization anywhere.
Date: Fri, 29 Aug 2008 18:27:44 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E329@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51036 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbYH2X1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:27:51 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNRjce021859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:27:50 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNRj8Y016937
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:27:45 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/v4l2-int-device.c |    3 ++-
 include/media/v4l2-int-device.h       |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/v4l2-int-device.c b/drivers/media/video/v4l2-int-device.c
index 0e45499..45086ea 100644
--- a/drivers/media/video/v4l2-int-device.c
+++ b/drivers/media/video/v4l2-int-device.c
@@ -32,7 +32,7 @@
 static DEFINE_MUTEX(mutex);
 static LIST_HEAD(int_list);
 
-static void v4l2_int_device_try_attach_all(void)
+void v4l2_int_device_try_attach_all(void)
 {
 	struct v4l2_int_device *m, *s;
 
@@ -66,6 +66,7 @@ static void v4l2_int_device_try_attach_all(void)
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(v4l2_int_device_try_attach_all);
 
 static int ioctl_sort_cmp(const void *a, const void *b)
 {
diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
index 6795b32..27d21b1 100644
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -84,6 +84,8 @@ struct v4l2_int_device {
 	void *priv;
 };
 
+void v4l2_int_device_try_attach_all(void);
+
 int v4l2_int_device_register(struct v4l2_int_device *d);
 void v4l2_int_device_unregister(struct v4l2_int_device *d);
 
-- 
1.5.0.6
