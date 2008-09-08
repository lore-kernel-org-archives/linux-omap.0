From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Mon, 08 Sep 2008 06:38:54 +0300 (EEST)
Message-ID: <20080908.063854.112344684.Hiroshi.DOYU@nokia.com>
References: <20080905224530.GE17156@flint.arm.linux.org.uk>
	<20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
	<20080907193619.GC10359@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18887 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbYIHDjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 23:39:14 -0400
In-Reply-To: <20080907193619.GC10359@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi Russell, thank you for reviewing.

From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Sun, 7 Sep 2008 20:36:20 +0100

> On Sat, Sep 06, 2008 at 03:56:35AM +0300, Hiroshi DOYU wrote:
> > Would it be possible to have "pmd_table()" definition "in pgtable.h"?
> 
> Well, the first question is... where has this come from, and why.
> 
> Looking at the omap tree, it's because of arch/arm/plat-omap/mmu.c,
> which seems to be somewhat weird and complex, duplicating some of
> what's going on elsewhere in the kernel.

I totally agree on this and this should be refactored anyway.

> (And with the changes I've just queued up for the next mainline merge
> window, this file will probably break because of it's use of the kernel
> page table macros.)

OK, I will drop it and see how mainline merge affects.

> A more portable way to do that would be to split out the innards of
> __arm_ioremap_pfn() into a separate function, and use that instead
> of exmap_set_armmmu().  Then, replace exmap_clear_armmmu() with
> unmap_area_sections() to tear down the ARM side of the mapping.

I got it. This code which keeps consistency with ARM MMU should be
replaced completedly by them.

> As far as 'mmu->twl_mm' goes, the only reason I can see for that
> existing is as a way to use the kernel's page table accessors to
> manipulate something that isn't used for as the CPU's page table,
> which in turn leads to quite a number of nasty hacks in the code.
> Really that wants to use its own accessors and macros, and twl_mm
> eliminated.  A mm_struct isn't small.  And by doing so, you'll
> avoid the bug and memory leak in omap_mmu_register().  kfree'ing
> (!) a mm_struct onto a different slab cache from whence it came!

Apart from the status of current "plat-omap/mmu.c", I cannot deny
completely the possibilty of applying kernel generic APIs to this
IOMMU driver in more cleaner manner because OMAP IOMMU is too
similar to the generic MMU handling and ARM MMU code are designed
quite flexible to afford the different versions of MMUs. I'm making a
reworking patches of this IOMMU. So if possible, please take a look at
them later.

  Hiroshi DOYU

