From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/11] OMAP3: PM: Disable OTG autoidle when waking up from off-mode
Date: Wed, 11 Nov 2009 15:42:15 -0800
Message-ID: <878wecy6g8.fsf@deeprootsystems.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-10-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-11-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-12-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:5405 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759712AbZKKXmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:42:13 -0500
Received: by qw-out-2122.google.com with SMTP id 3so321818qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:42:18 -0800 (PST)
In-Reply-To: <1256313835-2391-12-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 23 Oct 2009 19\:03\:55 +0300")
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
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

This one needs a refresh against current PM branch.

> ---
>  arch/arm/mach-omap2/pm34xx.c          |    6 ++++++
>  arch/arm/mach-omap2/usb-musb.c        |   14 ++++++++------
>  arch/arm/plat-omap/include/mach/usb.h |    3 +++

mach/usb.h moved to plat/usb.h

>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 5eb7321..070a0a2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -39,6 +39,7 @@
>  #include <mach/gpmc.h>
>  #include <mach/dma.h>
>  #include <mach/dmtimer.h>
> +#include <mach/usb.h>
>  
>  #include <asm/tlbflush.h>
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

NAK.  This belongs in the MUSB driver, not in the idle path.

Kevin

>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 8dde0b7..f4b86c0 100644
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
>  
> -	iounmap(otg_base);
> +void usb_musb_disable_autoidle(void)
> +{
> +	__raw_writel(0, otg_base + OTG_SYSCONFIG);
>  }
>  
>  #ifdef CONFIG_USB_MUSB_SOC
> diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
> index a4068a4..310ee17 100644
> --- a/arch/arm/plat-omap/include/mach/usb.h
> +++ b/arch/arm/plat-omap/include/mach/usb.h
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
