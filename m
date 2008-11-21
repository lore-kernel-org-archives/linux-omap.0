From: m-karicher2@ti.com
Subject: [PATCH] Adding support for cropcap ioctl in tvp514x decoder
Date: Fri, 21 Nov 2008 15:25:00 -0500
Message-ID: <1227299100-20403-1-git-send-email-m-karicher2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYKUUZY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 15:25:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: video4linux-list@redhat.com
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Murali Karicheri <m-karicheri2@ti.com>

This patch is based on the initial version of TVP514x driver sent
by Vaibhav Hiremath.  This adds support for cropcap ioctl in
tvp514x decoder. I plan to send a set of patches that adds
support for V4L2 capture driver on DM6446 & DM355 SoCs from Texas
Instruments. V4L2 capture driver uses v4l2-int-device interface
for attaching decoder devices to v4l2 master driver. This
decoder is already integrated with a private version of V4L2 capture
driver on DM6446 and tested for NTSC and PAL video capture.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/media/video/tvp514x.c |   32 ++++++++++++++++++++++++++++++++
 include/media/tvp514x.h       |    2 ++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/tvp514x.c b/drivers/media/video/tvp514x.c
index b68ddf5..46faabd 100644
--- a/drivers/media/video/tvp514x.c
+++ b/drivers/media/video/tvp514x.c
@@ -72,6 +72,7 @@ static struct tvp514x_std_info tvp514x_std_list[] = {
 	{
 	 .width = NTSC_NUM_ACTIVE_PIXELS,
 	 .height = NTSC_NUM_ACTIVE_LINES,
+	 .pixelaspect = {11, 10},
 	 .video_std = VIDEO_STD_NTSC_MJ_BIT,
 	 .standard = {
 		      .index = 0,
@@ -83,6 +84,7 @@ static struct tvp514x_std_info tvp514x_std_list[] = {
 	{
 	 .width = PAL_NUM_ACTIVE_PIXELS,
 	 .height = PAL_NUM_ACTIVE_LINES,
+	 .pixelaspect = {54, 59},
 	 .video_std = VIDEO_STD_PAL_BDGHIN_BIT,
 	 .standard = {
 		      .index = 1,
@@ -890,6 +892,35 @@ ioctl_s_fmt_cap(struct v4l2_int_device *s, struct v4l2_format *f)
 }
 
 /**
+ * ioctl_cropcap - V4L2 decoder interface handler for VIDIOC_CROPCAP ioctl
+ * @s: pointer to standard V4L2 device structure
+ * @f: pointer to standard V4L2 VIDIOC_CROPCAP ioctl structure
+ *
+ * returns the bounds, defrect and pixaspect for the current standard
+ */
+static int
+ioctl_cropcap(struct v4l2_int_device *s, struct v4l2_cropcap *crop_cap)
+{
+	struct tvp514x_decoder *decoder = s->priv;
+	enum tvp514x_std current_std;
+
+	/* get the current standard. Assume that current
+	 * standard is already selected before this call
+	 */
+	current_std = decoder->current_std;
+	if (current_std == STD_INVALID)
+		return -EINVAL;
+
+	crop_cap->bounds.top = 0;
+	crop_cap->bounds.left = 0;
+	crop_cap->bounds.width = decoder->std_list[current_std].width;
+	crop_cap->bounds.height = decoder->std_list[current_std].height;
+	crop_cap->defrect = crop_cap->bounds;
+	crop_cap->pixelaspect = decoder->std_list[current_std].pixelaspect;
+	return 0;
+}
+
+/**
  * ioctl_g_fmt_cap - V4L2 decoder interface handler for ioctl_g_fmt_cap
  * @s: pointer to standard V4L2 device structure
  * @f: pointer to standard V4L2 v4l2_format structure
@@ -1161,6 +1192,7 @@ static struct v4l2_int_ioctl_desc tvp514x_ioctl_desc[] = {
 	 (v4l2_int_ioctl_func *) ioctl_g_fmt_cap},
 	{vidioc_int_s_fmt_cap_num,
 	 (v4l2_int_ioctl_func *) ioctl_s_fmt_cap},
+	{vidioc_int_cropcap_num, (v4l2_int_ioctl_func *) ioctl_cropcap},
 	{vidioc_int_g_parm_num, (v4l2_int_ioctl_func *) ioctl_g_parm},
 	{vidioc_int_s_parm_num, (v4l2_int_ioctl_func *) ioctl_s_parm},
 	{vidioc_int_queryctrl_num,
diff --git a/include/media/tvp514x.h b/include/media/tvp514x.h
index 4433b96..19517b5 100644
--- a/include/media/tvp514x.h
+++ b/include/media/tvp514x.h
@@ -302,12 +302,14 @@ struct tvp514x_reg {
  * struct tvp514x_std_info - Structure to store standard informations
  * @width: Line width in pixels
  * @height:Number of active lines
+ * @pixelaspect: pixel aspect for this standard
  * @video_std: Value to write in REG_VIDEO_STD register
  * @standard: v4l2 standard structure information
  */
 struct tvp514x_std_info {
 	unsigned long width;
 	unsigned long height;
+	struct v4l2_fract pixelaspect;
 	u8 video_std;
 	struct v4l2_standard standard;
 };
-- 
1.5.6.4

