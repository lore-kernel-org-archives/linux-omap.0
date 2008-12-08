From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Removes unused platform device for osk5912
Date: Mon, 8 Dec 2008 11:12:51 -0800
Message-ID: <20081208191251.GS7388@atomide.com>
References: <1228456391-7292-1-git-send-email-arunks@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61752 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYLHTMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 14:12:53 -0500
Content-Disposition: inline
In-Reply-To: <1228456391-7292-1-git-send-email-arunks@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunks@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net, dirk.behme@de.bosch.com

* arunks@mistralsolutions.com <arunks@mistralsolutions.com> [081204 21:53]:
> From: Arun KS <arunks@mistralsolutions.com>
> 
> This patch removes platform device used my ALSA driver, which
> is now replaced with ASoC driver.

Thanks, I'll apply this to linux-omap tree. Will also expand it to
delete similar code from other board files for the mainline queue.
Some of the includes can disappear with this patch, BTW.

Tony

> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/mach-omap1/board-osk.c |   37 -------------------------------------
>  1 files changed, 0 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
> index 41e40d6..d2dfff5 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -141,47 +141,10 @@ static struct platform_device osk5912_cf_device = {
>  	.resource	= osk5912_cf_resources,
>  };
>  
> -#define DEFAULT_BITPERSAMPLE 16
> -
> -static struct omap_mcbsp_reg_cfg mcbsp_regs = {
> -	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
> -	.spcr1 = RINTM(3) | RRST,
> -	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
> -	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
> -	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
> -	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
> -	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
> -	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
> -	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
> -	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
> -	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
> -	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
> -};
> -
> -static struct omap_alsa_codec_config alsa_config = {
> -	.name			= "OSK AIC23",
> -	.mcbsp_regs_alsa	= &mcbsp_regs,
> -	.codec_configure_dev	= NULL, /* aic23_configure, */
> -	.codec_set_samplerate	= NULL, /* aic23_set_samplerate, */
> -	.codec_clock_setup	= NULL, /* aic23_clock_setup, */
> -	.codec_clock_on		= NULL, /* aic23_clock_on, */
> -	.codec_clock_off	= NULL, /* aic23_clock_off, */
> -	.get_default_samplerate	= NULL, /* aic23_get_default_samplerate, */
> -};
> -
> -static struct platform_device osk5912_mcbsp1_device = {
> -	.name	= "omap_alsa_mcbsp",
> -	.id	= 1,
> -	.dev = {
> -		.platform_data	= &alsa_config,
> -	},
> -};
> -
>  static struct platform_device *osk5912_devices[] __initdata = {
>  	&osk5912_flash_device,
>  	&osk5912_smc91x_device,
>  	&osk5912_cf_device,
> -	&osk5912_mcbsp1_device,
>  };
>  
>  static struct gpio_led tps_leds[] = {
> -- 
> 1.5.6.3
> 
