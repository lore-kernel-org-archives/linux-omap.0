From: hvaibhav@ti.com
Subject: [PATCH 1/2] Addition of Set Routing ioctl support[V5]
Date: Fri,  5 Dec 2008 18:24:02 +0530
Message-ID: <1228481642-28208-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50275 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbYLEMy3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Dec 2008 07:54:29 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: video4linux-list@redhat.com
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Vaibhav Hiremath <hvaibhav@ti.com>, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Fixed review comments:

g_routing:
        Removed g_routing, since it was not required
        at decoder level. Same can be handled at master
        level.

Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
Signed-off-by: Hardik Shah <hardik.shah@ti.com>
Signed-off-by: Manjunath Hadli <mrh@ti.com>
Signed-off-by: R Sivaraj <sivaraj@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Karicheri Muralidharan <m-karicheri2@ti.com>
---
 include/media/v4l2-int-device.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
index 9c2df41..ecda3c7 100644
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -183,6 +183,9 @@ enum v4l2_int_ioctl_num {
 	vidioc_int_s_crop_num,
 	vidioc_int_g_parm_num,
 	vidioc_int_s_parm_num,
+	vidioc_int_querystd_num,
+	vidioc_int_s_std_num,
+	vidioc_int_s_video_routing_num,

 	/*
 	 *
@@ -284,6 +287,9 @@ V4L2_INT_WRAPPER_1(g_crop, struct v4l2_crop, *);
 V4L2_INT_WRAPPER_1(s_crop, struct v4l2_crop, *);
 V4L2_INT_WRAPPER_1(g_parm, struct v4l2_streamparm, *);
 V4L2_INT_WRAPPER_1(s_parm, struct v4l2_streamparm, *);
+V4L2_INT_WRAPPER_1(querystd, v4l2_std_id, *);
+V4L2_INT_WRAPPER_1(s_std, v4l2_std_id, *);
+V4L2_INT_WRAPPER_1(s_video_routing, struct v4l2_routing, *);

 V4L2_INT_WRAPPER_0(dev_init);
 V4L2_INT_WRAPPER_0(dev_exit);
--
1.5.6

