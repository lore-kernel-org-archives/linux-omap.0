From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Fri, 14 Jan 2011 15:58:06 +0000
Message-ID: <20110114155806.GA22505@n2100.arm.linux.org.uk>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45523 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757488Ab1ANP6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 10:58:21 -0500
Content-Disposition: inline
In-Reply-To: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 04:21:10PM +0100, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> The new fncpy API is better suited for copying some
> code to SRAM at runtime. This patch changes the ad-hoc
> code to the more generic fncpy API.
> 
> Tested OK on OMAP3 in low power modes (RET/OFF)
> with !CONFIG_THUMB2_KERNEL
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/plat-omap/sram.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index e26e504..e2982b0 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -23,7 +23,7 @@
>  
>  #include <asm/tlb.h>
>  #include <asm/cacheflush.h>
> -
> +#include <asm/fncpy.h>
>  #include <asm/mach/map.h>
>  
>  #include <plat/sram.h>
> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long size)
>  
>  	omap_sram_ceil -= size;
>  	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
> -	memcpy((void *)omap_sram_ceil, start, size);
> -	flush_icache_range((unsigned long)omap_sram_ceil,
> -		(unsigned long)(omap_sram_ceil + size));
> +
> +	fncpy((void *)omap_sram_ceil, start, size);
>  
>  	return (void *)omap_sram_ceil;

That's actually wrong usage, as you won't get the T bit set if the original
function had it.

The right solution to this is to change omap_sram_push() to become just an
allocator, and then use fncpy() outside of that.

So:

extern int my_func_size;
extern void my_func(int blah);
void (*sram_my_func)(int);

	void *sram = omap_sram_push(my_func_size);
	if (sram)
		sram_my_func = fncpy(sram, my_func, my_func_size);

Two benefits: 1. you get the thumb mode bit propagated (which is the
point of fncpy), and 2. you get the security of type safety between
my_func and the sram function pointer.

If you cast things to a void pointer and ignore the return value of fncpy
then you lose the whole point of this API _and_ any form of type safety.
