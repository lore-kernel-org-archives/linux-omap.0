From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap:iommu-added cache flushing operation for L2 cache
Date: Wed, 2 Mar 2011 18:18:05 +0530
Message-ID: <1dc497a090414bf80ff588791d6db5cc@mail.gmail.com>
References: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>, hiroshi.doyu@nokia.com
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ramesh Gupta <grgupta@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Fernando Guzman Lugo
> Sent: Wednesday, March 02, 2011 1:17 AM
> To: hiroshi.doyu@nokia.com
> Cc: tony@atomide.com; linux@arm.linux.org.uk; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Ramesh Gupta; Hari Kanigeri
> Subject: [PATCH] omap:iommu-added cache flushing operation for L2
> cache
>
> From: Ramesh Gupta <grgupta@ti.com>
>
> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/iommu.c |   22 ++++++++--------------
>  1 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index e3eb038..aeb2c33 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -471,22 +471,15 @@ EXPORT_SYMBOL_GPL(foreach_iommu_device);
>   */
>  static void flush_iopgd_range(u32 *first, u32 *last)
>  {
> -	/* FIXME: L2 cache should be taken care of if it exists */
> -	do {
> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
> -		    : : "r" (first));
> -		first += L1_CACHE_BYTES / sizeof(*first);
> -	} while (first <= last);
> +	dmac_flush_range(first, last);

There is note just above this API.
/*
 * These are private to the dma-mapping API.  Do not use directly.
 * Their sole purpose is to ensure that data held in the cache
 * is visible to DMA, or data written by DMA to system memory is
 * visible to the CPU.
 */
#define dmac_map_area                   cpu_cache.dma_map_area
#define dmac_unmap_area         cpu_cache.dma_unmap_area
#define dmac_flush_range                cpu_cache.dma_flush_range

> +	outer_flush_range(virt_to_phys(first), virt_to_phys(last));
>  }
>
