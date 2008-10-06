From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: ldp: fix compile breakage and physical/virtual
	address usage
Date: Mon, 6 Oct 2008 11:39:10 +0300
Message-ID: <20081006083910.GI14042@atomide.com>
References: <1222096226-31811-1-git-send-email-felipe.balbi@nokia.com> <1222096226-31811-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61931 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYJFIgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 04:36:12 -0400
Content-Disposition: inline
In-Reply-To: <1222096226-31811-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Nishant Kamat <nskamat@ti.com>

* Felipe Balbi <felipe.balbi@nokia.com> [080922 18:11]:
> commit bf9454a3aaf2cad2321aa8f97bfd5d8c4ebc7bf5 broke compilation
> for ldp board. The following patch fixes it. Also fixes a wrong
> cast from a void __iomem * to u32.

Pushing today.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-ldp.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index 9263be9..8b0256c 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -54,9 +54,10 @@ static int __init msecure_init(void)
>  
>  #ifdef CONFIG_RTC_DRV_TWL4030
>  	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
> -	if (omap_device_type() == OMAP2_DEVICE_TYPE_GP &&
> +	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
>  			system_rev < OMAP3430_REV_ES2_0) {
> -		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
> +		void __iomem *msecure_pad_config_reg =
> +			omap_ctrl_base_get() + 0xA3C;
>  		int mux_mask = 0x04;
>  		u16 tmp;
>  
> @@ -72,10 +73,10 @@ static int __init msecure_init(void)
>  		 * TWL4030 RTC time and calender registers.
>  		 */
>  
> -		tmp = omap_readw(msecure_pad_config_reg);
> +		tmp = __raw_readw(msecure_pad_config_reg);
>  		tmp &= 0xF8;	/* To enable mux mode 03/04 = GPIO_RTC */
>  		tmp |= mux_mask;/* To enable mux mode 03/04 = GPIO_RTC */
> -		omap_writew(tmp, msecure_pad_config_reg);
> +		__raw_writew(tmp, msecure_pad_config_reg);
>  
>  		gpio_direction_output(TWL4030_MSECURE_GPIO, 1);
>  	}
> -- 
> 1.6.0.1.308.gede4c
> 
