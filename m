From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/5] OMAP3: PM: Disable OTG autoidle when waking up from off-mode
Date: Thu, 12 Nov 2009 07:37:14 -0800
Message-ID: <87zl6ru53p.fsf@deeprootsystems.com>
References: <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-4-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-5-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-6-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54138 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZKLPhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 10:37:11 -0500
Received: by pwi3 with SMTP id 3so1402549pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 07:37:16 -0800 (PST)
In-Reply-To: <1258020444-3809-6-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 12\:07\:24 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> OMAP3 sleep can be prevented in some cases where OTG autoidle is enabled.
> This patch force disables autoidle during wakeup from off-mode. See omap
> errata 1.164.
>
> This fix can't be done in driver level, as off-mode entry resets and enables
> the autoidle bit, and driver does not access the register after each off-mode
> entry even if it is loaded.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks Tero for the updated changelog.

Applying to PM branch reluctantly and with grumbles.  I sure hope
someone in TI is reporting all these ROM code issues to the ROM code
team so they get appropriate fixes.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c          |    6 ++++++
>  arch/arm/mach-omap2/usb-musb.c        |   14 ++++++++------
>  arch/arm/plat-omap/include/plat/usb.h |    3 +++
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 2f9f4a0..ab7b30f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -37,6 +37,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/dma.h>
>  #include <plat/dmtimer.h>
> +#include <plat/usb.h>
>  
>  #include <plat/resource.h>
>  
> @@ -496,6 +497,11 @@ void omap_sram_idle(void)
>  			omap3_prcm_restore_context();
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
> +			/*
> +			 * Errata 1.164 fix : OTG autoidle can prevent
> +			 * sleep
> +			 */
> +			usb_musb_disable_autoidle();
>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index f5364b8..bb3cee4 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -44,10 +44,11 @@ static struct platform_device dummy_pdev = {
>  	},
>  };
>  
> +static void __iomem *otg_base;
> +static struct clk *otg_clk;
> +
>  static void __init usb_musb_pm_init(void)
>  {
> -	void __iomem *otg_base;
> -	struct clk *otg_clk;
>  	struct device *dev = &dummy_pdev.dev;
>  
>  	if (!cpu_is_omap34xx())
> @@ -74,12 +75,13 @@ static void __init usb_musb_pm_init(void)
>  			cpu_relax();
>  	}
>  
> -	if (otg_clk) {
> +	if (otg_clk)
>  		clk_disable(otg_clk);
> -		clk_put(otg_clk);
> -	}
> +}
>  
> -	iounmap(otg_base);
> +void usb_musb_disable_autoidle(void)
> +{
> +	__raw_writel(0, otg_base + OTG_SYSCONFIG);
>  }
>  
>  #ifdef CONFIG_USB_MUSB_SOC
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 33a500e..31b13bc 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -46,6 +46,9 @@ extern void usb_musb_init(void);
>  
>  extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
>  
> +/* This is needed for OMAP3 errata 1.164: enabled autoidle can prevent sleep */
> +extern void usb_musb_disable_autoidle(void);
> +
>  #endif
>  
>  void omap_usb_init(struct omap_usb_config *pdata);
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
