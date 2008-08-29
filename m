From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 5/15] OMAP3 camera driver: V4L2: Int if: define new power
 states
Date: Fri, 29 Aug 2008 18:25:51 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E326@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56112 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbYH2XZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:25:59 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNPrWg004016
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:25:58 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNPrip016299
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:25:53 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From e2277399f9a46a2c6dbe7aacf072d0b9a457dbff Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@nokia.com>
Date: Thu, 8 May 2008 19:29:19 +0300
Subject: [PATCH] V4L: Int if: define new power states

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 include/media/v4l2-int-device.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/include/media/v4l2-int-device.h
===================================================================
--- linux-omap-2.6.orig/include/media/v4l2-int-device.h	2008-08-25 12:19:24.000000000 -0500
+++ linux-omap-2.6/include/media/v4l2-int-device.h	2008-08-25 12:19:27.000000000 -0500
@@ -96,6 +96,13 @@
  *
  */
 
+enum v4l2_power {
+	V4L2_POWER_OFF = 0,
+	V4L2_POWER_ON,
+	V4L2_POWER_STANDBY,
+	V4L2_POWER_RESUME,
+};
+
 /* Slave interface type. */
 enum v4l2_if_type {
 	/*
@@ -185,7 +192,7 @@
 	vidioc_int_dev_init_num = 1000,
 	/* Delinitialise the device at slave detach. */
 	vidioc_int_dev_exit_num,
-	/* Set device power state: 0 is off, non-zero is on. */
+	/* Set device power state. */
 	vidioc_int_s_power_num,
 	/*
 	* Get slave private data, e.g. platform-specific slave
@@ -279,7 +286,7 @@
 
 V4L2_INT_WRAPPER_0(dev_init);
 V4L2_INT_WRAPPER_0(dev_exit);
-V4L2_INT_WRAPPER_1(s_power, int, );
+V4L2_INT_WRAPPER_1(s_power, enum v4l2_power, );
 V4L2_INT_WRAPPER_1(g_priv, void, *);
 V4L2_INT_WRAPPER_1(g_ifparm, struct v4l2_ifparm, *);
 V4L2_INT_WRAPPER_1(g_needs_reset, void, *);
