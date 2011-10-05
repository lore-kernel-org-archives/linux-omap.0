From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 4 Oct 2011 17:42:08 -0700
Message-ID: <20111005004208.GW6324@atomide.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <20111003224411.GA19897@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
 <20111004225424.GA32102@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041900590.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46967 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914Ab1JEAmM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 20:42:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110041900590.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111004 15:47]:
> On Tue, 4 Oct 2011, Russell King - ARM Linux wrote:
> 
> > On Tue, Oct 04, 2011 at 05:10:36PM -0400, Nicolas Pitre wrote:
> > > Which makes me think... with all those architectures intercepting 
> > > ioremap calls in order to provide an equivalent static mapping address, 
> > > they already get an unexpected domain given that static mappings are 
> > > mostly DOMAIN_IO and not DOMAIN_KERNEL as would result from an non 
> > > intercepted ioremap call.
> > 
> > That's a necessary evil - otherwise we have to separate out the
> > ioremap from vmalloc.
> > 
> > Incidentally, how are you dealing with the problem of a static mapping
> > setting up a L1 page table entry for DOMAIN_IO, and then a vmalloc
> > request coming in, overlapping that L1 page table?
> > 
> > If this memory then gets accessed with get_user() with set_fs(get_ds()),
> > the kernel will oops as we don't switch DOMAIN_IO memory on set_fs().
> > (I don't know if this happens in practice, but there's nothing to say
> > that it's illegal to do this.)
> 
> I suppose that didn't happen so far.  Granted, moving the ioremap 
> optimization into core code for all machines will increase the 
> possibility for this to happen, even if still small.
> 
> With CPU_USE_DOMAINS not set, set_fs() is a no-op anyway, besides 
> addr_limit that is.
> 
> Is there a strong benefit in having static mappings being DOMAIN_IO 
> instead of DOMAIN_KERNEL?

In any case, I suggest we add the following __arm_ioremap_exec patch
and then sort out issues with it as they show up.

This allows further work on the common SRAM genalloc patches and generic
map_io patches.

Nico, I already have a series converting omap2+ to use the the patch
below, and it seems to be working just fine for SRAM. I'll post that
series separately shortly. Maybe take a look and see if that allows
you to do the generic map_io changes?

I still also need to convert omap1 too, but will do that a bit later.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 4 Oct 2011 17:22:16 -0700
Subject: [PATCH] ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY

This allows mapping external memory such as SRAM for use.

This is needed for some small chunks of code, such as reprogramming
SDRAM memory source clocks that can't be executed in SDRAM. Other
use cases include some PM related code.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -80,6 +80,7 @@ extern void __iomem *__arm_ioremap_caller(unsigned long, size_t, unsigned int,
 
 extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long, size_t, unsigned int);
 extern void __iomem *__arm_ioremap(unsigned long, size_t, unsigned int);
+extern void __iomem *__arm_ioremap_exec(unsigned long, size_t, int cached);
 extern void __iounmap(volatile void __iomem *addr);
 
 /*
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -289,6 +289,28 @@ __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
+/*
+ * Remap an arbitrary physical address space into the kernel virtual
+ * address space as memory. Needed when the kernel wants to execute
+ * code in external memory. This is needed for reprogramming source
+ * clocks that would affect normal memory for example. Please see
+ * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
+ */
+void __iomem *
+__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)
+{
+	unsigned int mtype;
+
+	if (cached)
+		mtype = MT_MEMORY;
+	else
+		mtype = MT_MEMORY_NONCACHED;
+
+	return __arm_ioremap_caller(phys_addr, size, mtype,
+			__builtin_return_address(0));
+}
+EXPORT_SYMBOL(__arm_ioremap_exec);
+
 void __iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
