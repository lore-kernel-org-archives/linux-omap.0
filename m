From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: Re-program also chipselect 1 when changing SDRAM timing
Date: Wed, 27 May 2009 08:49:34 -0700
Message-ID: <87bppewnox.fsf@deeprootsystems.com>
References: <1243426419-32652-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:45729 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbZE0Ptl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 11:49:41 -0400
Received: by pxi29 with SMTP id 29so471687pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 08:49:42 -0700 (PDT)
In-Reply-To: <1243426419-32652-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\, 27 May 2009 15\:13\:39 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Previously only chipselect 0 was controlled, which would result in the
> chipselect 1 running on too low rate during low core OPPs.
>
> Applies on top of PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Hi Tero,

This does part of what Jean Pihet does in his recent patch[1] to add
support for 2 CSs.  Your version assumes the same parameters for both
SDRAM parts, and Jean has expanded that so board code can configure
different paramaters for the different CSes.

I have yet to fully review Jean's patch, but will probably take his
version so that two different SDRAM parts could be used.

Kevin


[1] See hist post from 26 May: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was: Re: Beagleboard rev C memory timings & suspend/resume)

> ---
>  arch/arm/mach-omap2/sram34xx.S |   29 +++++++++++++++++++++++------
>  1 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index f41f8d9..bcfe9eb 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -187,15 +187,24 @@ wait_dll_unlock:
>  	bne	wait_dll_unlock
>  	bx	lr
>  configure_sdrc:
> -	ldr	r11, omap3_sdrc_rfr_ctrl
> +	ldr	r11, omap3_sdrc_rfr_ctrl_0
>  	str	r0, [r11]
> -	ldr	r11, omap3_sdrc_actim_ctrla
> +	ldr	r11, omap3_sdrc_rfr_ctrl_1
> +	str	r0, [r11]
> +	ldr	r11, omap3_sdrc_actim_ctrla_0
> +	str	r1, [r11]
> +	ldr	r11, omap3_sdrc_actim_ctrla_1
>  	str	r1, [r11]
> -	ldr	r11, omap3_sdrc_actim_ctrlb
> +	ldr	r11, omap3_sdrc_actim_ctrlb_0
> +	str	r2, [r11]
> +	ldr	r11, omap3_sdrc_actim_ctrlb_1
>  	str	r2, [r11]
>  	ldr	r11, omap3_sdrc_mr_0
>  	str	r6, [r11]
>  	ldr	r6, [r11]		@ posted-write barrier for SDRC
> +	ldr	r11, omap3_sdrc_mr_1
> +	str	r6, [r11]
> +	ldr	r6, [r11]		@ posted-write barrier for SDRC
>  	bx	lr
>  
>  omap3_sdrc_power:
> @@ -206,14 +215,22 @@ omap3_cm_idlest1_core:
>  	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
>  omap3_cm_iclken1_core:
>  	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
> -omap3_sdrc_rfr_ctrl:
> +omap3_sdrc_rfr_ctrl_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
> -omap3_sdrc_actim_ctrla:
> +omap3_sdrc_rfr_ctrl_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
> +omap3_sdrc_actim_ctrla_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
> -omap3_sdrc_actim_ctrlb:
> +omap3_sdrc_actim_ctrla_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
> +omap3_sdrc_actim_ctrlb_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
> +omap3_sdrc_actim_ctrlb_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
>  omap3_sdrc_mr_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
> +omap3_sdrc_mr_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
>  omap3_sdrc_dlla_status:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  omap3_sdrc_dlla_ctrl:
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
