From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Date: Wed, 27 Feb 2019 09:46:08 +0100
Message-ID: <CAJKOXPf_+dME_P9jy5=_LrjYEpgti4+CN0thkSXSvxwSGVH=Bw@mail.gmail.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: hch@lst.de, Marek Szyprowski <m.szyprowski@samsung.com>, robin.murphy@arm.com, tony@atomide.com, vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, sre@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Tue, 26 Feb 2019 at 21:25, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
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
>
>  kernel/dma/contiguous.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)

This fixes broken (since yesterday) linux-next on Exynos boards
(ARMv7), errors like:
dma-pl330: probe of 121a0000.pdma failed with error -12
exynos-ehci 12110000.usb: can't setup: -12
exynos-ehci 12110000.usb: USB bus 1 deregistered
exynos-ehci 12110000.usb: Failed to add USB HCD

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
