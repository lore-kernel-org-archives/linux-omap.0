From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
 interrupt
Date: Tue, 18 May 2010 12:03:55 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BC6CD62@dlee03.ent.ti.com>
References: <1274137950-18759-1-git-send-email-h-kanigeri2@ti.com>
	<1274137950-18759-3-git-send-email-h-kanigeri2@ti.com>
 <20100518.091130.260105572.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34897 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab0ERREF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 13:04:05 -0400
In-Reply-To: <20100518.091130.260105572.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi,


> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Tuesday, May 18, 2010 1:12 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Gupta, Ramesh
> Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
> interrupt
> 
> Hi Hari,
> 
> From: ext Hari Kanigeri <h-kanigeri2@ti.com>
> Subject: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
> interrupt
> Date: Tue, 18 May 2010 01:12:30 +0200
> 
> > In order to enable TLB miss interrupt, the TWL should be
> > disabled. This patch provides the functionality to get the
> > MMU fault interrupt for a TLB miss in the cases where the
> > users are working with the locked TLB entries and with TWL
> > disabled.
> 
> I want to keep leave the functionality to allow the locked TLB and
> TWL enabled at the same time too. Is it still feasible with this?
> 

-- Absolutely. You can still work with locked TLB entries with TWL enabled.
My patch just provides the functionality where the users want to work only with locked TLB entries and with TWL disabled, and this is a valid use case. 

So basically, the user has to call this new function after calling iommu_get function if they want to have TWL disabled.

Reference: Check the MMU_IRQENABLE register definition in TRM for enabling TLB miss interrupt.

Please let me know if you need additional clarification.


> > New interface is added to disable twl and enable TLB miss
> > interrupt.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > Signed-off-by: Ramesh Gupta <grgupta@ti.com>
> > ---
> >  arch/arm/mach-omap2/iommu2.c            |   13 +++++++++++++
> >  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
> >  arch/arm/plat-omap/iommu.c              |   12 ++++++++++++
> >  3 files changed, 27 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> > index fcf4f4a..2e78cea 100644
> > --- a/arch/arm/mach-omap2/iommu2.c
> > +++ b/arch/arm/mach-omap2/iommu2.c
> > @@ -124,6 +124,18 @@ static void omap2_iommu_disable(struct iommu *obj)
> >  	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
> >  }
> >
> > +static void omap2_iommu_disable_twl(struct iommu *obj)
> > +{
> > +       u32 l = iommu_read_reg(obj, MMU_CNTL);
> > +
> > +       l &= ~MMU_CNTL_MASK;
> > +       l |= (MMU_CNTL_MMU_EN);
> > +       iommu_write_reg(obj, l, MMU_CNTL);
> > +
> > +       /* Enable TLB miss interrupt */
> > +       iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
> > +}
> > +
> >  static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> >  {
> >  	int i;
> > @@ -306,6 +318,7 @@ static const struct iommu_functions omap2_iommu_ops
> = {
> >
> >  	.enable		= omap2_iommu_enable,
> >  	.disable	= omap2_iommu_disable,
> > +	.disable_twl    = omap2_iommu_disable_twl,
> >  	.fault_isr	= omap2_iommu_fault_isr,
> >
> >  	.tlb_read_cr	= omap2_tlb_read_cr,
> > diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-
> omap/include/plat/iommu.h
> > index 0752af9..52a3852 100644
> > --- a/arch/arm/plat-omap/include/plat/iommu.h
> > +++ b/arch/arm/plat-omap/include/plat/iommu.h
> > @@ -80,6 +80,7 @@ struct iommu_functions {
> >
> >  	int (*enable)(struct iommu *obj);
> >  	void (*disable)(struct iommu *obj);
> > +	void (*disable_twl)(struct iommu *obj);
> >  	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
> >
> >  	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
> > @@ -143,6 +144,7 @@ extern void iotlb_cr_to_e(struct cr_regs *cr, struct
> iotlb_entry *e);
> >  extern u32 iotlb_cr_to_virt(struct cr_regs *cr);
> >
> >  extern int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e);
> > +extern void iommu_disable_twl(struct iommu *obj);
> >  extern void flush_iotlb_page(struct iommu *obj, u32 da);
> >  extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
> >  extern void flush_iotlb_all(struct iommu *obj);
> > diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> > index b2b3937..d64a4d8 100644
> > --- a/arch/arm/plat-omap/iommu.c
> > +++ b/arch/arm/plat-omap/iommu.c
> > @@ -370,6 +370,18 @@ void flush_iotlb_all(struct iommu *obj)
> >  }
> >  EXPORT_SYMBOL_GPL(flush_iotlb_all);
> >
> > +/**
> > + * Call this function if working with locked TLB entries and
> > + * TWL disabled
> > + */
> 
> nitpick: It may be better to follow this for global func.
> 
> From linux/Documentation/kernel-doc-nano-HOWTO.txt:
> ...
> Example kernel-doc function comment:
> 
> /**
>  * foobar() - short function description of foobar
>  * @arg1:	Describe the first argument to foobar.
>  * @arg2:	Describe the second argument to foobar.
>  *		One can provide multiple line descriptions
>  *		for arguments.
>  *
>  * A longer description, with more discussion of the function foobar()
>  * that might be useful to those using or modifying it.  Begins with
>  * empty comment line, and may include additional embedded empty
>  * comment lines.
>  *
>  * The longer description can have multiple paragraphs.
>  */

-- Will update this in next patch revision.

> 
> 
> > +extern void iommu_disable_twl(struct iommu *obj)
> 
> extern?

Oops ! Copy paste error from header file.

> 
> > +{
> > +	clk_enable(obj->clk);
> > +	arch_iommu->disable_twl(obj);
> > +	clk_disable(obj->clk);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_disable_twl);
> > +
> >  #if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
> >
> >  ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
> > --
> > 1.7.0
> >
