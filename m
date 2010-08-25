From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Wed, 25 Aug 2010 14:43:18 +0300
Message-ID: <1282736598.9299.203.camel@tubuntu.research.nokia.com>
References: <1281962906.1888.25.camel@chotu>
	 <4C72192A.9050801@compulab.co.il>	<4C721DFA.9010009@compulab.co.il>
	 <1282723542.9299.87.camel@tubuntu.research.nokia.com>
	 <AANLkTik=kZEfdwP1kvtm=f0egwcAEm4WjXMeSCG_4_8+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:20447 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab0HYLnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 07:43:55 -0400
In-Reply-To: <AANLkTik=kZEfdwP1kvtm=f0egwcAEm4WjXMeSCG_4_8+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, ext Tony Lindgren <tony@atomide.com>

On Wed, 2010-08-25 at 11:21 +0200, ext Grazvydas Ignotas wrote:
> Let's CC Russell for this one.
> 
> On Wed, Aug 25, 2010 at 11:05 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > On Mon, 2010-08-23 at 09:06 +0200, ext Mike Rapoport wrote:
> >> Mike Rapoport wrote:
> >
> >>  From 81e9278ad27bc91be42105321e0e26d0be9e883b Mon Sep 17 00:00:00 2001
> >> From: Mike Rapoport <mike@compulab.co.il>
> >> Date: Mon, 23 Aug 2010 09:40:09 +0300
> >> Subject: [PATCH] OMAP: DSS2: OMAPFB: use phys_to_virt for RAM mappings
> >>
> >> After commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8 (ARM: Prohibit
> >> ioremap() on kernel managed RAM) it is impossible to ioremap SDRAM for
> >> the framebuffer. Use phys_to_virt for kernel managed RAM mapping and
> >> ioremap for other memory types
> >
> > Hmm. omapfb reserves/allocates the ram using memblock, and obviously
> > memory from memblock is "kernel managed RAM". What does it mean? The RAM
> > is already mapped? I guess so, if phys_to_virt() works. (I guess the
> > whole RAM is mapped automatically). With what caching? How can we get
> > writecombining for this memory?
> >
> > Looking at the description of "ARM: Prohibit ioremap() on kernel managed
> > RAM" it sounds to me that we cannot have writecombining for framebuffer
> > memory, if it's "kernel managed RAM".

I'll try to summarize how the framebuffer memory is used with OMAP:

We have two kinds of memories:
- SRAM
- SDRAM

We have two ways to get the memory (done with memblock):
- Allocate, when we don't care about the address
- Reserve, when the bootloader has initialized a region of memory for
fb, and we want to use that

We have two ways to access the memories:
- Direct (ie. access it normally)
- VRFB (only for SDRAM)

VRFB is a HW block doing rotation. VRFB does not have any memory of its
own, but it uses a given region of SDRAM to store the pixels in a custom
format. VRFB has 4 regions, corresponding to 0, 90, 180 and 270 degree
rotations, and the user uses these regions to access the pixels, and
VRFB does the rotation on the fly.

We have three users for the memory:
- HW (DSS, DSP, SGX, ...)
- CPU inside kernel
- CPU inside user space

---

Some points:

- The memory for kernel is mapped with ioremap_wc().
- The memory for user space is mapped with io_remap_pfn_range(), and is
using pgprot_writecombine.

- When using VRFB, the SDRAM is accessed only by VRFB and thus does not
need to be mapped. VRFB regions can be ioremapped normally.

- SRAM can probably be ioremapped normally, as it's not normal kernel
managed RAM.

- In many cases we wouldn't need to ioremap inside the kernel at all, as
the kernel doesn't really need to read/write from/to the framebuffer. I
think the only user for this is the framebuffer console, which can be
disabled.

- I'm not really familiar with caching for ARM, but I believe the
framebuffer should use writecombining.

- There is dma_alloc_coherent, but that doesn't allow us to get the
memory at certain location, and at least previously it didn't support
allocating large enough buffers. Also, dma_alloc_coherent always maps
the memory for kernel, which is not required in some cases.

---

Questions, aimed at no one particular.

- Is all of the SDRAM automatically mapped, and so using phys_to_virt()
instead of ioremap() is ok?
- If ioremap()'ing SDRAM is not ok, is io_remap_pfn_range() and using
pgprot_writecombine also not ok?
- If we want to have different caching, how can we do that?
- Is it possible to get a memory area with memblock that would not be
part of the kernel managed RAM?
- And generally, what would be the best way to handle this all? =)

 Tomi




