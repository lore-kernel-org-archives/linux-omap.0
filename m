From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: dsp: remove shm from normal memory
Date: Fri, 5 Nov 2010 09:34:17 -0700
Message-ID: <20101105163417.GI9264@atomide.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
 <1287473844-6228-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55267 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab0KEQek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:34:40 -0400
Content-Disposition: inline
In-Reply-To: <1287473844-6228-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

* Felipe Contreras <felipe.contreras@gmail.com> [101019 00:28]:
> Also, don't be picky about the location.

As this code is in CONFIG_TIDSPBRIDGE block and AFAIK that is
not working, this should probably wait for the next merge window?

Regards,

Tony

 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/plat-omap/devices.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 4c8f9b9..da10433 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -285,12 +285,14 @@ void __init omap_dsp_reserve_sdram_memblock(void)
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
> 1.7.3.1.2.g7fe2b
> 
