From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DMA: mstandby mode and runtime pm support
Date: Thu, 03 Mar 2011 10:35:23 -0800
Message-ID: <87hbbkqcgk.fsf@ti.com>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33164 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133Ab1CCSf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 13:35:28 -0500
Received: by mail-iy0-f174.google.com with SMTP id 26so1462823iyb.5
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 10:35:27 -0800 (PST)
In-Reply-To: <1298542475-1460-1-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Thu, 24 Feb 2011 15:44:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> This patch series is remaining part of dma hwmod to support pm runtime 
> and for handling mstandby mode for all applicable DMA mstandby mode errata.

This is still not runtime-suspending when I use my DMA test in linking
mode.

If I put a large enough period between transfers, it should autosuspend
during transfers.  It seems to do auto-suspend and resume once, but then
it never suspends again.

I tested with my dmatest module[1], and loaded with:

  # insmod ./dmatest.ko linking=1 forever=1 forever_period=1024

Not only does it not auto-suspend between transfers (which I expected),
it also doesn't suspend after removing the module which stops all active
channels.

Kevin

[1] git://gitorious.org/omap-test/dmatest.git

> The alignment for pm runtime API's usage is at:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/51588/focus=52493
> http://thread.gmane.org/gmane.linux.ports.arm.omap/50762/focus=50840
>
> The alignment for handling mstandby mode errata handling is at:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/47398/focus=47426
> http://thread.gmane.org/gmane.linux.ports.arm.omap/47479/focus=47537
>
> Testing:
> Compile tested for
>  - omap1_defconfig
>  - omap2plus_defconfig
>
> Boot test on:
>  - OMAP1710-H3
>  - OMAP2420-H4
>  - OMAP3430-LDP
>  - OMAP3630-Zoom3
>  - OMAP4430-Blaze
>
> DMA memory to memory test cases(including chaining) are executed for
> all the above boards and for each test case, 
> /sys/devices/platform/omap/omap_dma_system.0/power/runtime_status
> was verified and after completion of the tests, runtime_status will be 
> always suspended.
>
> Apart from that, offmode testing is done for OMAP3430-LDP using the procedure:
> echo 1 > /debug/pm_debug/sleep_while_idle
> echo 1 > /debug/pm_debug/enable_off_mode
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>
> With the above steps, core off mode count gets increasing if the the board
> is idle for more than 5 seconds.
>
> Baseline:
> Applies cleanly on top of mainline 2.6.38-rc6:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> commit f5412be599602124d2bdd49947b231dd77c0bf99
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Feb 21 17:25:52 2011 -0800
>
>     Linux 2.6.38-rc6
>
> Note: OMAP1 is tested on top of 2.6.38-rc5 since rc6 is broken for omap1 build
>
> Patch Summary:
> ==============
> G, Manjunath Kondaiah (2):
>   OMAP2+: PM: omap device: API's for handling mstandby mode
>   OMAP2+: DMA: prevent races while setting M idle mode to nostandby
>
> Manjunath G Kondaiah (1):
>   OMAP: PM: DMA: Enable runtime pm
>
>  arch/arm/mach-omap1/dma.c                     |    1 +
>  arch/arm/mach-omap2/dma.c                     |   16 ++
>  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
>  arch/arm/plat-omap/dma.c                      |  190 +++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/dma.h         |    1 +
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>  arch/arm/plat-omap/omap_device.c              |   64 +++++++++
>  8 files changed, 293 insertions(+), 27 deletions(-)
