From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: rx51: Add support for vibra
Date: Wed, 2 Mar 2011 17:02:15 -0800
Message-ID: <20110303010215.GH20560@atomide.com>
References: <1298623583-9743-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:31340 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab1CCBCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 20:02:21 -0500
Content-Disposition: inline
In-Reply-To: <1298623583-9743-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Ilkka Koskinen <ilkka.koskinen@nokia.com> [110225 00:48]:

Adding for the merge window with updated description
"Add support for vibra".

Tony

> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index e75e240..dcd98fa 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -699,6 +699,14 @@ static struct twl4030_power_data rx51_t2scripts_data __initdata = {
>  	.resource_config = twl4030_rconfig,
>  };
>  
> +struct twl4030_codec_vibra_data rx51_vibra_data __initdata = {
> +	.coexist	= 0,
> +};
> +
> +struct twl4030_codec_data rx51_codec_data __initdata = {
> +	.audio_mclk	= 26000000,
> +	.vibra		= &rx51_vibra_data,
> +};
>  
>  static struct twl4030_platform_data rx51_twldata __initdata = {
>  	.irq_base		= TWL4030_IRQ_BASE,
> @@ -710,6 +718,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
>  	.madc			= &rx51_madc_data,
>  	.usb			= &rx51_usb_data,
>  	.power			= &rx51_t2scripts_data,
> +	.codec			= &rx51_codec_data,
>  
>  	.vaux1			= &rx51_vaux1,
>  	.vaux2			= &rx51_vaux2,
> -- 
> 1.7.0.4
> 
