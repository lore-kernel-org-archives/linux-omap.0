From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 16:13:58 +0000
Message-ID: <20090119161358.GE18301@n2100.arm.linux.org.uk>
References: <1232360583.6481.92.camel@tubuntu> <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com> <20090119134329.GA18301@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com> <20090119135654.GB18301@n2100.arm.linux.org.uk> <op.un0ew10nl1df02@matts.therealanswer.com> <20090119152237.GC18301@n2100.arm.linux.org.uk> <op.un0ggdb6l1df02@matts.therealanswer.com> <20090119155857.GD18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57585 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZASQOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 11:14:17 -0500
Content-Disposition: inline
In-Reply-To: <20090119155857.GD18301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Gerassimoff <mgeras@gmail.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 19, 2009 at 03:58:57PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 19, 2009 at 08:39:39AM -0700, Matt Gerassimoff wrote:
> > >>But without that code, everything works 100%.  I'm not sure what all the
> > >>remap_area_sections()
> > >>code does, but the cleanup definitely does not work,  as the kernel OOPS
> > >>will testify.
> > >>There may be a better solution, but as far as I can tell, it's not  
> > >>really
> > >>needed.  Maybe
> > >>someone else will disagree.
> > >
> > >We might as well rip this code out then.  I'm all for simpler code, but  
> > >I'm
> > >sure the folk who want to squeeze the best performance out of their  
> > >machines
> > >will quickly squeel if I did that.
> > >
> > >And what cleanup are you referring to?
> > 
> > I meant freeing, not cleanup.  Sorry.
> 
> Okay, I won't include that bug fix with the fix I'm going to be working
> on, even though it's clearly a bug in its own right.  After all, it
> "definitely does not work" in your words.
> 
> (It may not fix the problem _you're_ seeing, but I assure you, that code
> as it stands is wrong.)
> 
> > As I said it's a start.  I'm all for performance but not at the expense
> > of integrity.  Right now the code doesn't work and needs to be fixed.
> 
> Yes, I think everyone realises that there is a bug here which needs
> fixing.
> 
> Unfortunately, vague "it fails" bug reports are utterly useless for
> finding bugs.  Your report provided that extra bit of information
> which points to where the real problem lies.
> 
> Now, I could be looking at finishing off what I'm currently working on
> so I can move on to fixing it instead of writing this message in reply
> to an obvious statement.

Right, ignoring everything about "that fix definitely does not work"
here's an as yet untested patch which should fix the problem.

The other thing to point out is that vunmap() does its work lazily
(as Richard tried to point out).  However, it'll become unlazy when
it has more than 32MB * NR_CPUS to deal with.  So, make sure that your
ioremap/vmalloc region is larger than 32MB otherwise you'll still see
crashes.

(That being the space between top of RAM + 8MB, and VMALLOC_END as seen
in Documentation/arm/memory.txt.)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 18373f7..9f88dd3 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -138,7 +138,7 @@ void __check_kvm_seq(struct mm_struct *mm)
  */
 static void unmap_area_sections(unsigned long virt, unsigned long size)
 {
-	unsigned long addr = virt, end = virt + (size & ~SZ_1M);
+	unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
 	pgd_t *pgd;
 
 	flush_cache_vunmap(addr, end);
@@ -337,10 +337,7 @@ void __iounmap(volatile void __iomem *io_addr)
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
 #ifndef CONFIG_SMP
 	struct vm_struct **p, *tmp;
-#endif
-	unsigned int section_mapping = 0;
 
-#ifndef CONFIG_SMP
 	/*
 	 * If this is a section based mapping we need to handle it
 	 * specially as the VM subsystem does not know how to handle
@@ -352,11 +349,8 @@ void __iounmap(volatile void __iomem *io_addr)
 	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
 		if ((tmp->flags & VM_IOREMAP) && (tmp->addr == addr)) {
 			if (tmp->flags & VM_ARM_SECTION_MAPPING) {
-				*p = tmp->next;
 				unmap_area_sections((unsigned long)tmp->addr,
 						    tmp->size);
-				kfree(tmp);
-				section_mapping = 1;
 			}
 			break;
 		}
@@ -364,7 +358,6 @@ void __iounmap(volatile void __iomem *io_addr)
 	write_unlock(&vmlist_lock);
 #endif
 
-	if (!section_mapping)
-		vunmap(addr);
+	vunmap(addr);
 }
 EXPORT_SYMBOL(__iounmap);
