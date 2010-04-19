From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
Date: Mon, 19 Apr 2010 11:32:21 +0300 (EEST)
Message-ID: <20100419.113221.226801631.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B216AFA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46028 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab0DSIcg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 04:32:36 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B216AFA@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
Date: Fri, 16 Apr 2010 18:18:59 +0200

> From bcdd232666a163d2661d704f9c21d055bacfd178 Mon Sep 17 00:00:00 2001
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Mon, 8 Mar 2010 18:00:36 -0600
> Subject: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
> 
> This patch adds TLB preservation support to IOMMU module
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/iommu2.c |    7 +++++--
>  arch/arm/plat-omap/iommu.c   |   16 +++++++++-------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index 6f4b7cc..2735bd7 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -146,6 +146,8 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>  	printk("\n");
>  
>  	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> +	/* Disable MMU to stop continuous generation of MMU faults */
> +	omap2_iommu_disable(obj);

The above comment may look a bit redundant.

>  	return stat;
>  }
>  
> @@ -183,7 +185,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
>  	if (!cr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
> +	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
>  	cr->ram = e->pa | e->endian | e->elsz | e->mixed;

Good finding. This can be a separate patch.

>  	return cr;
> @@ -211,7 +213,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
>  	char *p = buf;
>  
>  	/* FIXME: Need more detail analysis of cam/ram */
> -	p += sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
> +	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
> +					(cr->cam & MMU_CAM_P) ? 1 : 0);

This is ok for now.

As described in FIXME comment, this cam/ram whole anaylysis can be
improved/implemented in order to display all items/bits in the end.

>  	return p - buf;
>  }
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 5186728..64d676e 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -171,15 +171,12 @@ static void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
>  	l->base = MMU_LOCK_BASE(val);
>  	l->vict = MMU_LOCK_VICT(val);
>  
> -	BUG_ON(l->base != 0); /* Currently no preservation is used */
>  }
>  
>  static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
>  {
>  	u32 val;
>  
> -	BUG_ON(l->base != 0); /* Currently no preservation is used */
> -
>  	val = (l->base << MMU_LOCK_BASE_SHIFT);
>  	val |= (l->vict << MMU_LOCK_VICT_SHIFT);
>  
> @@ -241,7 +238,7 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
>  			break;
>  	}
>  
> -	if (i == obj->nr_tlb_entries) {
> +	if (i == obj->nr_tlb_entries || (l.base == obj->nr_tlb_entries)) {

The above should be dealt separately, since no vacant entry is normal,
but no room to be replaced because of preservation should be warned,
at least.

>  		dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
>  		err = -EBUSY;
>  		goto out;
> @@ -252,13 +249,18 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
>  		clk_disable(obj->clk);
>  		return PTR_ERR(cr);
>  	}
> -
>  	iotlb_load_cr(obj, cr);
>  	kfree(cr);
>  
> +	/* Increment base number if preservation is set */
> +	if (e->prsvd)
> +		l.base++;

redundant comment? It tells what the code does.

>  	/* increment victim for next tlb load */

Although the above is my comment, this looks redundant now too.

> -	if (++l.vict == obj->nr_tlb_entries)
> -		l.vict = 0;
> +	if (++l.vict == obj->nr_tlb_entries) {
> +		l.vict = l.base;
> +		goto out;
> +	}

Does the above work?

> +
>  	iotlb_lock_set(obj, &l);
>  out:
>  	clk_disable(obj->clk);
> -- 
> 1.7.0
> 
> 
> Thank you,
> Best regards,
> Hari
> 
