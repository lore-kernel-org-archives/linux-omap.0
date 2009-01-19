From: "Matt Gerassimoff" <mgeras@gmail.com>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 08:06:27 -0700
Message-ID: <op.un0ew10nl1df02@matts.therealanswer.com>
References: <1232360583.6481.92.camel@tubuntu>
 <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com>
 <20090119134329.GA18301@n2100.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
 <20090119135654.GB18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:25848 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbZASPGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 10:06:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2649143rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Jan 2009 07:06:30 -0800 (PST)
In-Reply-To: <20090119135654.GB18301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 19 Jan 2009 06:56:54 -0700, Russell King - ARM Linux  
<linux@arm.linux.org.uk> wrote:

> There are no L2 PTE tables for section and supersection mappings, so this
> is irrelevent.  Section and supersection mappings live in the L1 page
> table which persists for the lifetime of the task.
>
> As such, ioremap/iounmap are only allocating and freeing a small  
> structure
> to account for the allocation - if things are so tight that 6-7 loops
> causes that allocation to fail, you're not going to be able to run any
> userspace programs.

This issue is the reason I have subscribed to the mailing list.  I have  
discovered
the problem and had a quick patch to solve it.  Basically when I call  
ioremap() and
then iounmap() (loading and unloading a module) successively, I get a  
different
virtual address each time.  Eventually, it causes an invalid pointer and  
causes
and OOPS.  The solution is not optimal but it may point to the actual  
problem.
The call to ioremap() is a macro that eventually gets to a routine  
__arm_ioremap_pfn
which is implemented in arch/arm/mm/ioremap.c.  This function calls  
get_vm_area()
which calls __get_vm_area_node() (both within mm/vmalloc.c).  Finally,  
there is a
routine called alloc_vmap_area() which allocates and initialized a struct  
vmap_area.
The __iounmap() function (also implemented in arch/arm/mm/ioremap.c) never  
takes the
struct vmap_area into account.   Looking through the sources, it's not  
easy to get
a pointer to that structure from a struct vm_struct pointer.  So I went  
back to
__arm_ioremap_pfn() and found a line that is completely baffling.  I  
#ifdef'd it out
to test and it completely solved the problem.  Here is a simple patch to  
offending
area of code:

---
  arch/arm/mm/ioremap.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 18373f7..e7d2b24 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -297,9 +297,11 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long  
offset,
                !((__pfn_to_phys(pfn) | size | addr) & ~SUPERSECTION_MASK))  
{
                 area->flags |= VM_ARM_SECTION_MAPPING;
                 err = remap_area_supersections(addr, pfn, size, type);
+#if 0
         } else if (!((__pfn_to_phys(pfn) | size | addr) & ~PMD_MASK)) {
                 area->flags |= VM_ARM_SECTION_MAPPING;
                 err = remap_area_sections(addr, pfn, size, type);
+#endif
         } else
  #endif
                 err = remap_area_pages(addr, pfn, size, type);
--
1.6.0.6

The statement:

	} else if (!((__pfn_to_phys(pfn) | size | addr) & ~PMD_MASK)) {

is the strange one.  I'm not what is being checked here except the  
PMD_MASK.
But without that code, everything works 100%.  I'm not sure what all the  
remap_area_sections()
code does, but the cleanup definitely does not work,  as the kernel OOPS  
will testify.
There may be a better solution, but as far as I can tell, it's not really  
needed.  Maybe
someone else will disagree.

Matt
