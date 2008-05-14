From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resend] [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Wed, 14 May 2008 15:42:53 -0700
Message-ID: <20080514224253.GE8928@atomide.com>
References: <C5EF98DB-8FEF-4AE0-A6BF-7D3FD1E41313@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55039 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbYENWmw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:42:52 -0400
Content-Disposition: inline
In-Reply-To: <C5EF98DB-8FEF-4AE0-A6BF-7D3FD1E41313@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

* Koen Kooi <k.kooi@student.utwente.nl> [080513 01:20]:
> This patch adds RTC support to the omap3 based beagleboard

I've pushed this after tweaking it manually again. It seems it was for
some older kernel? Also you should check your mail client or smtp server
to make sure patches don't wrap like this one is wrapped. It makes it
hard to read and apply them.

Anyways, can you please check that the patch got applied OK?

Thanks,

Tony


> Signed-off-by: Koen Kooi <koen@openembedded.org>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> omap2/board-omap3beagle.c
> index 626f004..0c0cbfc 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -58,13 +58,25 @@ static struct omap_mmc_config omap3beagle_mmc_config 
> __initdata = {
>  	},
>  };
>
> +static struct platform_device omap3_beagle_twl4030rtc_device = {
> +	.name           = "twl4030_rtc",
> +	.id             = -1,
> +};
> +
>  static struct omap_board_config_kernel omap3_beagle_config[] __initdata 
> = {
>  	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
>  	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
>  };
>
> +static struct platform_device *omap3_beagle_devices[] __initdata = {
> +#ifdef CONFIG_RTC_DRV_TWL4030
> +	&omap3_beagle_twl4030rtc_device,
> +#endif
> +};
> +
>  static void __init omap3_beagle_init(void)
>  {
> +	platform_add_devices(omap3_beagle_devices,  
> ARRAY_SIZE(omap3_beagle_devices));
>  	omap_board_config = omap3_beagle_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap_serial_init();
> -- 
> 1.5.4.3
>
>
