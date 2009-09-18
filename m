From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Fri, 18 Sep 2009 12:54:53 +0300 (EEST)
Message-ID: <20090918.125453.179950926.Hiroshi.DOYU@nokia.com>
References: <1253264186-1013-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61226 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZIRJzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 05:55:06 -0400
In-Reply-To: <1253264186-1013-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: premi@ti.com
Cc: linux-omap@vger.kernel.org

Hi Premi,

From: ext Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Fri, 18 Sep 2009 10:56:26 +0200

> This patch fixes these compiler warnings:
> 
> arch/arm/plat-omap/iovmm.c: In function 'vmap_sg':
> arch/arm/plat-omap/iovmm.c:202: warning: passing argument 1 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> arch/arm/plat-omap/iovmm.c:202: warning: passing argument 2 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> arch/arm/plat-omap/iovmm.c: In function 'sgtable_fill_vmalloc':
> arch/arm/plat-omap/iovmm.c:393: warning: passing argument 1 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> arch/arm/plat-omap/iovmm.c:393: warning: passing argument 2 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/plat-omap/iovmm.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 004fd83..481bf77 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -199,7 +199,8 @@ static void *vmap_sg(const struct sg_table *sgt)
>  		va += bytes;
>  	}
>  
> -	flush_cache_vmap(new->addr, new->addr + total);
> +	flush_cache_vmap((unsigned long) new->addr,
> +				(unsigned long) (new->addr + total));

I think that the space after casting isn't necessary.

>  	return new->addr;
>  
>  err_out:
> @@ -390,7 +391,7 @@ static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
>  	}
>  
>  	va_end = _va + PAGE_SIZE * i;
> -	flush_cache_vmap(_va, va_end);
> +	flush_cache_vmap((unsigned long) _va, (unsigned long) va_end);
>  }
>  
>  static inline void sgtable_drain_vmalloc(struct sg_table *sgt)

If no need for pointer, what about below?

	Modified arch/arm/plat-omap/iovmm.c
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 6fc52fc..3ea0cd0 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -368,12 +368,12 @@ out:
 }
 EXPORT_SYMBOL_GPL(da_to_va);
 
-static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
+static void sgtable_fill_vmalloc(struct sg_table *sgt, u32 _va)
 {
 	unsigned int i;
 	struct scatterlist *sg;
-	void *va = _va;
-	void *va_end;
+	u32 va = _va;
+	u32 va_end;
 
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		struct page *pg;
@@ -693,7 +693,7 @@ u32 iommu_vmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
 		da = PTR_ERR(sgt);
 		goto err_sgt_alloc;
 	}
-	sgtable_fill_vmalloc(sgt, va);
+	sgtable_fill_vmalloc(sgt, (u32)va);
 
 	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_DISCONT;
