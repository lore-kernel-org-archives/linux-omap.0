From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Wed, 15 Sep 2010 15:38:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009151537000.458@utopia.booyaka.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab0IOVis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 17:38:48 -0400
In-Reply-To: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Jon,

one other brief note:

On Wed, 21 Jul 2010, Jon Hunter wrote:

> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index de99ba2..e87e730 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -129,8 +129,11 @@ ENTRY(omap3_sram_configure_core_dpll)
>  	ldr	r4, [sp, #80]
>  	str     r4, omap_sdrc_mr_1_val
>  skip_cs1_params:
> +	mrc p15, 0, r8, c1, c0, 0	@ read aux ctrl register
> +	bic r10, r8, #0x800		@ clear Z-bit, disable branch prediction
> +	mcr p15, 0, r10, c1, c0, 0	@ write aux ctrl register

Please be careful with the whitespace between the opcode and the 
arguments - I will fix this in the current patch but it seems best to keep 
this consistent.


- Paul
