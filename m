From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: OMAP3: PM: Disable OTG autoidle when waking up from off-mode
Date: Thu, 21 Jan 2010 16:00:32 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A5422EC@dbde02.ent.ti.com>
References: <1264069473-30236-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab0AUKak convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 05:30:40 -0500
In-Reply-To: <1264069473-30236-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tero.kristo@nokia.com" <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Hi Kristo,

There are some issues with this patch in PM branch.

Please find my comments inline.

Regards,
Ajay

>     OMAP3: PM: Disable OTG autoidle when waking up from off-mode
> 
>     OMAP3 sleep can be prevented in some cases where OTG autoidle is
> enabled.
>     This patch force disables autoidle during wakeup from off-mode. See
> omap
>     errata 1.164.
> 
>     This fix can't be done in driver level, as off-mode entry resets and
> enables
>     the autoidle bit, and driver does not access the register after each
> off-mode
>     entry even if it is loaded.
> 
> 	Tero Kristo <tero.kristo nokia.com>
> 	Kevin Hilman <khilman deeprootsystems.com>
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 81ed252..ddd19cd 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -37,6 +37,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/dma.h>
>  #include <plat/dmtimer.h>
> +#include <plat/usb.h>
> 
>  #include <asm/tlbflush.h>
> 
> @@ -430,6 +431,11 @@ void omap_sram_idle(void)
>  			omap3_prcm_restore_context();
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
> +			/*
> +			 * Errata 1.164 fix : OTG autoidle can prevent
> +			 * sleep
> +			 */
> +			usb_musb_disable_autoidle();

Do we really need it? We are anyway disabling autoidle in
Drivers/usb/musb/omap2430.c file.


>  		clk_disable(otg_clk);
> -		clk_put(otg_clk);
> -	}
> +}

<snip..>

> 
> -	iounmap(otg_base);
> +void usb_musb_disable_autoidle(void)
> +{
> +	__raw_writel(0, otg_base + OTG_SYSCONFIG);


We should first read the register and the reset the first bit D0
for disabling autoidle.

Also, musb clock needs to be enabled during this function call.
When I tool musb save/restore patch (accepted and in queue),
I found a system hand during resume.

-Ajay
>  }
