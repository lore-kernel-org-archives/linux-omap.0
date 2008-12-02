From: hvaibhav@ti.com
Subject: [PATCH 1/2] Addition of set/get Routing ioctl support[V4]
Date: Tue,  2 Dec 2008 21:05:19 +0530
Message-ID: <1228232119-10750-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbYLBPft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 10:35:49 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: video4linux-list@redhat.com
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Vaibhav Hiremath <hvaibhav@ti.com>, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Fixed Community review comments:

s/g_input:
    Removed input/output related ioctl, and made
    use of s/g_routing ioctl. Added entry for the
    same to the v4l2-int framework.

s/g_input:
    Since from decoder point of view we really don't
    care about output, and anyway we can tie this
    feature with s/g_routing. So removed s/g_output
    ioctl.
    This was added for completeness in the previous patch.

Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
Signed-off-by: Hardik Shah <hardik.shah@ti.com>
Signed-off-by: Manjunath Hadli <mrh@ti.com>
Signed-off-by: R Sivaraj <sivaraj@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Karicheri Muralidharan <m-karicheri2@ti.com>
---
 include/media/v4l2-int-device.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 include/media/v4l2-int-device.h

diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
old mode 100644
new mode 100755
index 9c2df41..5e3e193
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -183,6 +183,10 @@ enum v4l2_int_ioctl_num {
 	vidioc_int_s_crop_num,
 	vidioc_int_g_parm_num,
 	vidioc_int_s_parm_num,
+	vidioc_int_querystd_num,
+	vidioc_int_s_std_num,
+	vidioc_int_g_video_routing_num,
+	vidioc_int_s_video_routing_num,

 	/*
 	 *
@@ -284,6 +288,10 @@ V4L2_INT_WRAPPER_1(g_crop, struct v4l2_crop, *);
 V4L2_INT_WRAPPER_1(s_crop, struct v4l2_crop, *);
 V4L2_INT_WRAPPER_1(g_parm, struct v4l2_streamparm, *);
 V4L2_INT_WRAPPER_1(s_parm, struct v4l2_streamparm, *);
+V4L2_INT_WRAPPER_1(querystd, v4l2_std_id, *);
+V4L2_INT_WRAPPER_1(s_std, v4l2_std_id, *);
+V4L2_INT_WRAPPER_1(g_video_routing, int, *);
+V4L2_INT_WRAPPER_1(s_video_routing, int, );

 V4L2_INT_WRAPPER_0(dev_init);
 V4L2_INT_WRAPPER_0(dev_exit);
--
1.5.6

