From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM 1/1] OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2
Date: Thu, 05 Feb 2009 06:30:34 -0800
Message-ID: <87k5856jn9.fsf@deeprootsystems.com>
References: <1233833641-5329-1-git-send-email-jouni.hogander@nokia.com>
	<1233833641-5329-2-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:26809 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZBEOaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 09:30:39 -0500
Received: by qw-out-2122.google.com with SMTP id 3so131598qwe.37
        for <linux-omap@vger.kernel.org>; Thu, 05 Feb 2009 06:30:38 -0800 (PST)
In-Reply-To: <1233833641-5329-2-git-send-email-jouni.hogander@nokia.com> (Jouni Hogander's message of "Thu\,  5 Feb 2009 13\:34\:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Jouni Hogander <jouni.hogander@nokia.com> writes:

> CM_CLKSEL1_PLL_IVA2 is not saved/restored currently. This patch is
> adding save and restore for it.
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/prcm.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Thanks, pushed to pm branch.

Kevin

> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index c64b668..7ccaf7f 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -36,6 +36,7 @@ static void __iomem *cm_base;
>  
>  struct omap3_prcm_regs {
>  	u32 control_padconf_sys_nirq;
> +	u32 iva2_cm_clksel1;
>  	u32 iva2_cm_clksel2;
>  	u32 cm_sysconfig;
>  	u32 sgx_cm_clksel;
> @@ -218,6 +219,8 @@ void omap3_prcm_save_context(void)
>  {
>  	prcm_context.control_padconf_sys_nirq =
>  			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
> +	prcm_context.iva2_cm_clksel1 =
> +			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
>  	prcm_context.iva2_cm_clksel2 =
>  			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
>  	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
> @@ -371,6 +374,8 @@ void omap3_prcm_restore_context(void)
>  {
>  	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
>  					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
> +	cm_write_mod_reg(prcm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
> +					 CM_CLKSEL1);
>  	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
>  					 CM_CLKSEL2);
>  	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
> -- 
> 1.6.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
