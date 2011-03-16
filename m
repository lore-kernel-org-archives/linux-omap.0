From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v2 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Wed, 16 Mar 2011 20:08:10 +0530
Message-ID: <20110316143810.GC10385@m-desktop>
References: <1299853215-8507-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38469 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137Ab1CPOkj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 10:40:39 -0400
Received: by mail-gx0-f170.google.com with SMTP id 27so1037841gxk.15
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 07:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1299853215-8507-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com

Hi Kevin,

On Fri, Mar 11, 2011 at 07:50:11PM +0530, G, Manjunath Kondaiah wrote:
> Patch series to support mstandby mode handling and enabling runtime PM
> support for DMA driver.
> 
> Changes from v1:
>  - fixed runtime_status issue if channel linking feature is used.
>  - fixed context restore issue during off mode.
>  - removed sysconfig register access during DMA context/restore
> 
> The review comments and alignment can be found at:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/53150
> 
> Baseline:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> Branch: omap-for-linus
> commit 94a06b74e724caabcf0464c81527cfbcae0c8aff
> Merge: 0dde52a 9062511
> Author: Tony Lindgren <tony@atomide.com>
> 
> Note: For OMAP2420 and OMAP2430, the patch series is tested on top of
> v2.6.38-rc4 since boot fails with latest mainline for the above OMAP's.
> 
> Build:
>  - omap1_defconfig
>  - omap2plus_defconfig
> 
> Boot test:
>  - OMAP1710 H3
>  - OMAP2420 H4
>  - OMAP2430 SDP
>  - OMAP3430 Zoom2
>  - OMAP3630 Zoom3
>  - OMAP4430 Blaze
> 
> DMA tests:
> The following dma test code is used for testing OMAP2+ boards:
> git://gitorious.org/omap-test/dmatest.git
> 
> Apart from that, offmode testing is done for OMAP3430-Zoom2 using the procedure:
> echo 1 > /debug/pm_debug/sleep_while_idle
> echo 1 > /debug/pm_debug/enable_off_mode
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> 
> With the above steps, core off mode count gets increasing if the the board
> is idle for more than 5 seconds.
> 
> Also, DMA transfers are done with forever option using:
> insmod ./dmatest.ko linking=1 forever=1 forever_period=1024 debug=1
> 
> The /sys/devices/platform/omap/omap_dma_system.0/power/runtime_status
> was verified and after completion of the tests, runtime_status will be 
> always suspended.
> 
> (Special thanks to Kevin Hilman for identifying runtime_status count issue 
> with DMA linking option).

Ping? Anymore comments on this series?

-Manjunath

> 
> G, Manjunath Kondaiah (4):
>   OMAP2+: PM: omap device: API's for handling mstandby mode
>   OMAP2+: DMA: prevent races while setting M idle mode to nostandby
>   OMAP: PM: DMA: Enable runtime pm
>   OMAP: DMA: Fix: context restore during off mode
> 
>  arch/arm/mach-omap1/dma.c                     |    1 +
>  arch/arm/mach-omap2/dma.c                     |   16 ++
>  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
>  arch/arm/plat-omap/dma.c                      |  194 +++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/dma.h         |    1 +
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>  arch/arm/plat-omap/omap_device.c              |   64 ++++++++
>  8 files changed, 293 insertions(+), 31 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
