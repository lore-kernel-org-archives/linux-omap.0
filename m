From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DMA: mstandby mode and runtime pm support
Date: Fri, 4 Mar 2011 09:48:26 +0530
Message-ID: <20110304041826.GA7025@m-desktop>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com>
 <87hbbkqcgk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59968 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758511Ab1CDEVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 23:21:21 -0500
Received: by gxk21 with SMTP id 21so622994gxk.10
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 20:21:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87hbbkqcgk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Thu, Mar 03, 2011 at 10:35:23AM -0800, Kevin Hilman wrote:
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > This patch series is remaining part of dma hwmod to support pm runtime 
> > and for handling mstandby mode for all applicable DMA mstandby mode errata.
> 
> This is still not runtime-suspending when I use my DMA test in linking
> mode.
> 
> If I put a large enough period between transfers, it should autosuspend
> during transfers.  It seems to do auto-suspend and resume once, but then
> it never suspends again.
> 
> I tested with my dmatest module[1], and loaded with:
> 
>   # insmod ./dmatest.ko linking=1 forever=1 forever_period=1024
> 
> Not only does it not auto-suspend between transfers (which I expected),
> it also doesn't suspend after removing the module which stops all active
> channels.

The normal chaining test cases are executed and which used to show the
proper status. Let me reproduce this issue with your test procedure.


> > The alignment for handling mstandby mode errata handling is at:
> > http://thread.gmane.org/gmane.linux.ports.arm.omap/47398/focus=47426
> > http://thread.gmane.org/gmane.linux.ports.arm.omap/47479/focus=47537
> >
> > Testing:
> > Compile tested for
> >  - omap1_defconfig
> >  - omap2plus_defconfig
> >
> > Boot test on:
> >  - OMAP1710-H3
> >  - OMAP2420-H4
> >  - OMAP3430-LDP
Sorry. It's OMAP3430 Zoom2 and not LDP.

-Manjunath

> >  - OMAP3630-Zoom3
> >  - OMAP4430-Blaze
> >
> > DMA memory to memory test cases(including chaining) are executed for
> > all the above boards and for each test case, 
> > /sys/devices/platform/omap/omap_dma_system.0/power/runtime_status
> > was verified and after completion of the tests, runtime_status will be 
> > always suspended.
> >
> > Apart from that, offmode testing is done for OMAP3430-LDP using the procedure:
> > echo 1 > /debug/pm_debug/sleep_while_idle
> > echo 1 > /debug/pm_debug/enable_off_mode
> > echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> > echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> > echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> >
> > With the above steps, core off mode count gets increasing if the the board
> > is idle for more than 5 seconds.
> >
> > Baseline:
> > Applies cleanly on top of mainline 2.6.38-rc6:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > commit f5412be599602124d2bdd49947b231dd77c0bf99
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Mon Feb 21 17:25:52 2011 -0800
> >
> >     Linux 2.6.38-rc6
> >
> > Note: OMAP1 is tested on top of 2.6.38-rc5 since rc6 is broken for omap1 build
> >
> > Patch Summary:
> > ==============
> > G, Manjunath Kondaiah (2):
> >   OMAP2+: PM: omap device: API's for handling mstandby mode
> >   OMAP2+: DMA: prevent races while setting M idle mode to nostandby
> >
> > Manjunath G Kondaiah (1):
> >   OMAP: PM: DMA: Enable runtime pm
> >
> >  arch/arm/mach-omap1/dma.c                     |    1 +
> >  arch/arm/mach-omap2/dma.c                     |   16 ++
> >  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
> >  arch/arm/plat-omap/dma.c                      |  190 +++++++++++++++++++++----
> >  arch/arm/plat-omap/include/plat/dma.h         |    1 +
> >  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
> >  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
> >  arch/arm/plat-omap/omap_device.c              |   64 +++++++++
> >  8 files changed, 293 insertions(+), 27 deletions(-)
