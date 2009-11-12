From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Remove duplicate code blocks
Date: Wed, 11 Nov 2009 16:15:27 -0800
Message-ID: <87pr7owqcg.fsf@deeprootsystems.com>
References: <1257173618-15120-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:33121 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759676AbZKLAPY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 19:15:24 -0500
Received: by pxi26 with SMTP id 26so1213136pxi.21
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 16:15:30 -0800 (PST)
In-Reply-To: <1257173618-15120-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Mon\,  2 Nov 2009 20\:23\:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch removes code blocks that are repeated
> in function prcm_setup_regs().
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Thanks, pulling into PM branch, queueing for pm-fixes.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   18 ------------------
>  1 files changed, 0 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fd103a1..11cfe59 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -957,24 +957,6 @@ static void __init prcm_setup_regs(void)
>  	/* Clear any pending PRCM interrupts */
>  	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>  
> -	/* Don't attach IVA interrupts */
> -	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
> -	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
> -	prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
> -	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
> -
> -	/* Clear any pending 'reset' flags */
> -	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
> -	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
> -	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, RM_RSTST);
> -	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, RM_RSTST);
> -	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, RM_RSTST);
> -	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, RM_RSTST);
> -	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, RM_RSTST);
> -
> -	/* Clear any pending PRCM interrupts */
> -	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> -
>  	omap3_iva_idle();
>  	omap3_d2d_idle();
>  }
> -- 
> 1.6.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
