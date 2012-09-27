From: Tony Lindgren <tony@atomide.com>
Subject: Re: Help needed with remaining plat headers
Date: Thu, 27 Sep 2012 13:26:16 -0700
Message-ID: <20120927202615.GS4840@atomide.com>
References: <20120920232907.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41743 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755000Ab2I0U0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 16:26:18 -0400
Content-Disposition: inline
In-Reply-To: <20120920232907.GN28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Afzal Mohammed <afzal@ti.com>, Felipe Balbi <balbi@ti.com>, Jon Hunter <jon-hunter@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>

Please see below a status update on the remaining problem
plat headers.

Note that all patches should be against current linux next
in this case.

* Tony Lindgren <tony@atomide.com> [120920 16:30]:
> 
> $ ls arch/arm/plat-omap/include/plat/
> clkdev_omap.h
> clock.h

Paul posted patches for the clock headers.

> common.h

I'll make common.h local.

> cpu.h

Making cpu.h local requires getting rid of cpu_is_omap/soc_is_omap
usage in drivers for mach-omap2+, so please fix your drivers!

> dma-44xx.h
> dma.h

Lokesh will post patches for the dma*.h files.

> dmtimer.h

Jon, can you do a patch for dmtimer.h?

> fpga.h

I'll make fpga.h local to mach-omap1.

> gpmc.h

Afzal, can you do a patch for gpmc.h?

> i2c.h

Will move to platform_data after defining register functions
locally.

> iommu2.h
> iommu.h
> iopgtable.h
> iovmm.h

There are io*.h patches posted for these by Ido that need
a bit more work to clear out the non-platform-data parts
that should be local to the driver.

> led.h

Will move to platform_data.

> mailbox.h

Omar, can you please do a patch that makes mailbox.h
suitable for include/linux/platform_data/mailbox-omap.h?

> menelaus.h

Will convert to be suitable for include/linux/platform_data.

> mmc.h

Will convert to be suitable for include/linux/platform_data.

> multi.h

Will make multi.h local.

> omap_device.h
> omap_hwmod.h

Will make omap_device.h and omap_hwmod.h local to mach-omap2.

> omap-pm.h
> omap-secure.h
> omap-serial.h

Will fix up for platform_data/serial-omap.h.

> prcm.h
> sdrc.h

Will make prcm.h and sdrc.h local to mach-omap2.

> serial.h

Will fix up for platform_data/serial-omap.h.

> sram.h

Will make sram.h local.

> tc.h

Will make tc.h local to mach-omap1.

> timex.h

Igor is looking into timex.h.

> uncompress.h

We can just move and disable the DEBUG_LL unless UART
address + shift are specified in Kconfig in a generic
way. I think this is already possible or patches have
been posted to LAKML?

> usb.h

Felipe can you do a patch for this one?

> vram.h
> vrfb.h

Tomi will post patches for vr*.h files.

Regards,

Tony
