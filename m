From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 9 Jan 2014 05:06:25 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46741 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbaAIFHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 00:07:03 -0500
In-Reply-To: <52CD5D13.9090806@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Wednesday, January 08, 2014 7:44 PM
> To: Tony Lindgren; Ivaylo Dimitrov
> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
> 
> On 2014-01-08 01:59, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131230 05:21]:
> >> The omapfb driver uses dma_alloc to reserve memory for the framebuffers.
> >> However, on some use cases, even when CMA is in use, it's quite
> >> probable that omapfb fails to allocate the fb, either due to not
> >> enough free dma memory, fragmented dma memory, or CMA failing to make
> >> enough contiguous space.
> >>
> >> This patch adds a kernel cmdline parameter 'omapfb_vram' which can be
> >> used to give the size of a memory area reserved exclusively for
> >> omapfb, and optionally a physical address where the memory area is
> reserved.
> >>
> >> The memory area is reserved with memblock, and assigned to omapfb
> >> with dma_declare_coherent_memory. The dma_alloc function will first
> >> try to allocate the fb from the coherent memory area, and if that
> >> fails, it'll use the normal method of allocation.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> Cc: Ivaylo Dimitrov <freemangordon@abv.bg>
> >
> > Feel free to queue this along with the DSS patches:
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks.
> 
> This introduces new kernel boot parameter, and I haven't really had time to test
> and think about this. If Ivaylo doesn't insist on this to be merged for 3.14, I'd
> rather leave this for 3.15 as adding new parameter that we need to support
> "forever" should be thought a bit more.
> 
Tomi,

I am seeing underflow issue on AM43x device if I use omapfb_vram argument.
Did you see this on OMAP?

I am using "omapfb_vram=10M@0xA0000000", and I believe it is correct way of usage.

Thanks,
Vaibhav


>  Tomi
> 

