From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 4/15] OMAP3 camera driver: V4L2: Add VIDIOC_G_PRIV_MEM
Date: Fri, 29 Aug 2008 18:25:25 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E325@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59420 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYH2XZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:25:32 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNPQhq009781
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:25:31 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNPQvl016186
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:25:26 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] V4L: Add VIDIOC_G_PRIV_MEM

Some devices, for example image sensors, contain settings in their
EEPROM memory that are useful to userspace programs. VIDIOC_G_PRIV_MEM
can be used to read those settings.

This patch adds also the corresponding v4l2_int_device command.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 include/linux/videodev2.h       |   10 +++++++++-
 include/media/v4l2-int-device.h |    3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/include/linux/videodev2.h
===================================================================
--- linux-omap-2.6.orig/include/linux/videodev2.h	2008-08-25 12:19:22.000000000 -0500
+++ linux-omap-2.6/include/linux/videodev2.h	2008-08-25 12:19:24.000000000 -0500
@@ -1352,6 +1352,13 @@
 	__u32 revision;    /* chip revision, chip specific */
 };
 
+/* VIDIOC_G_PRIV_MEM */
+struct v4l2_priv_mem {
+	__u32 offset;	/* offset to data */
+	__u32 length;	/* memory allocated to ptr or read length */
+	void *ptr;	/* pointer to allocated memory */
+};
+
 /*
  *	I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
  *
@@ -1423,8 +1430,9 @@
 #define	VIDIOC_DBG_G_REGISTER 	_IOWR('V', 80, struct v4l2_register)
 
 #define VIDIOC_G_CHIP_IDENT     _IOWR('V', 81, struct v4l2_chip_ident)
+#define VIDIOC_G_PRIV_MEM       _IOWR('V', 82, struct v4l2_priv_mem)
 #endif
-#define VIDIOC_S_HW_FREQ_SEEK	 _IOW('V', 82, struct v4l2_hw_freq_seek)
+#define VIDIOC_S_HW_FREQ_SEEK	 _IOW('V', 83, struct v4l2_hw_freq_seek)
 
 #ifdef __OLD_VIDIOC_
 /* for compatibility, will go away some day */
Index: linux-omap-2.6/include/media/v4l2-int-device.h
===================================================================
--- linux-omap-2.6.orig/include/media/v4l2-int-device.h	2008-08-25 12:19:10.000000000 -0500
+++ linux-omap-2.6/include/media/v4l2-int-device.h	2008-08-25 12:19:24.000000000 -0500
@@ -208,6 +208,8 @@
 	vidioc_int_init_num,
 	/* VIDIOC_INT_G_CHIP_IDENT */
 	vidioc_int_g_chip_ident_num,
+	/* VIDIOC_INT_G_PRIV_MEM */
+	vidioc_int_g_priv_mem_num,
 
 	/*
 	 *
@@ -285,5 +287,6 @@
 V4L2_INT_WRAPPER_0(reset);
 V4L2_INT_WRAPPER_0(init);
 V4L2_INT_WRAPPER_1(g_chip_ident, int, *);
+V4L2_INT_WRAPPER_1(g_priv_mem, struct v4l2_priv_mem, *);
 
 #endif
