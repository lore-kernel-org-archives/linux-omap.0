From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] Build fix for n800_defconfig
Date: Tue, 12 Aug 2008 10:49:20 +0300
Message-ID: <1218527360-18295-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1218527360-18295-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39144 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYHLHuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 03:50:00 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7C7ndfi017555
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:49:58 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7C7nKCT011468
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:49:20 +0300
In-Reply-To: <1218527360-18295-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Just updated from the latest header file.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/media/video/omap24xxcam.c |   67 +++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 6793869..682d402 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2004 MontaVista Software, Inc.
  * Copyright (C) 2004 Texas Instruments.
- * Copyright (C) 2007 Nokia Corporation.
+ * Copyright (C) 2007-2008 Nokia Corporation.
  *
  * Contact: Sakari Ailus <sakari.ailus@nokia.com>
  *
@@ -997,8 +997,8 @@ static int vidioc_querycap(struct file *file, void *fh,
 	return 0;
 }
 
-static int vidioc_enum_fmt_cap(struct file *file, void *fh,
-			       struct v4l2_fmtdesc *f)
+static int vidioc_enum_fmt_vid_cap(struct file *file, void *fh,
+				   struct v4l2_fmtdesc *f)
 {
 	struct omap24xxcam_fh *ofh = fh;
 	struct omap24xxcam_device *cam = ofh->cam;
@@ -1009,8 +1009,8 @@ static int vidioc_enum_fmt_cap(struct file *file, void *fh,
 	return rval;
 }
 
-static int vidioc_g_fmt_cap(struct file *file, void *fh,
-			    struct v4l2_format *f)
+static int vidioc_g_fmt_vid_cap(struct file *file, void *fh,
+				struct v4l2_format *f)
 {
 	struct omap24xxcam_fh *ofh = fh;
 	struct omap24xxcam_device *cam = ofh->cam;
@@ -1023,8 +1023,8 @@ static int vidioc_g_fmt_cap(struct file *file, void *fh,
 	return rval;
 }
 
-static int vidioc_s_fmt_cap(struct file *file, void *fh,
-			    struct v4l2_format *f)
+static int vidioc_s_fmt_vid_cap(struct file *file, void *fh,
+				struct v4l2_format *f)
 {
 	struct omap24xxcam_fh *ofh = fh;
 	struct omap24xxcam_device *cam = ofh->cam;
@@ -1048,13 +1048,13 @@ out:
 	}
 
 	memset(f, 0, sizeof(*f));
-	vidioc_g_fmt_cap(file, fh, f);
+	vidioc_g_fmt_vid_cap(file, fh, f);
 
 	return rval;
 }
 
-static int vidioc_try_fmt_cap(struct file *file, void *fh,
-			      struct v4l2_format *f)
+static int vidioc_try_fmt_vid_cap(struct file *file, void *fh,
+				  struct v4l2_format *f)
 {
 	struct omap24xxcam_fh *ofh = fh;
 	struct omap24xxcam_device *cam = ofh->cam;
@@ -1608,6 +1608,28 @@ static int omap24xxcam_resume(struct platform_device *pdev)
 }
 #endif /* CONFIG_PM */
 
+static const struct v4l2_ioctl_ops omap24xxcam_ioctl_fops = {
+	.vidioc_querycap	= vidioc_querycap,
+	.vidioc_enum_fmt_vid_cap	= vidioc_enum_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap	= vidioc_g_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap	= vidioc_s_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap	= vidioc_try_fmt_vid_cap,
+	.vidioc_reqbufs		= vidioc_reqbufs,
+	.vidioc_querybuf	= vidioc_querybuf,
+	.vidioc_qbuf		= vidioc_qbuf,
+	.vidioc_dqbuf		= vidioc_dqbuf,
+	.vidioc_streamon	= vidioc_streamon,
+	.vidioc_streamoff	= vidioc_streamoff,
+	.vidioc_enum_input	= vidioc_enum_input,
+	.vidioc_g_input		= vidioc_g_input,
+	.vidioc_s_input		= vidioc_s_input,
+	.vidioc_queryctrl	= vidioc_queryctrl,
+	.vidioc_g_ctrl		= vidioc_g_ctrl,
+	.vidioc_s_ctrl		= vidioc_s_ctrl,
+	.vidioc_g_parm		= vidioc_g_parm,
+	.vidioc_s_parm		= vidioc_s_parm,
+};
+
 /*
  *
  * Camera device (i.e. /dev/video).
@@ -1641,33 +1663,14 @@ static int omap24xxcam_device_register(struct v4l2_int_device *s)
 	}
 	vfd->release = video_device_release;
 
-	vfd->dev = cam->dev;
+	vfd->parent = cam->dev;
 
 	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
-	vfd->type		 = VID_TYPE_CAPTURE | VID_TYPE_CHROMAKEY;
+	vfd->vfl_type		 = VID_TYPE_CAPTURE | VID_TYPE_CHROMAKEY;
 	vfd->fops		 = &omap24xxcam_fops;
 	vfd->priv		 = cam;
 	vfd->minor		 = -1;
-
-	vfd->vidioc_querycap	 = vidioc_querycap;
-	vfd->vidioc_enum_fmt_cap = vidioc_enum_fmt_cap;
-	vfd->vidioc_g_fmt_cap	 = vidioc_g_fmt_cap;
-	vfd->vidioc_s_fmt_cap	 = vidioc_s_fmt_cap;
-	vfd->vidioc_try_fmt_cap	 = vidioc_try_fmt_cap;
-	vfd->vidioc_reqbufs	 = vidioc_reqbufs;
-	vfd->vidioc_querybuf	 = vidioc_querybuf;
-	vfd->vidioc_qbuf	 = vidioc_qbuf;
-	vfd->vidioc_dqbuf	 = vidioc_dqbuf;
-	vfd->vidioc_streamon	 = vidioc_streamon;
-	vfd->vidioc_streamoff	 = vidioc_streamoff;
-	vfd->vidioc_enum_input	 = vidioc_enum_input;
-	vfd->vidioc_g_input	 = vidioc_g_input;
-	vfd->vidioc_s_input	 = vidioc_s_input;
-	vfd->vidioc_queryctrl	 = vidioc_queryctrl;
-	vfd->vidioc_g_ctrl	 = vidioc_g_ctrl;
-	vfd->vidioc_s_ctrl	 = vidioc_s_ctrl;
-	vfd->vidioc_g_parm	 = vidioc_g_parm;
-	vfd->vidioc_s_parm	 = vidioc_s_parm;
+	vfd->ioctl_ops		 = &omap24xxcam_ioctl_fops;
 
 	omap24xxcam_hwinit(cam);
 
-- 
1.5.5.1.357.g1af8b

