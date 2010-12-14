From: Tony Lindgren <tony@atomide.com>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Tue, 14 Dec 2010 10:55:50 -0800
Message-ID: <20101214185550.GM3054@atomide.com>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
 <20101202215837.GW17222@atomide.com>
 <20101202221612.GJ10461@n2100.arm.linux.org.uk>
 <20101202223208.GA17222@atomide.com>
 <20101203030954.GD3367@linux-sh.org>
 <20101203084102.GA30957@n2100.arm.linux.org.uk>
 <AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
 <20101203130724.GB30957@n2100.arm.linux.org.uk>
 <1292329431.6893.113.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56658 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120Ab0LNS4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 13:56:24 -0500
Content-Disposition: inline
In-Reply-To: <1292329431.6893.113.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [101214 04:23]:
> >
> > So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
> > definitely not PAGE_SIZE.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/vram.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> index 2fd7e52..9441e2e 100644
> --- a/drivers/video/omap2/vram.c
> +++ b/drivers/video/omap2/vram.c
> @@ -551,7 +551,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
>  	if (!size)
>  		return;
>  
> -	size = PAGE_ALIGN(size);
> +	size = ALIGN(size, SZ_2M);
>  
>  	if (paddr) {
>  		if (paddr & ~PAGE_MASK) {
> @@ -576,7 +576,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
>  			return;
>  		}
>  	} else {
> -		paddr = memblock_alloc(size, PAGE_SIZE);
> +		paddr = memblock_alloc(size, SZ_2M);
>  	}
>  
>  	memblock_free(paddr, size);
> -- 
> 1.7.1
> 
> 
> 
