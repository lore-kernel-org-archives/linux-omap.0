From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 3/15] OMAP3 camera driver: V4L2: Add 10-bit RAW Bayer format
Date: Fri, 29 Aug 2008 18:24:41 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E323@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43833 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbYH2XYs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:24:48 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNOgBn031256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:24:47 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNOgqP015914
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:24:42 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Sergio Aguirre <saaguirre@ti.com>
Subject: OMAP: CAMERA: Add 10-bit RAW Bayer format

Adding 10-bit RAW Bayer format, and also compressed to 8 bits version.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 include/linux/videodev2.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-omap-2.6/include/linux/videodev2.h
===================================================================
--- linux-omap-2.6.orig/include/linux/videodev2.h	2008-08-22 09:56:56.000000000 -0500
+++ linux-omap-2.6/include/linux/videodev2.h	2008-08-22 09:59:09.000000000 -0500
@@ -315,6 +315,8 @@
 /* see http://www.siliconimaging.com/RGB%20Bayer.htm */
 #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8  BGBG.. GRGR.. */
 #define V4L2_PIX_FMT_SGBRG8  v4l2_fourcc('G', 'B', 'R', 'G') /*  8  GBGB.. RGRG.. */
+#define V4L2_PIX_FMT_SGRBG10 v4l2_fourcc('B', 'A', '1', '0') /* 10bit raw bayer  */
+#define V4L2_PIX_FMT_SGRBG10DPCM8 v4l2_fourcc('B', 'D', '1', '0') /* 10bit raw bayer DPCM compressed to 8 bits */
 #define V4L2_PIX_FMT_SBGGR16 v4l2_fourcc('B', 'Y', 'R', '2') /* 16  BGBG.. GRGR.. */
 
 /* compressed formats */
