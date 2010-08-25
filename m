From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: DSS2 broken with 36-rc1
Date: Wed, 25 Aug 2010 19:51:52 +0100
Message-ID: <20100825185152.GB30772@n2100.arm.linux.org.uk>
References: <1281962906.1888.25.camel@chotu> <4C72192A.9050801@compulab.co.il> <4C721DFA.9010009@compulab.co.il> <1282723542.9299.87.camel@tubuntu.research.nokia.com> <AANLkTik=kZEfdwP1kvtm=f0egwcAEm4WjXMeSCG_4_8+@mail.gmail.com> <1282736598.9299.203.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55312 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab0HYSwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 14:52:19 -0400
Content-Disposition: inline
In-Reply-To: <1282736598.9299.203.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Grazvydas Ignotas <notasas@gmail.com>, Mike Rapoport <mike@compulab.co.il>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

I'll respond more fully when I'm back in September.

On Wed, Aug 25, 2010 at 02:43:18PM +0300, Tomi Valkeinen wrote:
> I'll try to summarize how the framebuffer memory is used with OMAP:
> 
> We have two kinds of memories:
> - SRAM
> - SDRAM
> 
> We have two ways to get the memory (done with memblock):
> - Allocate, when we don't care about the address
> - Reserve, when the bootloader has initialized a region of memory for
> fb, and we want to use that
> 
> We have two ways to access the memories:
> - Direct (ie. access it normally)
> - VRFB (only for SDRAM)
> 
> VRFB is a HW block doing rotation. VRFB does not have any memory of its
> own, but it uses a given region of SDRAM to store the pixels in a custom
> format. VRFB has 4 regions, corresponding to 0, 90, 180 and 270 degree
> rotations, and the user uses these regions to access the pixels, and
> VRFB does the rotation on the fly.
> 
> We have three users for the memory:
> - HW (DSS, DSP, SGX, ...)
> - CPU inside kernel
> - CPU inside user space
> 
> ---
> 
> Some points:
> 
> - The memory for kernel is mapped with ioremap_wc().
> - The memory for user space is mapped with io_remap_pfn_range(), and is
> using pgprot_writecombine.

These two are fine when you consider only these two mappings.  However,
when you also consider that the memory is also mapped by the kernel as
a fully cacheable mapping, that's where the problem appears.

> - When using VRFB, the SDRAM is accessed only by VRFB and thus does not
> need to be mapped. VRFB regions can be ioremapped normally.

If this SDRAM isn't declared to the kernel, then that sounds fine.

> - SRAM can probably be ioremapped normally, as it's not normal kernel
> managed RAM.

Correct.

> - In many cases we wouldn't need to ioremap inside the kernel at all, as
> the kernel doesn't really need to read/write from/to the framebuffer. I
> think the only user for this is the framebuffer console, which can be
> disabled.

I'm not sure that it's possible to omit the virtual mapping of the
framebuffer - that's a question for the framebuffer people.

> - I'm not really familiar with caching for ARM, but I believe the
> framebuffer should use writecombining.

Yes it should, otherwise writes won't happen in a timely manner, and you
can have cache-visible effects apparant when things are being updated.

> - There is dma_alloc_coherent, but that doesn't allow us to get the
> memory at certain location, and at least previously it didn't support
> allocating large enough buffers. Also, dma_alloc_coherent always maps
> the memory for kernel, which is not required in some cases.

dma_alloc_coherent() is bounded by:
1. the size of the coherent region
2. the maximum size that alloc_pages() can allocate.

(1) can be expanded to increase the available mapping area.  (2) is a
harder problem to solve.

There is, however, talk about changing the dma_declare_coherent_memory()
interface such that we can give it SDRAM without it using ioremap().
This memory is available via dma_alloc_coherent(), and this is probably
a better solution to this problem.

The down side is that the memory will be set aside for the device, and
won't be available for other uses.

> Questions, aimed at no one particular.
> 
> - Is all of the SDRAM automatically mapped, and so using phys_to_virt()
> instead of ioremap() is ok?

Everything except memory deemed to be in the highmem range.

> - If ioremap()'ing SDRAM is not ok, is io_remap_pfn_range() and using
> pgprot_writecombine also not ok?

Correct - the problem is when you have multiple mappings of a physical
address with a different memory type (memory/device/strongly ordered)
or different memory cache attributes (write combine/writeback read alloc/
writeback write alloc etc).  Mappings of the same region with different
attributes is architecturally unpredictable.

Note that dma_alloc_coherent() suffers from this and needs to be fixed,
and is something I'll be working on over the next couple of months.

> - If we want to have different caching, how can we do that?

Good question, one which I don't yet have a definite answer for.

One of the problems we face is that with the kernel's mapping of SDRAM,
it is not easy to change or unmap sections of that mapping as it is
duplicated across every page table in the system - and with SMP systems
these page tables could well be in use on other processors.

The problem there is that dma_alloc_coherent() is supposed to work from
interrupt context - and we can't talk to the other processors from IRQ
context to ensure TLB coherence...

All very nasty.

> - Is it possible to get a memory area with memblock that would not be
> part of the kernel managed RAM?

SDRAM marked as reserved in memblock is still mapped - because reserved
memory contains things like the kernel, initial page table and such
like.  The other issue is that we map memory using 1MB sections, so
this memory which you want unmapped must be multiples of 1MB.

> - And generally, what would be the best way to handle this all? =)

We haven't got that far yet...
