From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Mon, 17 May 2010 13:26:18 +0300
Message-ID: <1274091978.2307.49.camel@tubuntu.research.nokia.com>
References: <20100505150209.GC2606@n2100.arm.linux.org.uk>
	 <20100513174023.GB13001@n2100.arm.linux.org.uk>
	 <20100513211951.GH3428@atomide.com>
	 <20100513215825.GC13001@n2100.arm.linux.org.uk>
	 <20100513220139.GO3428@atomide.com>
	 <20100513221229.GD13001@n2100.arm.linux.org.uk>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
	 <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
	 <20100514101615.GF10339@n2100.arm.linux.org.uk>
	 <AANLkTinY9M2cHKw86hTLaMUCvBX57o8AioBtrENB-JhK@mail.gmail.com>
	 <20100517094421.GG23118@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50506 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab0EQK0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 06:26:37 -0400
In-Reply-To: <20100517094421.GG23118@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2010-05-17 at 11:44 +0200, ext Russell King - ARM Linux wrote:
> On Mon, May 17, 2010 at 12:38:55PM +0300, Grazvydas Ignotas wrote:
> > On Fri, May 14, 2010 at 1:16 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >> because it also uses reserve_bootmem() in
> > >> drivers/video/omap2/vram.c and later ioremap on RAM. Perhaps LMB can
> > >> be used to fix that too?
> > >
> > > WTF is reserve_bootmem doing in a driver?
> > 
> > IIRC Tony refused any new fb related code in arch/arm/*omap* so it
> > ended up there (or maybe because of something else, not that I had
> > anything to do with this).
> 
> Can someone please answer these questions:
> 
> 1. why does the framebuffer need to _reserve_ a set of specific sections
>    of SDRAM rather than _allocate_ a set of sections?
> 2. what range of sizes of SDRAM does the framebuffer driver need?

Yep, vram.c was first located in arch/arm/plat-omap/ but was moved under
drivers/video/omap2 by request from Tony. vram.c is not really a driver,
so in that sense I think it'd fit better into arch/arm/plat-omap/.

To question 1:

- The bootloader may use a certain area of memory to display to boot
image, and the kernel needs to use this same memory area for the
framebuffer, so that we don't get any glitches on the display during
boot. If this is not required, then the memory areas can be allocated.

- OMAP display hardware requires a continuous memory area for the
framebuffer. Allocating such a large continuous memory area later seemed
to be next to impossible, probably because of memory fragmentation.

- Originally I used dma_alloc_*, but that doesn't support the
bootloader-init case, and I also wanted to support having the
framebuffer in OMAP's SRAM. Also, if I recall right, dma_alloc_* didn't
support the huge allocations that are needed for the framebuffer.

To 2:
It varies a lot on the use case. One can configure the reserved VRAM
area, and I would imagine that the smallest would be something like
~150kB (320x240x2) and the largest in extreme case ~40MB (1600x1200*4,
x2 for double buffering and x3 for each overlay).

 Tomi


