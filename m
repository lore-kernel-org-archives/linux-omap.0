From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to <
 83Mhz
Date: Thu, 9 Jul 2009 14:43:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907091440480.8616@utopia.booyaka.com>
References: <1247134702-12704-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55896 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZGIUnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 16:43:39 -0400
In-Reply-To: <1247134702-12704-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: E12499@motorola.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

Hi Rajendra,

On Thu, 9 Jul 2009, Rajendra Nayak wrote:

> This patch fixes a bug in the CORE dpll scaling sequence
> which was errouneously clearing some bits in the
> SDRC DLLA CTRL register and hence causing a freeze.
> The issue was observed only on platforms which scale
> CORE dpll to < 83Mhz and hence program the DLL in fixed 
> delay mode.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, looks good, I'll queue this up for a fixes series to rmk.

One question: I got an E-mail on this earlier today from Limei Wang about 
this same issue.  Looks like we should credit Limei also in this patch 
with finding the bug.  Is this acceptable to you?

- Paul

> ---
>  arch/arm/mach-omap2/sram34xx.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index 481f912..9be09a7 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -113,7 +113,7 @@ return_to_sdram:
>  unlock_dll:
>  	ldr	r11, omap3_sdrc_dlla_ctrl
>  	ldr	r12, [r11]
> -	and	r12, r12, #FIXEDDELAY_MASK
> +	bic	r12, r12, #FIXEDDELAY_MASK
>  	orr	r12, r12, #FIXEDDELAY_DEFAULT
>  	orr	r12, r12, #DLLIDLE_MASK
>  	str	r12, [r11]		@ (no OCP barrier needed)
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


