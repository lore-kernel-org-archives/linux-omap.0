From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: Move the clk stabilization delay to the right
 place
Date: Tue, 28 Jul 2009 11:18:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907281117120.13295@utopia.booyaka.com>
References: <1246015755-9267-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50211 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbZG1RSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jul 2009 13:18:32 -0400
In-Reply-To: <1246015755-9267-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 26 Jun 2009, Rajendra Nayak wrote:

> The clock stabilization delay post a M2 divider change is needed
> even before a SDRC interface clock re-enable and not only before
> jumping back to SDRAM.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

For the archives: this patch has been accepted and sent upstream for 
2.6.31-rc fixes.

- Paul

> ---
>  arch/arm/mach-omap2/sram34xx.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index f41f8d9..481f912 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -97,6 +97,8 @@ ENTRY(omap3_sram_configure_core_dpll)
>  	blne	lock_dll
>  	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
>  	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
> +	mov	r12, r5
> +	bl	wait_clk_stable		@ wait for SDRC to stabilize
>  	bl	enable_sdrc		@ take SDRC out of idle
>  	cmp	r4, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
>  	bleq	wait_dll_unlock
> @@ -104,8 +106,6 @@ ENTRY(omap3_sram_configure_core_dpll)
>  	cmp	r7, #1			@ if increasing SDRC clk rate,
>  	beq	return_to_sdram		@ return to SDRAM code, otherwise,
>  	bl	configure_sdrc		@ reprogram SDRC regs now
> -	mov	r12, r5
> -	bl	wait_clk_stable		@ wait for SDRC to stabilize
>  return_to_sdram:
>  	isb				@ prevent speculative exec past here
>  	mov 	r0, #0 			@ return value
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
