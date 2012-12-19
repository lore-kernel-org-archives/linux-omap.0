From: Archit Taneja <archit@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 15:46:29 +0530
Message-ID: <50D193FD.4070401@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45506 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab2LSKQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 05:16:56 -0500
In-Reply-To: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On Wednesday 19 December 2012 03:21 PM, Peter Meerwald wrote:
> Hello,
>
> downscaling a YUV video from /dev/fb1 silently fails and results in
> incorrectly rendered data (each line is shifted a bit more to the right,
> turning vertical lines into diagonals) -- observed with Linux 3.6.11 on
> omap3/dm3730
>
>
> test data (an image with vertical bars) is produced by:
> gst-launch-0.10 videotestsrc ! video/x-raw-yuv, width=400, height=240 ! freeze ! omapfbsink
>
> cd /sys/devices/platform/omapdss/overlay1
> echo 400,240 > output_size
> echo 100,100 > position
> echo 220,140 > output_size
> this downscales the YUV data from 400x240->220x140 and results in
> distorted output data (see http://pmeerw.net/overlay-distorted.jpg)
>
> note that upscaling works
>
> more observations:
> setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 results in correct downscaling
> with x_predecim=1/y_predecim=1
>
> CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0 leads to distorted output with
> x_predecim=2/y_predecim=1
>

Configuring CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK to 0 will make the driver 
try to derive a closer accurate pixel clock, but it will sacrifice on 
the DISPC_FCLK used by scalar.

Configuring it to 4 will ensure that DISPC_FCLK is at least 4 times the 
pixel clock.

The DISPC HW can achieve more downscaling when the DISPC_FCLK is higher.

In the case we set it to 4, the DISPC_FCLK is fast enough to do the 
required downscaling, but in the case when it's set to 0, it might need 
to pre decimate rather than try to scale.

>
>
> I think there is a bug downscaling YUV data when resorting to
> pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a workaround
> -- any ideas how this can be fixed?

Pre-decimation should work for YUV formats also. Could you share DISPC 
reg dumps when this happens:

mount -t debugfs debugfs /sys/kernel/debug
cat /sys/kernel/debug/omapdss/dispc

Thanks,
Archit
