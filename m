From: hvaibhav@ti.com
Subject: [PATCH 1/2] Add Input/Output related ioctl support
Date: Wed, 26 Nov 2008 22:34:39 +0530
Message-ID: <1227719079-19459-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <hvaibhav@ti.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: video4linux-list@redhat.com
Cc: davinci-linux-open-source-bounces@linux.davincidsp.com, Karicheri Muralidharan <m-karicheri2@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

Note - Resending again with TVP driver for completeness.

Added ioctl support for query std, set std, enum input,
get input, set input, enum output, get output and set output.

For sensor kind of slave drivers v4l2-int-device.h provides
necessary ioctl support, but the ioctls required to interface
with decoders and encoders are missing. Most of the decoders
and encoders supports multiple inputs and outputs, like
S-Video or Composite.

With these ioctl''s user can select the specific input/output.

Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
Signed-off-by: Hardik Shah <hardik.shah@ti.com>
Signed-off-by: Manjunath Hadli <mrh@ti.com>
Signed-off-by: R Sivaraj <sivaraj@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Karicheri Muralidharan <m-karicheri2@ti.com>
---
 include/media/v4l2-int-device.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
index 9c2df41..2325b2a 100644
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -102,6 +102,7 @@ enum v4l2_power {
 	V4L2_POWER_OFF = 0,
 	V4L2_POWER_ON,
 	V4L2_POWER_STANDBY,
+	V4L2_POWER_RESUME,
 };

 /* Slave interface type. */
@@ -183,6 +184,14 @@ enum v4l2_int_ioctl_num {
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
@@ -284,6 +293,14 @@ V4L2_INT_WRAPPER_1(g_crop, struct v4l2_crop, *);
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

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
