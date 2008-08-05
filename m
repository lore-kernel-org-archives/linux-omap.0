From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Enable SYSOFFMODE use
Date: Tue, 5 Aug 2008 13:50:58 +0300
Message-ID: <20080805105057.GQ7193@atomide.com>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com> <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49709 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbYHELOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:14:00 -0400
Content-Disposition: inline
In-Reply-To: <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080721 19:03]:
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 0f3a659..b41fe96 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -396,17 +396,17 @@ static void sr_configure_vc(void)
>  
>  	/* Setup voltctrl and other setup times */
>  	/* XXX CONFIG_SYSOFFMODE has not been implemented yet */
> -#ifdef CONFIG_SYSOFFMODE
> -	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET,
> -			OMAP3430_GR_MOD,
> +#ifdef CONFIG_OMAP_SYSOFFMODE
> +	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
> +			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
>  			OMAP3_PRM_VOLTCTRL_OFFSET);
>  
>  	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
>  			OMAP3_PRM_CLKSETUP_OFFSET);
>  	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
> -			OMAP3430_VOLTSETUP_TIME2_OFFSET) |
> +			OMAP3430_SETUP_TIME2_SHIFT) |
>  			(OMAP3430_VOLTSETUP_TIME1 <<
> -			OMAP3430_VOLTSETUP_TIME1_OFFSET),
> +			OMAP3430_SETUP_TIME1_SHIFT),
>  			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
>  
>  	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,

Do we need the CONFIG_SYSOFFMODE option? How about just add
/sys/power/off_while_idle and if that's set to 1 then allow off mode?

Tony
