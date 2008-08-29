From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 8/15] OMAP3 camera driver: V4L2: Int if: Add enumeration
 ioctls.
Date: Fri, 29 Aug 2008 18:28:50 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E32C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56208 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbYH2X25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:28:57 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNSpX8007212
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:28:56 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNSpA1017418
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:28:51 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 include/media/v4l2-int-device.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

Index: linux-omap-2.6/include/media/v4l2-int-device.h
===================================================================
--- linux-omap-2.6.orig/include/media/v4l2-int-device.h	2008-08-28 19:37:11.000000000 -0500
+++ linux-omap-2.6/include/media/v4l2-int-device.h	2008-08-28 19:38:29.000000000 -0500
@@ -205,6 +205,8 @@
 	vidioc_int_g_ifparm_num,
 	/* Does the slave need to be reset after VIDIOC_DQBUF? */
 	vidioc_int_g_needs_reset_num,
+	vidioc_int_enum_framesizes_num,
+	vidioc_int_enum_frameintervals_num,
 
 	/*
 	 *
@@ -292,6 +294,8 @@
 V4L2_INT_WRAPPER_1(g_priv, void, *);
 V4L2_INT_WRAPPER_1(g_ifparm, struct v4l2_ifparm, *);
 V4L2_INT_WRAPPER_1(g_needs_reset, void, *);
+V4L2_INT_WRAPPER_1(enum_framesizes, struct v4l2_frmsizeenum, *);
+V4L2_INT_WRAPPER_1(enum_frameintervals, struct v4l2_frmivalenum, *);
 
 V4L2_INT_WRAPPER_0(reset);
 V4L2_INT_WRAPPER_0(init);
