From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch] OMAP: ARM: Fix Comp for LDP on DeviceType
Date: Mon, 6 Oct 2008 11:51:07 +0300
Message-ID: <20081006085105.GK14042@atomide.com>
References: <13B9B4C6EF24D648824FF11BE896716203657CAE29@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55263 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYJFIsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 04:48:10 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203657CAE29@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Zavala Trujillo, Diego" <diegozt@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Zavala Trujillo, Diego <diegozt@ti.com> [080920 10:11]:
> 
> 
> Regards,
> Fix the compilation for the 3430LDP.
> Replace omap_device_type for omap_type.

Thanks, looks like I've already pushed a similar patch from Felipe.

Tony

> ---
>  arch/arm/mach-omap2/board-ldp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/board-ldp.c
> 
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> old mode 100644
> new mode 100755
> index 9263be9..02359d5
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -54,7 +54,7 @@ static int __init msecure_init(void)
>  
>  #ifdef CONFIG_RTC_DRV_TWL4030
>  	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
> -	if (omap_device_type() == OMAP2_DEVICE_TYPE_GP &&
> +	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
>  			system_rev < OMAP3430_REV_ES2_0) {
>  		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
>  		int mux_mask = 0x04;
> -- 
> 1.5.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
