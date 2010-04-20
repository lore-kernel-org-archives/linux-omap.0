From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
Date: Tue, 20 Apr 2010 15:58:10 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B344556@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B216AFA@dlee03.ent.ti.com>
 <20100419.113221.226801631.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57914 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276Ab0DTU6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 16:58:18 -0400
In-Reply-To: <20100419.113221.226801631.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Hiroshi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Monday, April 19, 2010 3:32 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Shilimkar, Santosh
> Subject: Re: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
> 
> Hi Hari,
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
> Date: Fri, 16 Apr 2010 18:18:59 +0200
> 
> > From bcdd232666a163d2661d704f9c21d055bacfd178 Mon Sep 17 00:00:00 2001
> > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > Date: Mon, 8 Mar 2010 18:00:36 -0600
> > Subject: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
> >
> > This patch adds TLB preservation support to IOMMU module
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/mach-omap2/iommu2.c |    7 +++++--
> >  arch/arm/plat-omap/iommu.c   |   16 +++++++++-------
> >  2 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> > index 6f4b7cc..2735bd7 100644
> > --- a/arch/arm/mach-omap2/iommu2.c
> > +++ b/arch/arm/mach-omap2/iommu2.c
> > @@ -146,6 +146,8 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj,
> u32 *ra)
> >  	printk("\n");
> >
> >  	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> > +	/* Disable MMU to stop continuous generation of MMU faults */
> > +	omap2_iommu_disable(obj);
> 
> The above comment may look a bit redundant.

-- I will fix this.

> 
> >  	return stat;
> >  }
> >
> > @@ -183,7 +185,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu
> *obj, struct iotlb_entry *e)
> >  	if (!cr)
> >  		return ERR_PTR(-ENOMEM);
> >
> > -	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
> > +	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e-
> >valid;
> >  	cr->ram = e->pa | e->endian | e->elsz | e->mixed;
> 
> Good finding. This can be a separate patch.

-- I will send this as a separate patch.
> 
> >  	return cr;
> > @@ -211,7 +213,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj,
> struct cr_regs *cr, char *buf)
> >  	char *p = buf;
> >
> >  	/* FIXME: Need more detail analysis of cam/ram */
> > -	p += sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
> > +	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
> > +					(cr->cam & MMU_CAM_P) ? 1 : 0);
> 
> This is ok for now.
> 
> As described in FIXME comment, this cam/ram whole anaylysis can be
> improved/implemented in order to display all items/bits in the end.
> 
> >  	return p - buf;
> >  }
> > diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> > index 5186728..64d676e 100644
> > --- a/arch/arm/plat-omap/iommu.c
> > +++ b/arch/arm/plat-omap/iommu.c
> > @@ -171,15 +171,12 @@ static void iotlb_lock_get(struct iommu *obj,
> struct iotlb_lock *l)
> >  	l->base = MMU_LOCK_BASE(val);
> >  	l->vict = MMU_LOCK_VICT(val);
> >
> > -	BUG_ON(l->base != 0); /* Currently no preservation is used */
> >  }
> >
> >  static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
> >  {
> >  	u32 val;
> >
> > -	BUG_ON(l->base != 0); /* Currently no preservation is used */
> > -
> >  	val = (l->base << MMU_LOCK_BASE_SHIFT);
> >  	val |= (l->vict << MMU_LOCK_VICT_SHIFT);
> >
> > @@ -241,7 +238,7 @@ int load_iotlb_entry(struct iommu *obj, struct
> iotlb_entry *e)
> >  			break;
> >  	}
> >
> > -	if (i == obj->nr_tlb_entries) {
> > +	if (i == obj->nr_tlb_entries || (l.base == obj->nr_tlb_entries)) {
> 
> The above should be dealt separately, since no vacant entry is normal,
> but no room to be replaced because of preservation should be warned,
> at least.

-- I will fix this.

> 
> >  		dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
> >  		err = -EBUSY;
> >  		goto out;
> > @@ -252,13 +249,18 @@ int load_iotlb_entry(struct iommu *obj, struct
> iotlb_entry *e)
> >  		clk_disable(obj->clk);
> >  		return PTR_ERR(cr);
> >  	}
> > -
> >  	iotlb_load_cr(obj, cr);
> >  	kfree(cr);
> >
> > +	/* Increment base number if preservation is set */
> > +	if (e->prsvd)
> > +		l.base++;
> 
> redundant comment? It tells what the code does.

-- I will fix this.

> 
> >  	/* increment victim for next tlb load */
> 
> Although the above is my comment, this looks redundant now too.
> 
> > -	if (++l.vict == obj->nr_tlb_entries)
> > -		l.vict = 0;
> > +	if (++l.vict == obj->nr_tlb_entries) {
> > +		l.vict = l.base;
> > +		goto out;
> > +	}
> 
> Does the above work?

-- Good catch. This should just wrap back to l.base and there is no need of goto out statement.

> 
> > +
> >  	iotlb_lock_set(obj, &l);
> >  out:
> >  	clk_disable(obj->clk);
> > --
> > 1.7.0
> >
> >
> > Thank you,
> > Best regards,
> > Hari
> >
