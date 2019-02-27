From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Date: Wed, 27 Feb 2019 14:04:25 +0000
Message-ID: <a3ebd508-04a3-6ad2-5cd4-332282f21a8a@nvidia.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, tony@atomide.com
Cc: vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, sre@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-tegra <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On 26/02/2019 20:23, Nicolin Chen wrote:
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> 
> The original change breaks omap dss:
>     omapdss_dispc 58001000.dispc:
>         dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Let's revert it first and then find a safer solution instead.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
> 	
> Would you please test and verify? Thanks!

This also fixes various memory allocation failures we have seen on
32-bit Tegra as well.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
