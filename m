From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command to get
 slave private data.
Date: Fri, 29 Aug 2008 18:23:23 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E320@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYH2XXb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:23:31 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNNPSi007775
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:23:30 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNNPT3015409
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:23:25 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 0be1009427e55115058bfe72521a2a2811a976e8 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@nokia.com>
Date: Tue, 15 Apr 2008 10:35:15 +0300
Subject: [PATCH] Adding IOCTL command to get slave private data.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 include/media/v4l2-int-device.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
index c8b80e0..d9a0053 100644
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -184,6 +184,11 @@ enum v4l2_int_ioctl_num {
 	vidioc_int_dev_exit_num,
 	/* Set device power state: 0 is off, non-zero is on. */
 	vidioc_int_s_power_num,
+	/*
+	* Get slave private data, e.g. platform-specific slave
+	* configuration used by the master.
+	*/
+	vidioc_int_g_priv_num,
 	/* Get slave interface parameters. */
 	vidioc_int_g_ifparm_num,
 	/* Does the slave need to be reset after VIDIOC_DQBUF? */
@@ -267,6 +272,7 @@ V4L2_INT_WRAPPER_1(s_parm, struct v4l2_streamparm, *);
 V4L2_INT_WRAPPER_0(dev_init);
 V4L2_INT_WRAPPER_0(dev_exit);
 V4L2_INT_WRAPPER_1(s_power, int, );
+V4L2_INT_WRAPPER_1(g_priv, void, *);
 V4L2_INT_WRAPPER_1(g_ifparm, struct v4l2_ifparm, *);
 V4L2_INT_WRAPPER_1(g_needs_reset, void, *);
 
-- 
1.5.5.1

