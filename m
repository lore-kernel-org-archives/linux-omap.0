From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Sun, 7 Sep 2008 20:36:20 +0100
Message-ID: <20080907193619.GC10359@flint.arm.linux.org.uk>
References: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com> <20080905172133.GM24202@atomide.com> <20080905224530.GE17156@flint.arm.linux.org.uk> <20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53940 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbYIGTgj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 15:36:39 -0400
Content-Disposition: inline
In-Reply-To: <20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Sat, Sep 06, 2008 at 03:56:35AM +0300, Hiroshi DOYU wrote:
> Would it be possible to have "pmd_table()" definition "in pgtable.h"?

Well, the first question is... where has this come from, and why.

Looking at the omap tree, it's because of arch/arm/plat-omap/mmu.c,
which seems to be somewhat weird and complex, duplicating some of
what's going on elsewhere in the kernel.

(And with the changes I've just queued up for the next mainline merge
window, this file will probably break because of it's use of the kernel
page table macros.)

A more portable way to do that would be to split out the innards of
__arm_ioremap_pfn() into a separate function, and use that instead
of exmap_set_armmmu().  Then, replace exmap_clear_armmmu() with
unmap_area_sections() to tear down the ARM side of the mapping.

As far as 'mmu->twl_mm' goes, the only reason I can see for that
existing is as a way to use the kernel's page table accessors to
manipulate something that isn't used for as the CPU's page table,
which in turn leads to quite a number of nasty hacks in the code.
Really that wants to use its own accessors and macros, and twl_mm
eliminated.  A mm_struct isn't small.  And by doing so, you'll
avoid the bug and memory leak in omap_mmu_register().  kfree'ing
(!) a mm_struct onto a different slab cache from whence it came!

Which probably will mean that there ends up only being one place
where the construct which pmd_table() is replacing exists.
