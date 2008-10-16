From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 2/28] [OMAPZOOM] V4L: Remove RESUME powerstate and
 g_priv_mem ioctl
Date: Wed, 15 Oct 2008 20:17:27 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568837@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46786 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYJPBRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:17:34 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1HSiT012213
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:17:33 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1HS58004239
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:17:28 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

V4L: Remove RESUME powerstate and g_priv_mem ioctl

This removes the RESUME powerstate as it isn't really a state, its
really a transition between powerstates.

Also removes the g_priv_mem as it wasn't aprooved as a V4L change
in video4linux mailing list, and we aren't using it anyway.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 include/media/v4l2-int-device.h |    4 ----
 1 file changed, 4 deletions(-)

Index: omapkernel/include/media/v4l2-int-device.h
===================================================================
--- omapkernel.orig/include/media/v4l2-int-device.h	2008-10-14 18:48:27.000000000 -0500
+++ omapkernel/include/media/v4l2-int-device.h	2008-10-14 18:52:36.000000000 -0500
@@ -102,7 +102,6 @@
 	V4L2_POWER_OFF = 0,
 	V4L2_POWER_ON,
 	V4L2_POWER_STANDBY,
-	V4L2_POWER_RESUME,
 };
 
 /* Slave interface type. */
@@ -219,8 +218,6 @@
 	vidioc_int_init_num,
 	/* VIDIOC_INT_G_CHIP_IDENT */
 	vidioc_int_g_chip_ident_num,
-	/* VIDIOC_INT_G_PRIV_MEM */
-	vidioc_int_g_priv_mem_num,
 
 	/*
 	 *
@@ -300,6 +297,5 @@
 V4L2_INT_WRAPPER_0(reset);
 V4L2_INT_WRAPPER_0(init);
 V4L2_INT_WRAPPER_1(g_chip_ident, int, *);
-V4L2_INT_WRAPPER_1(g_priv_mem, struct v4l2_priv_mem, *);
 
 #endif
