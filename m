From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Mon, 17 May 2010 10:37:16 -0700
Message-ID: <20100517173715.GA5818@atomide.com>
References: <20100513211951.GH3428@atomide.com>
 <20100513215825.GC13001@n2100.arm.linux.org.uk>
 <20100513220139.GO3428@atomide.com>
 <20100513221229.GD13001@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
 <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
 <20100514101615.GF10339@n2100.arm.linux.org.uk>
 <AANLkTinY9M2cHKw86hTLaMUCvBX57o8AioBtrENB-JhK@mail.gmail.com>
 <20100517094421.GG23118@n2100.arm.linux.org.uk>
 <1274091978.2307.49.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52889 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0EQRhd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 13:37:33 -0400
Content-Disposition: inline
In-Reply-To: <1274091978.2307.49.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100517 03:21]:
> Hi,
> 
> On Mon, 2010-05-17 at 11:44 +0200, ext Russell King - ARM Linux wrote:
> > On Mon, May 17, 2010 at 12:38:55PM +0300, Grazvydas Ignotas wrote:
> > > On Fri, May 14, 2010 at 1:16 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > >> because it also uses reserve_bootmem() in
> > > >> drivers/video/omap2/vram.c and later ioremap on RAM. Perhaps LMB can
> > > >> be used to fix that too?
> > > >
> > > > WTF is reserve_bootmem doing in a driver?
> > > 
> > > IIRC Tony refused any new fb related code in arch/arm/*omap* so it
> > > ended up there (or maybe because of something else, not that I had
> > > anything to do with this).
> > 
> > Can someone please answer these questions:
> > 
> > 1. why does the framebuffer need to _reserve_ a set of specific sections
> >    of SDRAM rather than _allocate_ a set of sections?
> > 2. what range of sizes of SDRAM does the framebuffer driver need?
> 
> Yep, vram.c was first located in arch/arm/plat-omap/ but was moved under
> drivers/video/omap2 by request from Tony. vram.c is not really a driver,
> so in that sense I think it'd fit better into arch/arm/plat-omap/.
> 
> To question 1:
> 
> - The bootloader may use a certain area of memory to display to boot
> image, and the kernel needs to use this same memory area for the
> framebuffer, so that we don't get any glitches on the display during
> boot. If this is not required, then the memory areas can be allocated.
> 
> - OMAP display hardware requires a continuous memory area for the
> framebuffer. Allocating such a large continuous memory area later seemed
> to be next to impossible, probably because of memory fragmentation.
> 
> - Originally I used dma_alloc_*, but that doesn't support the
> bootloader-init case, and I also wanted to support having the
> framebuffer in OMAP's SRAM. Also, if I recall right, dma_alloc_* didn't
> support the huge allocations that are needed for the framebuffer.
> 
> To 2:
> It varies a lot on the use case. One can configure the reserved VRAM
> area, and I would imagine that the smallest would be something like
> ~150kB (320x240x2) and the largest in extreme case ~40MB (1600x1200*4,
> x2 for double buffering and x3 for each overlay).

Sorry if I've been confused about what vram.c is doing.

How about change vram.c to use dma_alloc_coherent for now? That would
break the non-standard behaviour to preserve the log set by the
bootloader, but that should be OK until we know how to deal with that
properly.

After that you could just optionally reserve the bootloader memory
area using LMB based on some flags in the platform init data.

Regards,

Tony
