From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Mon, 19 Nov 2012 14:04:44 -0800
Message-ID: <20121119220443.GD18567@atomide.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com>
 <50A601FA.5060401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44798 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751904Ab2KSWEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 17:04:46 -0500
Content-Disposition: inline
In-Reply-To: <50A601FA.5060401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121116 01:08]:
> Hi Tony,
> 
> On 2012-11-13 00:50, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [121112 02:27]:
> >> Hi,
> >>
> >> This series changes omapfb to use standard dma_alloc funcs instead of omap
> >> specific vram allocator. This let's us remove the omap vram allocator, making
> >> omapfb platform independent.
> >>
> >> However, note that using standard dma funcs causes the following downsides:
> >>
> >> 1) dma_alloc_attrs doesn't let us allocate at certain physical address.
> >> However, this should not be a problem as this feature of vram allocator
> >> is only used when reserving the framebuffer that was initialized by the
> >> bootloader, and we don't currently support "passing" a framebuffer from
> >> the bootloader to the kernel anyway.
> >>
> >> 2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and
> >> we don't need the ioremap when using VRFB. This patch uses
> >> DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is currently
> >> not operational.
> >>
> >> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
> >> changed the ioctl to return 64M for all the values, which, I hope, the
> >> applications will interpret as "there's enough vram".
> >>
> >> 4) "vram" kernel parameter to define how much ram to reserve for video use no
> >> longer works. The user needs to enable CMA and use "cma" parameter.
> > 
> > Great, thanks for fixing these. Could you please queue these into
> > a separate branch against v3.7-rc5 that I can also merge into
> > omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3?
> 
> Should we enable CMA by default in omap2plus_defconfig? And perhaps on
> omap1 also?

Yes if that's now needed for DSS.
 
> I have to say I don't know the details of the dma allocation, but afaik
> there are no drawbacks with CMA. Although it is still marked
> EXPERIMENTAL in the kconfig...

I guess that's still fine as that's what we're supposed to use :)

Regards,

Tony 
