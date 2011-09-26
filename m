From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/6] OMAP: omap_device cleanup before device-tree integration
Date: Mon, 26 Sep 2011 15:36:06 -0700
Message-ID: <87ehz39bjd.fsf@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:38148 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751986Ab1IZWgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 18:36:12 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so5894179gyg.5
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 15:36:11 -0700 (PDT)
In-Reply-To: <1314973520-3585-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 2 Sep 2011 16:25:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

Benoit Cousson <b-cousson@ti.com> writes:

> Hi Kevin,
>
> Here are a couple of cleanups on top of your (old) for_3.2/omap_device branch
> rebased on top of -rc4 + Tony's cleanup patches.
>
> Since I cannot pull your latest version, I repost the whole series.

I have a (temporary) tree at git://github.com/khilman/linux-omap-pm.git.
Please base the updated series on my for_3.2/omap_device branch there.

Other than the minor API name, this series looks good and I'll add
to my omap_device queue for v3.2.

Thanks,

Kevin

> patches are available here:
> git://gitorious.org/omap-pm/linux.git for_3.2/1_omap_device_cleanup
>
> It is tested on OMAP4 SDP, Panda and Beagle-xM (Yeah, I found one...).
>
> Regards,
> Benoit
>
>
> Changes since v1: http://www.spinics.net/lists/linux-omap/msg55801.html
>  - Update the 2 patches from Nishanth based on Kevin's comment and merge
>    them into one patch.
>
>
> Benoit Cousson (5):
>   OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
>   OMAP2+: pm: Use hwmod name instead of dev pointer
>   OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
>   OMAP: omap_device: Create a default omap_device_pm_latency
>   OMAP2+: devices: Remove all omap_device_pm_latency structures
>
> Nishanth Menon (1):
>   OMAP: omap_device: Add omap_hwmod_name_get_dev
>
>  arch/arm/mach-omap2/board-omap3beagle.c       |    4 +-
>  arch/arm/mach-omap2/devices.c                 |   46 ++---------------
>  arch/arm/mach-omap2/display.c                 |   11 +----
>  arch/arm/mach-omap2/dma.c                     |   11 +----
>  arch/arm/mach-omap2/gpio.c                    |   12 +----
>  arch/arm/mach-omap2/hsmmc.c                   |   18 +------
>  arch/arm/mach-omap2/hwspinlock.c              |   12 +----
>  arch/arm/mach-omap2/mcbsp.c                   |   11 +----
>  arch/arm/mach-omap2/pm.c                      |   69 ++++++++-----------------
>  arch/arm/mach-omap2/serial.c                  |   25 +---------
>  arch/arm/mach-omap2/sr_device.c               |   11 +----
>  arch/arm/mach-omap2/usb-musb.c                |   11 +----
>  arch/arm/plat-omap/i2c.c                      |   10 +---
>  arch/arm/plat-omap/include/plat/omap_device.h |   10 ++++
>  arch/arm/plat-omap/omap_device.c              |   49 +++++++++++++++++-
>  15 files changed, 95 insertions(+), 215 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
