From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH] OMAP3: Remove CONFIG_OMAP_SYSOFFMODE flag
Date: Thu, 28 Aug 2008 16:09:47 +0300
Message-ID: <1219928987.6269.1.camel@kj-ubuntu>
References: <>
	 <1219755620-9773-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21315 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYH1NGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 09:06:38 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7SD6L1p032611
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 16:06:35 +0300
In-Reply-To: <1219755620-9773-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On ti, 2008-08-26 at 16:00 +0300, Kalle Jokiniemi wrote:
> Remove CONFIG_OMAP_SYSOFFMODE flag and do the full initialization of voltage
> controller . Enabling automatic sending of OFF command and selecting wether
> SYS_OFF_MODE signal is used should be determined dynamically. Hence they are
> now not set in the initialization.

This patch needs to be added with safer off-mode sleep voltage settings.
Please disregard, whis one. I'll send a new one with couple of other
patches soon.

regards,
Kalle

> 
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   10 +---------
>  1 files changed, 1 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a16eb33..5633753 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -623,10 +623,7 @@ static void __init configure_vc(void)
>  				OMAP3_PRM_VC_I2C_CFG_OFFSET);
>  
>  	/* Setup voltctrl and other setup times */
> -
> -#ifdef CONFIG_OMAP_SYSOFFMODE
> -	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
> -			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
> +	prm_write_mod_reg(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
>  			OMAP3_PRM_VOLTCTRL_OFFSET);
>  
>  	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
> @@ -641,11 +638,6 @@ static void __init configure_vc(void)
>  			OMAP3_PRM_VOLTOFFSET_OFFSET);
>  	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
>  			OMAP3_PRM_VOLTSETUP2_OFFSET);
> -#else
> -	prm_set_mod_reg_bits(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTCTRL_OFFSET);
> -#endif
> -
>  }
>  
>  static int __init omap3_pm_early_init(void)
