From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 15:22:37 +0000
Message-ID: <20090119152237.GC18301@n2100.arm.linux.org.uk>
References: <1232360583.6481.92.camel@tubuntu> <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com> <20090119134329.GA18301@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com> <20090119135654.GB18301@n2100.arm.linux.org.uk> <op.un0ew10nl1df02@matts.therealanswer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42942 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZASPWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 10:22:55 -0500
Content-Disposition: inline
In-Reply-To: <op.un0ew10nl1df02@matts.therealanswer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Gerassimoff <mgeras@gmail.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 19, 2009 at 08:06:27AM -0700, Matt Gerassimoff wrote:
> This issue is the reason I have subscribed to the mailing list.  I have  
> discovered the problem and had a quick patch to solve it.

It's not a solution, it's a work-around.  You're not seeing the problem
anymore because you've changed the code to avoid using section mappings.

That's fine if you want to eat lots of TLB entries for your mapping.

> The call to ioremap() is a macro that eventually gets to a routine  
> __arm_ioremap_pfn which is implemented in arch/arm/mm/ioremap.c.
> This function calls get_vm_area() which calls __get_vm_area_node()
> (both within mm/vmalloc.c).

Ok so far.

> Finally, there is a routine called alloc_vmap_area() which allocates and
> initialized a struct vmap_area.

And this is why we now have the problem.  When the ARM section based
ioremap implementation was written, none of that additional code
existed.

The reason we've ended up in this situation is because iounmap() is
doing the _insane_ thing and implementing its own method of freeing
independent of mm/vmalloc.c - this is called "fragile coding" and
must be avoided.

The solution is to fix iounmap() to use proper interfaces into mm/vmalloc.c
when removing the section and supersection mappings.

> The statement:
> 
> 	} else if (!((__pfn_to_phys(pfn) | size | addr) & ~PMD_MASK)) {
> 
> is the strange one.  I'm not what is being checked here except the  
> PMD_MASK.

	(a | b | c) & mask

	(a & mask) | (b & mask) | (c & mask)

	(a & mask) || (b & mask) || (c & mask)

and PMD_MASK is used to mask off the offset into a 2MB section.  So,
(a & ~PMD_MASK) gives the offset into the 2MB section.

So, the test is:

	- is the physical address aligned to 2MB
and
	- is the size aligned to 2MB
and
	- is the virtual address aligned to 2MB
then
	map using section mappings.

> But without that code, everything works 100%.  I'm not sure what all the  
> remap_area_sections()
> code does, but the cleanup definitely does not work,  as the kernel OOPS  
> will testify.
> There may be a better solution, but as far as I can tell, it's not really  
> needed.  Maybe
> someone else will disagree.

We might as well rip this code out then.  I'm all for simpler code, but I'm
sure the folk who want to squeeze the best performance out of their machines
will quickly squeel if I did that.

And what cleanup are you referring to?
