From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/4][v3] OMAP:iommu- add TLB preservation support
Date: Wed, 21 Apr 2010 09:02:27 +0300 (EEST)
Message-ID: <20100421.090227.189716355.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF953@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55708 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab0DUGCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 02:02:50 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF953@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, felipe.contreras@gmail.com, tony@atomide.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 4/4][v3] OMAP:iommu- add TLB preservation support
Date: Wed, 21 Apr 2010 00:57:10 +0200

> From b76cbee7bb442f61dd2f29ed64ccf98efd871791 Mon Sep 17 00:00:00 2001
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Tue, 20 Apr 2010 12:11:16 -0500
> Subject: [PATCH 4/4] OMAP:iommu- add TLB preservation support
> 
> This patch adds TLB preservation support to IOMMU module
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/iommu2.c |    4 +++-
>  arch/arm/plat-omap/iommu.c   |   12 ++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index f01f985..5ce76e4 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -146,6 +146,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>  	printk("\n");
>  
>  	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> +	omap2_iommu_disable(obj);
>  	return stat;
>  }
>  
> @@ -211,7 +212,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
>  	char *p = buf;
>  
>  	/* FIXME: Need more detail analysis of cam/ram */
> -	p += sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
> +	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
> +					(cr->cam & MMU_CAM_P) ? 1 : 0);
>  
>  	return p - buf;
>  }
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 463d638..a1d4ccf 100644
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
> @@ -241,6 +238,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
>  			break;
>  	}
>  
> +	if (l.base == obj->nr_tlb_entries) {
> +		dev_dbg(obj->dev, "%s: preserve entries full\n", __func__);
> +		err = -EBUSY;

I am afraid that this doesn't work. There are two cases where TLB
entries are set/updated:

1) H/W TWL always updates TLB entries automatically, IOW, increments
   "vict" implicitly.
2) A client module adds preservation TLB entry with explictly calling
   "load_iotlb_entry()". IOW, increments both  "vict" and "base"
   intentionally.

Because of 1), "vict" gets full soon and this is normal, but even if
this "vict" is full, a preservation entry "base" should be able to be
set by a client module unless "base" itself rearches full. IOW, Even
if all TLB entries are valid, a new preservation TLB entry should be
set by replacing one of the existing normal entry.

In the case of "e" with perservation bit , "load_iotlb_entry()"
doesn't usually fail because it replaces the exisiting normal entry,
but it would fail only if all TLB entries are preserved.

> +		goto out;
> +	}
>  	if (i == obj->nr_tlb_entries) {
>  		dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
>  		err = -EBUSY;
> @@ -256,9 +258,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
>  	iotlb_load_cr(obj, cr);
>  	kfree(cr);
>  
> +	if (e->prsvd)
> +		l.base++;
>  	/* increment victim for next tlb load */
>  	if (++l.vict == obj->nr_tlb_entries)
> -		l.vict = 0;
> +		l.vict = l.base;
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
