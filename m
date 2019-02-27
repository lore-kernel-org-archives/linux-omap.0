From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Date: Tue, 26 Feb 2019 16:48:25 -0800
Message-ID: <20190227004825.GA29112@Asurada-Nvidia.nvidia.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
 <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, tony@atomide.com, vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, sre@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 26, 2019 at 11:35:44PM +0000, Robin Murphy wrote:
> On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> > This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> > 
> > The original change breaks omap dss:
> >      omapdss_dispc 58001000.dispc:
> >          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> > 
> > Let's revert it first and then find a safer solution instead.
> 
> Ah, I think I see the problem - once arch/arm's __dma_alloc() has decided to
> use CMA (because dev_get_cma_area(dev) returns the global area), it then
> won't fall back to trying a regular page allocation if
> dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm trying
> to allocate a single-page buffer in blockable context with a CMA-enabled
> config is just going to fail. Similarly, it looks like none of the
> DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this change either
> (amd_iommu appears technically affected, but is already using
> dma_alloc_from_contiguous() backwards compared to everyone else, hmm).

Yea, I searched the tree and got the same results.

> I guess the question is whether to add alloc_page()/free_page() fallbacks to
> those call sites, or stuff them directly into the CMA helpers here.

Probably would be safer/easier to do the later one I feel.
