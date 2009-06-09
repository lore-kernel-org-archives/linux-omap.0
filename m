From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:
 Re: Beagleboard rev C memory timings & suspend/resume)
Date: Tue, 9 Jun 2009 01:26:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906090124310.32281@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <200906051735.57772.jpihet@mvista.com> <alpine.DEB.2.00.0906051207270.31531@utopia.booyaka.com> <200906081059.46134.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44261 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbZFIH0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 03:26:21 -0400
In-Reply-To: <200906081059.46134.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, tero.kristo@nokia.com, linux-omap <linux-omap@vger.kernel.org>

Hi Jean,

On Mon, 8 Jun 2009, Jean Pihet wrote:

> Here is the updated patch that fixes the Overo build as well.
> Can you check it?

> diff --git a/arch/arm/mach-omap2/board-overo.c 
> b/arch/arm/mach-omap2/board-overo.c
> index 9eae608..50902d4 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -45,6 +45,7 @@
>  #include <mach/gpmc.h>
>  #include <mach/hardware.h>
>  #include <mach/nand.h>
> +#include <mach/mux.h>
>  #include <mach/usb.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
> @@ -355,7 +356,9 @@ static int __init overo_i2c_init(void)
>  
>  static void __init overo_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +			     mt46h32m32lf6_sdrc_params,
> +			     NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> @@ -391,6 +394,10 @@ static void __init overo_init(void)
>  	overo_init_smsc911x();
>  	overo_ads7846_init();
>  
> +	/* Ensure SDRC pins are mux'd for self-refresh */
> +	omap_cfg_reg(H16_34XX_SDRC_CKE0);
> +	omap_cfg_reg(H17_34XX_SDRC_CKE1);
> +
>  	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
>  			  "OVERO_GPIO_W2W_NRESET") == 0) &&
>  	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) == 0)) {

These changes look fine to me based on a quick look.  Haven't tried 
building it.


- Paul
