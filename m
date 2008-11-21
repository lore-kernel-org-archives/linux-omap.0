From: hvaibhav@ti.com
Subject: [PATCH 1/2] Add Input/Output related ioctl support
Date: Fri, 21 Nov 2008 20:51:19 +0530
Message-ID: <1227280879-31440-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57474 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYKUPVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 10:21:44 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: video4linux-list@redhat.com
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Vaibhav Hiremath <hvaibhav@ti.com>, Brijesh Jadav <brijesh.j@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Added ioctl support for query std, set std, enum input,
get input, set input, enum output, get output and set output.

For sensor kind of slave drivers v4l2-int-device.h provides
necessary ioctl support, but the ioctls required to interface
with decoders and encoders are missing. Most of the decoders
and encoders supports multiple inputs and outputs, like
S-Video or Composite.

With these ioctl''s user can select the specific input/output.

Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
		Hardik Shah <hardik.shah@ti.com>
		Manjunath Hadli <mrh@ti.com>
		R Sivaraj <sivaraj@ti.com>
		Vaibhav Hiremath <hvaibhav@ti.com>
		Karicheri Muralidharan <m-karicheri2@ti.com>
---
 include/media/v4l2-int-device.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
index 9c2df41..d73a11b 100644
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -183,6 +183,14 @@ enum v4l2_int_ioctl_num {
 	vidioc_int_s_crop_num,
 	vidioc_int_g_parm_num,
 	vidioc_int_s_parm_num,
+	vidioc_int_querystd_num,
+	vidioc_int_s_std_num,
+	vidioc_int_enum_input_num,
+	vidioc_int_g_input_num,
+	vidioc_int_s_input_num,
+	vidioc_int_enumoutput_num,
+	vidioc_int_g_output_num,
+	vidioc_int_s_output_num,

 	/*
 	 *
@@ -284,6 +292,14 @@ V4L2_INT_WRAPPER_1(g_crop, struct v4l2_crop, *);
 V4L2_INT_WRAPPER_1(s_crop, struct v4l2_crop, *);
 V4L2_INT_WRAPPER_1(g_parm, struct v4l2_streamparm, *);
 V4L2_INT_WRAPPER_1(s_parm, struct v4l2_streamparm, *);
+V4L2_INT_WRAPPER_1(querystd, v4l2_std_id, *);
+V4L2_INT_WRAPPER_1(s_std, v4l2_std_id, *);
+V4L2_INT_WRAPPER_1(enum_input, struct v4l2_input, *);
+V4L2_INT_WRAPPER_1(g_input, int, *);
+V4L2_INT_WRAPPER_1(s_input, int, );
+V4L2_INT_WRAPPER_1(enumoutput, struct v4l2_output, *);
+V4L2_INT_WRAPPER_1(g_output, int, *);
+V4L2_INT_WRAPPER_1(s_output, int, );

 V4L2_INT_WRAPPER_0(dev_init);
 V4L2_INT_WRAPPER_0(dev_exit);
--
1.5.6

