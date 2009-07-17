From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] fix omap3 sram virtual addres overlap vmalloc space
 after increasing vmalloc size
Date: Fri, 17 Jul 2009 16:04:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907171603190.18924@utopia.booyaka.com>
References: <1247784477.25106.35.camel@debian-nb>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36268 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757905AbZGQWEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jul 2009 18:04:21 -0400
In-Reply-To: <1247784477.25106.35.camel@debian-nb>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janboe Ye <yuan-bo.ye@motorola.com>
Cc: linux-omap@vger.kernel.org, mans@mansr.com, khilman@deeprootsystems.com, tony@atomide.com, hong-mei.li@motorola.com

On Thu, 16 Jul 2009, Janboe Ye wrote:

> resend for mini coding style fixing
> 
> commit e85c205ac1427f2405021a36f083280ff0d0a35e increase vmalloc size.
> vmalloc space will overlap with OMAP3 sram virtual address.

Makes sense to me.  I'm not sure how we missed this in the original patch.

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul

> 
> Signed-off-by: Li Hong Mei <hong-mei.li@motorola.com>
> Signed-off-by: Janboe Ye <yuan-bo.ye@motorola.com>
> ---
>  arch/arm/plat-omap/sram.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a2e60e7..755ccaa 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -41,9 +41,9 @@
>  #define OMAP2_SRAM_VA          0xe3000000
>  #define OMAP2_SRAM_PUB_VA      (OMAP2_SRAM_VA + 0x800)
>  #define OMAP3_SRAM_PA           0x40200000
> -#define OMAP3_SRAM_VA           0xd7000000
> +#define OMAP3_SRAM_VA           0xe3000000
>  #define OMAP3_SRAM_PUB_PA       0x40208000
> -#define OMAP3_SRAM_PUB_VA       0xd7008000
> +#define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
> 
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  #define SRAM_BOOTLOADER_SZ     0x00
> 


- Paul
