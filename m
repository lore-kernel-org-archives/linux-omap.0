From: "Matt Gerassimoff" <mgeras@gmail.com>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 10:47:52 -0700
Message-ID: <op.un0md2f7l1df02@matts.therealanswer.com>
References: <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com>
 <20090119134329.GA18301@n2100.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
 <20090119135654.GB18301@n2100.arm.linux.org.uk>
 <op.un0ew10nl1df02@matts.therealanswer.com>
 <20090119152237.GC18301@n2100.arm.linux.org.uk>
 <op.un0ggdb6l1df02@matts.therealanswer.com>
 <20090119155857.GD18301@n2100.arm.linux.org.uk>
 <20090119161358.GE18301@n2100.arm.linux.org.uk>
 <op.un0kibrsl1df02@matts.therealanswer.com>
 <20090119171411.GG18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:59156 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZASRsC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 12:48:02 -0500
Received: by ug-out-1314.google.com with SMTP id 39so219748ugf.37
        for <linux-omap@vger.kernel.org>; Mon, 19 Jan 2009 09:47:59 -0800 (PST)
In-Reply-To: <20090119171411.GG18301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 19 Jan 2009 10:14:11 -0700, Russell King - ARM Linux  
<linux@arm.linux.org.uk> wrote:

> On Mon, Jan 19, 2009 at 10:07:13AM -0700, Matt Gerassimoff wrote:
>> On Mon, 19 Jan 2009 09:13:58 -0700, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>
>> >diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
>> >index 18373f7..9f88dd3 100644
>> >--- a/arch/arm/mm/ioremap.c
>> >+++ b/arch/arm/mm/ioremap.c
>> >@@ -138,7 +138,7 @@ void __check_kvm_seq(struct mm_struct *mm)
>> >  */
>> > static void unmap_area_sections(unsigned long virt, unsigned long  
>> size)
>> > {
>> >-	unsigned long addr = virt, end = virt + (size & ~SZ_1M);
>> >+	unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
>> > 	pgd_t *pgd;
>> >	flush_cache_vunmap(addr, end);
>> >@@ -337,10 +337,7 @@ void __iounmap(volatile void __iomem *io_addr)
>> > 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
>> > #ifndef CONFIG_SMP
>> > 	struct vm_struct **p, *tmp;
>> >-#endif
>> >-	unsigned int section_mapping = 0;
>> >-#ifndef CONFIG_SMP
>> > 	/*
>> > 	 * If this is a section based mapping we need to handle it
>> > 	 * specially as the VM subsystem does not know how to handle
>> >@@ -352,11 +349,8 @@ void __iounmap(volatile void __iomem *io_addr)
>> > 	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
>> > 		if ((tmp->flags & VM_IOREMAP) && (tmp->addr == addr)) {
>> > 			if (tmp->flags & VM_ARM_SECTION_MAPPING) {
>> >-				*p = tmp->next;
>> > 				unmap_area_sections((unsigned long)tmp->addr,
>> > 						    tmp->size);
>> >-				kfree(tmp);
>> >-				section_mapping = 1;
>> > 			}
>> > 			break;
>> > 		}
>> >@@ -364,7 +358,6 @@ void __iounmap(volatile void __iomem *io_addr)
>> > 	write_unlock(&vmlist_lock);
>> > #endif
>> >-	if (!section_mapping)
>> >-		vunmap(addr);
>> >+	vunmap(addr);
>> > }
>> > EXPORT_SYMBOL(__iounmap);
>>
>> Before this is even tested.  I've went down this path.  You will  
>> receive a
>> ton
>> of Bad PMD errors.  unmap_area_sections() and vunmap() don't play nice
>> together.
>> This type of solution will require changes to unmap_area_sections().
>
> Okay, I've just lost interest in persuing this bug any further.

I mis-spoke, the changes required are in remap_area_sections().  They
are not doing proper manipulations to the pmd information.  If
remap_area_sections() is fixed, there will be no need for  
unmap_area_sections()
as vunmap() will do all the work as far as I can tell.

 From that statement you just made, where does that leave us?  This in my  
estimation
is a MAJOR issue.  If you need help testing this, I'll be happy to do so.   
It may be
faster for you to create a simple kernel module that ioremap() on module  
init and
iounmep() on module exit.  Printing the returned virtual address from  
ioremap() on
each load will yeild a higher and higher addresses until it returns a NULL  
pointer
and kernel OOPS.  I'm running on a at91sam9260 and it will fail on about 6  
to 10
load/unload cycles of the kernel module.  So it happens pretty fast.

-- 
Matt
