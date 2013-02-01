From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Fri, 1 Feb 2013 14:45:47 -0800
Message-ID: <20130201224546.GG22517@atomide.com>
References: <51090829.1010109@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:21507 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756741Ab3BAWpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:45:51 -0500
Content-Disposition: inline
In-Reply-To: <51090829.1010109@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Chen Gang <gang.chen@asianux.com> [130130 03:50]:
> 
>   the fields must be null-terminated:
>   the caller may use it as null-terminted string, next.

Added Peter to cc on this one too, it's best that he queues
all the twl changes.

Tony
 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-omap2/twl-common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index e49b40b..6a7aec6 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -23,6 +23,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/gpio.h>
> +#include <linux/string.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
>  
> @@ -56,7 +57,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
>  			   struct twl4030_platform_data *pmic_data)
>  {
>  	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
> -	strncpy(pmic_i2c_board_info.type, pmic_type,
> +	strlcpy(pmic_i2c_board_info.type, pmic_type,
>  		sizeof(pmic_i2c_board_info.type));
>  	pmic_i2c_board_info.irq = pmic_irq;
>  	pmic_i2c_board_info.platform_data = pmic_data;
> -- 
> 1.7.10.4
