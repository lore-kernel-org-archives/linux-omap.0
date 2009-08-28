From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP SRAM: flush the right address after memcpy in
 omap_sram_push
Date: Fri, 28 Aug 2009 04:43:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908280443110.15963@utopia.booyaka.com>
References: <af3ea28a0908280226p69175f97m88b8eac5e0bd2502@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59191 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbZH1Kns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 06:43:48 -0400
In-Reply-To: <af3ea28a0908280226p69175f97m88b8eac5e0bd2502@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

On Fri, 28 Aug 2009, ye janboe wrote:

> the original flush operation is to flush the function address which is
> copied from.
> But we do not change the function code and it is not necessary to flush it.
> 
> Signed-off-by: janboe <janboe.ye@gmail.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

thanks Janboe.

Tony, you want to take this one, or do you want me to?

- Paul


> ---
>  arch/arm/plat-omap/sram.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index f2b0fa6..f549d8a 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -270,7 +270,8 @@ void * omap_sram_push(void * start, unsigned long size)
>         omap_sram_ceil -= size;
>         omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
>         memcpy((void *)omap_sram_ceil, start, size);
> -       flush_icache_range((unsigned long)start, (unsigned long)(start + size));
> +       flush_icache_range((unsigned long)omap_sram_ceil,
> +               (unsigned long)(omap_sram_ceil + size));
> 
>         return (void *)omap_sram_ceil;
>  }
> 


