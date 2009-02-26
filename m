From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 0/3] ISP: Component order
Date: Thu, 26 Feb 2009 16:39:38 -0600
Message-ID: <200902261639.38890.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47967 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbZBZWjr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:39:47 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1QMde95007192
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:39:45 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n1QMde0D021542
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:39:40 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject:[OMAPZOOM][PATCH 0/3] ISP: Component order

The RAW10 component order for all three sensors I test with (MT9P012, OV3640 & 
IMX046) is different.  This patch set uses different horz/vert offsets in CCDC 
so that the output RAW component order is the same for all sensors.

Currently sph and slv in the board file (for MT & OV) are used to fix component 
order in Previewer. However this approach doesn't work for the Sony IMX046 
sensor.
This patch causes the component order output of CCDC to be the same for all 
sensors.  Since the order is the same going into Previewer this means that there 
is not need for sph and slv to change per sensor.

                     woffset    hoffset      RAW10 test     YUV test
MT9P012    GR..BG      1          0            OK             OK
IMX046     RG..GB      0          0            OK             OK
OV3640     BG..GR      1          1            OK             OK

Patch:
1/3  Removes original bug introduced with IMX046 patch.
2/3  Changes in CCDC to all easy setup of component order in board file.
3/3  Remove no longer needed prev_sph & prev_slv from boad file. 

Testing:
The following tests have been run using this patch set [x = working]:
(Test apps below are internal TI tools which test basic V4L2 functions)

IMX046	streaming 3 YUYV QVGA 1 500             x
	streaming 3 YUYV VGA 1 500              x
	streaming 3 YUYV 208 154 1 500          x
	streaming 3 YUYV 854 480 1 500          x
	fps 3 YUYV 640 480 200                 30fps
	fps 3 YUYV 3280 2464 100               7.5fps
	burst_mode 3 YUYV 816 616 1 file.yuv    x
	burst_mode 3 YUYV 3280 2464 1 file.yuv  x
	burst_mode 3 RAW10 3280 616 1 file.raw  x (h)
		
MT9P012	./streaming_frame 1 15 YUYV QVGA 1 200  x
	./streaming_frame 1 30 YUYV QVGA 1 200  x
	./streaming_frame 1 15 YUYV VGA 1 200   x
	./streaming_frame 1 30 YUYV VGA 1 200   x
	burst_mode 1 YUYV 5MP 1 file.yuv        x
	burst_mode 1 RAW10 5MP 1 file.raw       x (h)
	streaming_zoom 1 YUYV VGA               x
		
		
OV3640	streaming 2 YUYV 256 192 1 300          x
	streaming 2 YUYV QVGA 1 300             x
	streaming 2 YUYV VGA 1 300              x
	burst_mode 2 YUYV XGA 1 file.yuv        x
	burst_mode 2 YUYV QXGA 1 file.yuv       x
	burst_mode 2 RAW10 QXGA 1 file.raw      x (h)
	fps 2 YUYV VGA 200                      30fps
	fps 2 YUYV QXGA 100 15                  15fps
