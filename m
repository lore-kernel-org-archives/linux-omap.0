From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Date: Tue, 26 Feb 2019 23:35:44 +0000
Message-ID: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de, m.szyprowski@samsung.com, tony@atomide.com
Cc: vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, sre@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> 
> The original change breaks omap dss:
>      omapdss_dispc 58001000.dispc:
>          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Let's revert it first and then find a safer solution instead.

Ah, I think I see the problem - once arch/arm's __dma_alloc() has 
decided to use CMA (because dev_get_cma_area(dev) returns the global 
area), it then won't fall back to trying a regular page allocation if 
dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm 
trying to allocate a single-page buffer in blockable context with a 
CMA-enabled config is just going to fail. Similarly, it looks like none 
of the DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this 
change either (amd_iommu appears technically affected, but is already 
using dma_alloc_from_contiguous() backwards compared to everyone else, hmm).

I guess the question is whether to add alloc_page()/free_page() 
fallbacks to those call sites, or stuff them directly into the CMA 
helpers here.

Robin.

> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
> 	
> Would you please test and verify? Thanks!
> 
>   kernel/dma/contiguous.c | 22 +++-------------------
>   1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 09074bd04793..b2a87905846d 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -186,32 +186,16 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>    *
>    * This function allocates memory buffer for specified device. It uses
>    * device specific contiguous memory area if available or the default
> - * global one.
> - *
> - * However, it skips one-page size of allocations from the global area.
> - * As the addresses within one page are always contiguous, so there is
> - * no need to waste CMA pages for that kind; it also helps reduce the
> - * fragmentations in the CMA area. So a caller should be the rebounder
> - * in such case to allocate a normal page upon NULL return value.
> - *
> - * Requires architecture specific dev_get_cma_area() helper function.
> + * global one. Requires architecture specific dev_get_cma_area() helper
> + * function.
>    */
>   struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>   				       unsigned int align, bool no_warn)
>   {
> -	struct cma *cma;
> -
>   	if (align > CONFIG_CMA_ALIGNMENT)
>   		align = CONFIG_CMA_ALIGNMENT;
>   
> -	if (dev && dev->cma_area)
> -		cma = dev->cma_area;
> -	else if (count > 1)
> -		cma = dma_contiguous_default_area;
> -	else
> -		return NULL;
> -
> -	return cma_alloc(cma, count, align, no_warn);
> +	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
>   }
>   
>   /**
> 
