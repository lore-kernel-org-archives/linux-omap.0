From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 17:14:11 +0000
Message-ID: <20090119171411.GG18301@n2100.arm.linux.org.uk>
References: <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com> <20090119134329.GA18301@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com> <20090119135654.GB18301@n2100.arm.linux.org.uk> <op.un0ew10nl1df02@matts.therealanswer.com> <20090119152237.GC18301@n2100.arm.linux.org.uk> <op.un0ggdb6l1df02@matts.therealanswer.com> <20090119155857.GD18301@n2100.arm.linux.org.uk> <20090119161358.GE18301@n2100.arm.linux.org.uk> <op.un0kibrsl1df02@matts.therealanswer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49738 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZASROa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 12:14:30 -0500
Content-Disposition: inline
In-Reply-To: <op.un0kibrsl1df02@matts.therealanswer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Gerassimoff <mgeras@gmail.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 19, 2009 at 10:07:13AM -0700, Matt Gerassimoff wrote:
> On Mon, 19 Jan 2009 09:13:58 -0700, Russell King - ARM Linux  
> <linux@arm.linux.org.uk> wrote:
> 
> >diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> >index 18373f7..9f88dd3 100644
> >--- a/arch/arm/mm/ioremap.c
> >+++ b/arch/arm/mm/ioremap.c
> >@@ -138,7 +138,7 @@ void __check_kvm_seq(struct mm_struct *mm)
> >  */
> > static void unmap_area_sections(unsigned long virt, unsigned long size)
> > {
> >-	unsigned long addr = virt, end = virt + (size & ~SZ_1M);
> >+	unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
> > 	pgd_t *pgd;
> >	flush_cache_vunmap(addr, end);
> >@@ -337,10 +337,7 @@ void __iounmap(volatile void __iomem *io_addr)
> > 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> > #ifndef CONFIG_SMP
> > 	struct vm_struct **p, *tmp;
> >-#endif
> >-	unsigned int section_mapping = 0;
> >-#ifndef CONFIG_SMP
> > 	/*
> > 	 * If this is a section based mapping we need to handle it
> > 	 * specially as the VM subsystem does not know how to handle
> >@@ -352,11 +349,8 @@ void __iounmap(volatile void __iomem *io_addr)
> > 	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
> > 		if ((tmp->flags & VM_IOREMAP) && (tmp->addr == addr)) {
> > 			if (tmp->flags & VM_ARM_SECTION_MAPPING) {
> >-				*p = tmp->next;
> > 				unmap_area_sections((unsigned long)tmp->addr,
> > 						    tmp->size);
> >-				kfree(tmp);
> >-				section_mapping = 1;
> > 			}
> > 			break;
> > 		}
> >@@ -364,7 +358,6 @@ void __iounmap(volatile void __iomem *io_addr)
> > 	write_unlock(&vmlist_lock);
> > #endif
> >-	if (!section_mapping)
> >-		vunmap(addr);
> >+	vunmap(addr);
> > }
> > EXPORT_SYMBOL(__iounmap);
> 
> Before this is even tested.  I've went down this path.  You will receive a  
> ton
> of Bad PMD errors.  unmap_area_sections() and vunmap() don't play nice  
> together.
> This type of solution will require changes to unmap_area_sections().

Okay, I've just lost interest in persuing this bug any further.
