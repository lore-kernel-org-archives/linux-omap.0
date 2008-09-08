From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/4] ARM: OMAP: IOMMU driver: Core part
Date: Mon, 08 Sep 2008 15:13:47 +0300 (EEST)
Message-ID: <20080908.151347.45828742.Hiroshi.DOYU@nokia.com>
References: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<20080908104650.GB14832@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54325 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbYIHMOa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 08:14:30 -0400
In-Reply-To: <20080908104650.GB14832@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com

Hi Russell,

From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: OMAP: IOMMU driver: Core part
Date: Mon, 8 Sep 2008 11:46:50 +0100

> On Mon, Sep 08, 2008 at 08:56:30AM +0300, Hiroshi DOYU wrote:
> > +/* MMU object handler */
> > +struct iommu {
> > +	/* MMU */
> > +	int		type;
> > +	char		*name;
> > +	struct clk	*clk;
> > +	void __iomem	*regbase;
> > +	unsigned long	regsize;
> > +	unsigned long	flag;
> > +	struct device	*dev;
> > +
> > +	/* TWL */
> > +	struct mm_struct	*twl_mm;
> 
> mm_struct is a non-trivial size - why do you need it?

This is because I thought that "mm_struct" can manage VMAs as well as
pagetable. What I wanted to do is to do the same thing which linux VM
module does, then on-demand loading and others can be implemented here
too in the same manner, instead of introducing the home-brewed bitmap
management of IOMMU's virtual address area.

Anyway, I will consider if own struct can do the same thing again;)

> > +	void (*isr)(struct iommu *obj);
> > +
> > +	/* TLB */
> > +	int		nr_tlb_entries;
> > +	int		irq;
> > +};
> > +
> > +struct cr_regs {
> > +	union {
> > +		struct {
> > +			u16 cam_l;
> > +			u16 cam_h;
> > +		};
> > +		u32 cam;
> > +	};
> > +	union {
> > +		struct {
> > +			u16 ram_l;
> > +			u16 ram_h;
> > +		};
> > +		u32 ram;
> > +	};
> 
> Making assumptions about the endianness - is OMAP guaranteed to always be
> little endian?

Not but this order doesn't matter actually. "*_l" and "*_h" is for
OMAP1 case just because its register access width is 16 bit wide.

> > +};
> > +
> > +/*

<snip>

> > + *
> > + *	TWL operations (H/W pagetable)
> > + *
> > + */
> > +static inline void twl_alloc_section(struct mm_struct *mm, unsigned long va,
> > +				     unsigned long pa, int prot)
> > +{
> > +	pmd_t *pmdp = pmd_offset(pgd_offset(mm, va), va);
> > +	if (va & (1 << SECTION_SHIFT))
> > +		pmdp++;
> > +	*pmdp = __pmd((pa & SECTION_MASK) | prot | PMD_TYPE_SECT);
> > +	flush_pmd_entry(pmdp);
> 
> Using own accessor macros rather than the kernel's page table accessors
> would be better, and insulate you from changes made there.  I'd also
> suggest replacing 'va' with something else (maybe 'da') to make it
> obvious that we're not talking about the host CPU's virtual address space.

Agreed. Thank you for your proposal code. It looks quite cool!.

> > +}
> > +

<snip>

> > +	return err;
> > +}
> 
> So, this all becomes something like (untested):

Thanks, the following gets much cooler, expecially nice flushing
functions.

> 
> #define IOPGD_SHIFT		20
> #define IOPTE_SHIFT		12
> #define IOPTE_SIZE		(1 << (IOPGD_SHIFT - IOPTE_SHIFT))
> #define IOSECTION_MASK		(~((1 << IOPGD_SHIFT) - 1))

<snip>

> Freeing the page table, leaving a reference to it inside the page
> table structure.  So when the page gets re-used, the IOMMU ends up
> trying to walk whatever new data is in that page.  Not nice.

The above stored usecount concept is also cool to be efficient.

> 
> 	u32 *iopgd = iopgd_offset(obj, va);
> 
> 	if (!*iopgd)
> 		return;	
> 
> 	if ((u32)*iopgd & IOPGD_TABLE) {
> 		u32 *iopte = iopte_offset(iopgd, va);
> 		*iopte = 0;
> 		flush_iopte_range(iopte, iopte);
> 		
> 		iopte = iopte_offset(iopgd, 0);
> 		for (i = 0; i < IOPTE_SIZE; i++)
> 			if (iopte[i])
> 				return;
> 		iopte_free(iopte);
> 	}
> 	*iopgd = NULL;
> 	flush_iopgd_range(iopgd, iopgd);
> 
> However, how often is a single entry cleared?  Would it be better not to
> free the page table, but to have a function which walks the entire page
> table tree freeing all the tables?

It may be better, but honestly no idea for now. I will consider this
later.

> > +}
> > +
> > +void iotwl_pte_clear(struct iommu *obj, unsigned long va)
> > +{
> > +	struct mm_struct *mm = obj->twl_mm;
> > +
> > +	spin_lock(&mm->page_table_lock);
> > +
> > +	twl_pte_clear(obj, va);

Thank you for your detail reviewing and some nice code. I will update
this patch and post them again with others.

  Hiroshi DOYU
