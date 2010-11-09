From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] omap: dsp: remove shm from normal memory
Date: Mon, 8 Nov 2010 16:53:21 -0800
Message-ID: <20101109005320.GW9264@atomide.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <1289166209-32251-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60645 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab0KIAxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 19:53:30 -0500
Content-Disposition: inline
In-Reply-To: <1289166209-32251-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

* Felipe Contreras <felipe.contreras@gmail.com> [101107 13:34]:
> Also, don't be picky about the location, which incidentally fixes the
> build since MEMBLOCK_REAL_LIMIT is gone on 2.6.37.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

This is a valid fix for 2.6.37 -rc cycle now that the memblock code
is in and should get merged with other drivers/staging/tidspbridge
related fixes.

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/plat-omap/devices.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 6f42a18..fc81912 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -284,12 +284,14 @@ void __init omap_dsp_reserve_sdram_memblock(void)
>  	if (!size)
>  		return;
>  
> -	paddr = __memblock_alloc_base(size, SZ_1M, MEMBLOCK_REAL_LIMIT);
> +	paddr = memblock_alloc(size, SZ_1M);
>  	if (!paddr) {
>  		pr_err("%s: failed to reserve %x bytes\n",
>  				__func__, size);
>  		return;
>  	}
> +	memblock_free(paddr, size);
> +	memblock_remove(paddr, size);
>  
>  	omap_dsp_phys_mempool_base = paddr;
>  }
> -- 
> 1.7.3.2.3.gf8529
> 
