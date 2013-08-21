From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] am33xx-restart: trigger warm reset on omap2+ boards
Date: Wed, 21 Aug 2013 01:02:01 -0700
Message-ID: <20130821080201.GB7656@atomide.com>
References: <1375696944-13380-1-git-send-email-ujhelyi.m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19827 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3HUICI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 04:02:08 -0400
Content-Disposition: inline
In-Reply-To: <1375696944-13380-1-git-send-email-ujhelyi.m@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ujhelyi.m@gmail.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* ujhelyi.m@gmail.com <ujhelyi.m@gmail.com> [130805 03:09]:
> From: Matus Ujhelyi <ujhelyi.m@gmail.com>
> 
> Currently the cold reset was triggered. It happened due to oposite offsets
> of cold/warm flags in PRM_RSTST and PRM_RSTCTRL registers.

Thanks applying into omap-for-v3.12/fixes-non-critical.

Tony
 
> Signed-off-by: Matus Ujhelyi <ujhelyi.m@gmail.com>
> ---
>  arch/arm/mach-omap2/am33xx-restart.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
> index 1eae962..c88d8df7 100644
> --- a/arch/arm/mach-omap2/am33xx-restart.c
> +++ b/arch/arm/mach-omap2/am33xx-restart.c
> @@ -24,8 +24,8 @@ void am33xx_restart(enum reboot_mode mode, const char *cmd)
>  {
>  	/* TODO: Handle mode and cmd if necessary */
>  
> -	am33xx_prm_rmw_reg_bits(AM33XX_GLOBAL_WARM_SW_RST_MASK,
> -				AM33XX_GLOBAL_WARM_SW_RST_MASK,
> +	am33xx_prm_rmw_reg_bits(AM33XX_RST_GLOBAL_WARM_SW_MASK,
> +				AM33XX_RST_GLOBAL_WARM_SW_MASK,
>  				AM33XX_PRM_DEVICE_MOD,
>  				AM33XX_PRM_RSTCTRL_OFFSET);
>  
> -- 
> 1.7.9.5
> 
