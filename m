From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: downscaling YUV fails
Date: Wed, 19 Dec 2012 10:51:58 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:37468 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab2LSJwB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 04:52:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hello,

downscaling a YUV video from /dev/fb1 silently fails and results in 
incorrectly rendered data (each line is shifted a bit more to the right, 
turning vertical lines into diagonals) -- observed with Linux 3.6.11 on 
omap3/dm3730


test data (an image with vertical bars) is produced by:
gst-launch-0.10 videotestsrc ! video/x-raw-yuv, width=400, height=240 ! freeze ! omapfbsink

cd /sys/devices/platform/omapdss/overlay1
echo 400,240 > output_size
echo 100,100 > position
echo 220,140 > output_size
this downscales the YUV data from 400x240->220x140 and results in 
distorted output data (see http://pmeerw.net/overlay-distorted.jpg)

note that upscaling works

more observations:
setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 results in correct downscaling 
with x_predecim=1/y_predecim=1

CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0 leads to distorted output with 
x_predecim=2/y_predecim=1



I think there is a bug downscaling YUV data when resorting to 
pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a workaround 
-- any ideas how this can be fixed?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
