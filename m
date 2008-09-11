From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Patch for Touch Screen noise on OMAP3EVM.
Date: Wed, 10 Sep 2008 17:26:25 -0700
Message-ID: <20080911002625.GF21163@atomide.com>
References: <6B5159045A3A48F9831070C42A927DE7@mistral.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61537 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYIKA00 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 20:26:26 -0400
Content-Disposition: inline
In-Reply-To: <6B5159045A3A48F9831070C42A927DE7@mistral.in>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: A NAVEEN <anaveen@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org, 'Samyeer Metrani' <samyeer@mistralsoftware.com>

* A NAVEEN <anaveen@mistralsolutions.com> [080907 23:09]:
> 
> 
> When git kernel tree is used on a OMAP3EVM board file for touch screen
> testing, it shows lot of jitter. With this patch the jitter can be
> reduced.

Ah but this applies, pushing today.

Tony

> Signed-off-by: Naveen Atmakuri <anaveen@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> index 4963f0f..9a4784e 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -27,6 +27,8 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
>  
>  #include <mach/gpio.h>
>  #include <mach/keypad.h>
> @@ -132,8 +134,16 @@ static int ads7846_get_pendown_state(void)
>  }
>  
>  struct ads7846_platform_data ads7846_config = {
> +	.x_max                  = 0x0fff,
> +	.y_max                  = 0x0fff,
> +	.x_plate_ohms           = 180,
> +	.pressure_max           = 255,
> +	.debounce_max           = 10,
> +	.debounce_tol           = 3,
> +	.debounce_rep           = 1,
>  	.get_pendown_state	= ads7846_get_pendown_state,
>  	.keep_vref_on		= 1,
> +	.settle_delay_usecs     = 150,
>  };
>  
>  static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> -- 
> 1.5.6
> 
> 
> Warm Regards,
> Naveen Atmakuri.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
