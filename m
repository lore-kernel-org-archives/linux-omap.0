From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 12 Jul 2012 23:34:24 -0700
Message-ID: <20120713063423.GF1122@atomide.com>
References: <WC20120705150314.450045@terrafix.co.uk>
 <87zk77p3s5.fsf@ti.com>
 <WC20120711105003.8400AC@terrafix.co.uk>
 <87pq82kz0l.fsf@ti.com>
 <CALLhW=6p4AAUrpQmAFCTC2SYbAU_2F0roZ4Ha-NfE+oGn6zPbw@mail.gmail.com>
 <87wr2ahtqg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47564 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab2GMGe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 02:34:28 -0400
Content-Disposition: inline
In-Reply-To: <87wr2ahtqg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@ti.com> [120711 14:34]:
> Omar Ramirez Luna <omar.luna@linaro.org> writes:
> 
> > On 11 July 2012 12:07, Kevin Hilman <khilman@ti.com> wrote:
> > ...
> >>> [    2.311004] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> >>> [    2.317382] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
> >>> [    2.325256] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> >>> [    2.331512] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
> >>
> >> These are normal because DMA engine is not compiled in with
> >> omap2plus_defconfig.  MMC wont' work unless you build in DMA engine, but
> >> that doesn't matter for trying to figure out your problem.
> >
> > Hijacking this thread a little bit...
> >
> > It looks like a dependency is missing in Kconfig then, as this also
> > fails to boot if the file system is in MMC. As you pointed out
> > CONFIG_DMADEVICES and CONFIG_DMA_OMAP is needed to boot in this case.
> > I'm using a Panda 4460.
> 
> Yes, the drivers that have been converted to DMA engine should probably
> 'select DMADEVICES' and 'select DMA_OMAP' since they will now depend on
> DMA engine.

The drivers should also work with PIO if DMADEVICES is not selected.
If they don't it's a bug in the driver, or at least the driver probe
should return an error.

Regards,

Tony
