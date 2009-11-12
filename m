From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap3evm: Add keypad as wakeup source
Date: Thu, 12 Nov 2009 15:30:49 -0800
Message-ID: <20091112233049.GL24837@atomide.com>
References: <1257254961-22506-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57261 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbZKLXaq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 18:30:46 -0500
Content-Disposition: inline
In-Reply-To: <1257254961-22506-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [091103 05:30]:
> Add keypad as wakeup source from 'suspend'
> state.

Let's put this one on hold too until the new mux framework is done.

Tony
 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 660ef8c..6a1a0cd 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -343,6 +343,16 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
>  	&omap3evm_smc911x_device,
>  };
>  
> +/*
> + * Set wakeup sources for the board
> + */
> +static void __init omap3_evm_wakeup_sources(void)
> +{
> +	pr_info("omap3evm: Adding wakeup sources");
> +
> +	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
> +}
> +
>  static void __init omap3_evm_init(void)
>  {
>  	omap3_evm_i2c_init();
> @@ -359,6 +369,8 @@ static void __init omap3_evm_init(void)
>  #endif
>  	usb_musb_init();
>  	ads7846_dev_init();
> +
> +	omap3_evm_wakeup_sources();
>  }
>  
>  static void __init omap3_evm_map_io(void)
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
