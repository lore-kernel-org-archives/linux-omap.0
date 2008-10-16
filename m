From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 15/28] [OMAPZOOM] V4L: Add RAW10 Pattern format MMS
Date: Wed, 15 Oct 2008 20:27:54 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256884A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41664 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbYJPB2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:28:02 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1Ru71013679
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:28:01 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1RuBD014101
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:27:56 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

V4L: Add RAW10 Pattern format MMS

This adds MMS changes to the OMAP34xx camera driver. Including:
- HQ capture

NOTE: Credits to MMS crew for all this.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 include/linux/videodev2.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: omapkernel/include/linux/videodev2.h
===================================================================
--- omapkernel.orig/include/linux/videodev2.h	2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/include/linux/videodev2.h	2008-10-15 19:39:00.000000000 -0500
@@ -319,6 +319,11 @@
 #define V4L2_PIX_FMT_SGRBG10DPCM8 v4l2_fourcc('B', 'D', '1', '0') /* 10bit raw bayer DPCM compressed to 8 bits */
 #define V4L2_PIX_FMT_SBGGR16 v4l2_fourcc('B', 'Y', 'R', '2') /* 16  BGBG.. GRGR.. */
 
+/* Added by MMS */
+#define V4L2_PIX_FMT_PATT     v4l2_fourcc('P', 'A', 'T', 'T') /* 10-bit raw
+							       * pattern
+							       */
+
 /* compressed formats */
 #define V4L2_PIX_FMT_MJPEG    v4l2_fourcc('M', 'J', 'P', 'G') /* Motion-JPEG   */
 #define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J', 'P', 'E', 'G') /* JFIF JPEG     */
