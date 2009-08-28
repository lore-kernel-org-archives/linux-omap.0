From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] flush the function in sdram is not correct because sram
 is changed.
Date: Fri, 28 Aug 2009 02:33:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908280229100.15963@utopia.booyaka.com>
References: <af3ea28a0908272256k1743b528pdfb3dcdb88848544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40239 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZH1IdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 04:33:18 -0400
In-Reply-To: <af3ea28a0908272256k1743b528pdfb3dcdb88848544@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

Hello janboe,

On Fri, 28 Aug 2009, ye janboe wrote:

> >From f10090bf307066f1317d7152c6f9a6f395007d4a Mon Sep 17 00:00:00 2001
> From: janboe <janboe.ye@gmail.com>
> Date: Fri, 28 Aug 2009 13:50:57 +0800
> Subject: [PATCH] flush the function in sdram is not correct because
> sram is changed.
> 
> Signed-off-by: janboe <janboe.ye@gmail.com>

The technical part of the patch makes sense, but the patch format needs 
to be changed.  

Your subject line should start with something like "[PATCH] OMAP SRAM:", 
and you should add a short patch description that describes the bug and 
why the patch does what it does to fix it.

Also your post should not include the "From", "Date", and "Subject" lines 
inside the E-mail.  You might wish to consider using 'git send-email' or 
at least 'git format-patch' if possible.


- Paul

> ---
>  arch/arm/plat-omap/sram.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index f2b0fa6..253fcf7 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -270,7 +270,7 @@ void * omap_sram_push(void * start, unsigned long size)
>         omap_sram_ceil -= size;
>         omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
>         memcpy((void *)omap_sram_ceil, start, size);
> -       flush_icache_range((unsigned long)start, (unsigned long)(start + size));
> +       flush_icache_range((unsigned long)omap_sram_ceil, (unsigned
> long)(omap_sram_ceil + size));
> 
>         return (void *)omap_sram_ceil;
>  }
> -- 
> 1.6.3.3
> 


