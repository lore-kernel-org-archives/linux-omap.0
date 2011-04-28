From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type
	'long unsigned int'
Date: Thu, 28 Apr 2011 15:09:53 +0100
Message-ID: <20110428140953.GD19709@n2100.arm.linux.org.uk>
References: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com> <20110404091223.GA19854@n2100.arm.linux.org.uk> <4D9993AD.3080401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44504 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759622Ab1D1OKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 10:10:06 -0400
Content-Disposition: inline
In-Reply-To: <4D9993AD.3080401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 04, 2011 at 03:17:25PM +0530, Santosh Shilimkar wrote:
> From 4d8d4e5c99c1477a8cb04b525ff5a2d93bbdacfd Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Mon, 4 Apr 2011 14:20:08 +0530
> Subject: [PATCH] OMAP: SRAM: Fix warning: format '%08lx' expects type  
> 'long unsigned int'
>
> Fix below build warning.
>
>  CC	arch/arm/plat-omap/sram.o
> 	arch/arm/plat-omap/sram.c: In function 'omap_map_sram':
> 	arch/arm/plat-omap/sram.c:224: warning: format '%08lx' expects
> 	type 'long unsigned int', but argument 2 has type 'unsigned int'
>
> While at this, convert SRAM printk(* "") to pr_*("").
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/sram.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a3f50b3..6af3d0b 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
>  		else if (cpu_is_omap1611())
>  			omap_sram_size = SZ_256K;
>  		else {
> -			printk(KERN_ERR "Could not detect SRAM size\n");
> +			pr_err("Could not detect SRAM size\n");
>  			omap_sram_size = 0x4000;
>  		}
>  	}
> @@ -221,10 +221,10 @@ static void __init omap_map_sram(void)
>  	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
>  	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
>
> -	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
> -	__pfn_to_phys(omap_sram_io_desc[0].pfn),
> -	omap_sram_io_desc[0].virtual,
> -	       omap_sram_io_desc[0].length);
> +	pr_info("SRAM: Mapped pa 0x%08llx to va 0x%08lx size: 0x%lx\n",
> +		(long long) __pfn_to_phys(omap_sram_io_desc[0].pfn),
> +		omap_sram_io_desc[0].virtual,
> +		omap_sram_io_desc[0].length);
>
>  	/*
>  	 * Normally devicemaps_init() would flush caches and tlb after
> @@ -252,7 +252,7 @@ static void __init omap_map_sram(void)
>  void *omap_sram_push_address(unsigned long size)
>  {
>  	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
> -		printk(KERN_ERR "Not enough space in SRAM\n");
> +		pr_err("Not enough space in SRAM\n");
>  		return NULL;
>  	}
>

This looks much better.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

It looks like Tony hasn't taken it...  Tony, are you going to handle
this patch?
