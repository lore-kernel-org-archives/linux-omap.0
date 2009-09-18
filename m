From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Fri, 18 Sep 2009 15:53:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9914F9@dbde02.ent.ti.com>
References: <1253264186-1013-1-git-send-email-premi@ti.com>
 <20090918.125453.179950926.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51366 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbZIRKX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 06:23:29 -0400
In-Reply-To: <20090918.125453.179950926.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Friday, September 18, 2009 3:25 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: iovmm: fix compiler warning
> 
> Hi Premi,
> 
> From: ext Sanjeev Premi <premi@ti.com>
> Subject: [PATCH] OMAP3: iovmm: fix compiler warning
> Date: Fri, 18 Sep 2009 10:56:26 +0200
> 
> > This patch fixes these compiler warnings:
> > 
> > arch/arm/plat-omap/iovmm.c: In function 'vmap_sg':
> > arch/arm/plat-omap/iovmm.c:202: warning: passing argument 1 of
> >  'flush_cache_vmap' makes integer from pointer without a cast
> > arch/arm/plat-omap/iovmm.c:202: warning: passing argument 2 of
> >  'flush_cache_vmap' makes integer from pointer without a cast
> > arch/arm/plat-omap/iovmm.c: In function 'sgtable_fill_vmalloc':
> > arch/arm/plat-omap/iovmm.c:393: warning: passing argument 1 of
> >  'flush_cache_vmap' makes integer from pointer without a cast
> > arch/arm/plat-omap/iovmm.c:393: warning: passing argument 2 of
> >  'flush_cache_vmap' makes integer from pointer without a cast
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/plat-omap/iovmm.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> > index 004fd83..481bf77 100644
> > --- a/arch/arm/plat-omap/iovmm.c
> > +++ b/arch/arm/plat-omap/iovmm.c
> > @@ -199,7 +199,8 @@ static void *vmap_sg(const struct sg_table *sgt)
> >  		va += bytes;
> >  	}
> >  
> > -	flush_cache_vmap(new->addr, new->addr + total);
> > +	flush_cache_vmap((unsigned long) new->addr,
> > +				(unsigned long) (new->addr + total));
> 
> I think that the space after casting isn't necessary.
> 
> >  	return new->addr;
> >  
> >  err_out:
> > @@ -390,7 +391,7 @@ static void sgtable_fill_vmalloc(struct 
> sg_table *sgt, void *_va)
> >  	}
> >  
> >  	va_end = _va + PAGE_SIZE * i;
> > -	flush_cache_vmap(_va, va_end);
> > +	flush_cache_vmap((unsigned long) _va, (unsigned long) va_end);
> >  }
> >  
> >  static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
> 
> If no need for pointer, what about below?

I did not check for the usage of sgtable_drain_vmalloc().
Yes. If the void* isn't MUST then, change below is fine.

~sanjeev
> 
> 	Modified arch/arm/plat-omap/iovmm.c
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 6fc52fc..3ea0cd0 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -368,12 +368,12 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(da_to_va);
>  
> -static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
> +static void sgtable_fill_vmalloc(struct sg_table *sgt, u32 _va)
>  {
>  	unsigned int i;
>  	struct scatterlist *sg;
> -	void *va = _va;
> -	void *va_end;
> +	u32 va = _va;
> +	u32 va_end;
>  
>  	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
>  		struct page *pg;
> @@ -693,7 +693,7 @@ u32 iommu_vmalloc(struct iommu *obj, u32 
> da, size_t bytes, u32 flags)
>  		da = PTR_ERR(sgt);
>  		goto err_sgt_alloc;
>  	}
> -	sgtable_fill_vmalloc(sgt, va);
> +	sgtable_fill_vmalloc(sgt, (u32)va);
>  
>  	flags &= IOVMF_HW_MASK;
>  	flags |= IOVMF_DISCONT;
> 
> 