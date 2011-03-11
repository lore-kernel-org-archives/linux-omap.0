From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap: rx51: initialize platform data for twl4030
 powerbutton
Date: Fri, 11 Mar 2011 11:05:08 -0800
Message-ID: <20110311190507.GD10079@atomide.com>
References: <078f4a01fa523a0f9e0033c52f52413d60cc5431.1299860654.git.ext-denis.2.karpov@nokia.com>
 <0aaadf1ebe1864fa310a8b1330dd688079983f8d.1299860654.git.ext-denis.2.karpov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27435 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab1CKTFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 14:05:09 -0500
Content-Disposition: inline
In-Reply-To: <0aaadf1ebe1864fa310a8b1330dd688079983f8d.1299860654.git.ext-denis.2.karpov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: linux-omap@vger.kernel.org

* Denis Karpov <ext-denis.2.karpov@nokia.com> [110311 08:35]:
> From: Denis Karpov <ext-denis.2.karpov@nokia.com>
> 
> Adds and initializes platform data for TWL4030 powerbutton.
> Disable repeat input events from a button press (default behaviour).
> 
> Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>

This should get merged along with the driver related patch:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 5f1900c..c9a21ef 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -264,6 +264,10 @@ static struct twl4030_keypad_data rx51_kp_data = {
>  	.rep		= 1,
>  };
>  
> +static struct twl4030_pwrbutton_data rx51_pwrbutton_data = {
> +	.rep		= 1,
> +};
> +
>  static struct twl4030_madc_platform_data rx51_madc_data = {
>  	.irq_line		= 1,
>  };
> @@ -758,6 +762,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
>  	/* platform_data for children goes here */
>  	.gpio			= &rx51_gpio_data,
>  	.keypad			= &rx51_kp_data,
> +	.pwrbutton		= &rx51_pwrbutton_data,
>  	.madc			= &rx51_madc_data,
>  	.usb			= &rx51_usb_data,
>  	.power			= &rx51_t2scripts_data,
> -- 
> 1.7.1
> 
