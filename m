From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] usb: musb: Offmode fix for idle path
Date: Thu, 08 Jul 2010 17:28:03 +0400
Message-ID: <4C35D263.9090704@ru.mvista.com>
References: <1278584916-21288-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35047 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab0GHN3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:29:06 -0400
In-Reply-To: <1278584916-21288-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello.

Hema HK wrote:

> With OMAP coreoff support usb was not functional as context was getting
> lost after wakeup from coreoff. And also usb was blocking the coreoff 

    USB is an acronym.

> after loading the gadget driver even with no cable connected sometimes.

> Added the conext save/restore api in the platform layer which will

    API is an acronym.

> be called in the idle and wakeup path.

> Changed the usb sysconfig settings as per the usbotg functional spec.

    Do you mean the OTG supplement to USB 2.0 spec. or something else?

> When the device is not used, configure in force idle and force standby mode.
> When it is being used, configure in smart standby and smart idle mode.
> So while attempting to coreoff the usb is configured to force standby and 
> force idle mode, after wakeup configured in smart idle and smart standby.

> Since clock used for musb is auto gated, there is no need to specifically
> enable/disable the clock. Removed enable/disable clock in suspend resume api.

    I'm not sure it's auto-gated on all platforms...

> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>

> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> @@ -177,6 +177,21 @@ void __init usb_musb_init(struct omap_mu
>  	usb_musb_pm_init();
>  }
>  
> +void musb_context_save_restore(int save)
> +{
> +	struct device *dev = &musb_device.dev;
> +	struct device_driver *drv = dev->driver;

    Need an empty line here.

> +	if (dev->driver) {

   You've just assigned that to 'drv' -- why not use it?

> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h
> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
> @@ -82,6 +82,8 @@ extern void usb_ohci_init(const struct o
>  /* This is needed for OMAP3 errata 1.164: enabled autoidle can prevent sleep */
>  extern void usb_musb_disable_autoidle(void);
>  
> +/* For saving and restoring the musb context during off/wakeup*/
> +extern void musb_context_save_restore(int save);
>  #endif
>  
>  void omap_usb_init(struct omap_usb_config *pdata);
> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
> +++ linux-omap-pm/drivers/usb/musb/musb_core.c
> @@ -2430,11 +2430,6 @@ static int musb_suspend(struct device *d
>  	}
>  
>  	musb_save_context(musb);
> -
> -	if (musb->set_clock)
> -		musb->set_clock(musb->clock, 0);
> -	else
> -		clk_disable(musb->clock);
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  	return 0;
>  }
> @@ -2446,12 +2441,6 @@ static int musb_resume_noirq(struct devi
>  
>  	if (!musb->clock)
>  		return 0;
> -
> -	if (musb->set_clock)
> -		musb->set_clock(musb->clock, 1);
> -	else
> -		clk_enable(musb->clock);
> -

    OK, maybe for OMAP the clock is auto-gated but what about the other platforms?

>  	musb_restore_context(musb);
>  
>  	/* for static cmos like DaVinci, register values were preserved
> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c
> @@ -257,15 +257,39 @@ int __init musb_platform_init(struct mus
>  void musb_platform_save_context(struct musb *musb,
>  		struct musb_context_registers *musb_context)
>  {
> -	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
> -	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
> +	/*
> +	 * As per the specification, configure it to forced standby
> +	 * and  force idle mode when no activity on usb.
> +	 */
> +	void __iomem *musb_base = musb->mregs;

    Need an empty line here.

> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) & ~(NOSTDBY | SMARTSTDBY));
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +					OTG_SYSCONFIG) & ~(AUTOIDLE));

    Parens around AUTOIDLE are not useful.

> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) & ~(NOIDLE | SMARTIDLE));
> +
> +	musb_writel(musb_base, OTG_FORCESTDBY, 1);
>  }
>  
>  void musb_platform_restore_context(struct musb *musb,
>  		struct musb_context_registers *musb_context)
>  {
> -	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context->otg_sysconfig);
> -	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context->otg_forcestandby);
> +	/*
> +	 * As per the specification, configure it smart standby
> +	 * and smart idle during operation.
> +	 */
> +	void __iomem *musb_base = musb->mregs;

   Need an empty line here.

> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) | (SMARTSTDBY));

    Parens around SMARTSTDBY are not useful.

> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +					OTG_SYSCONFIG) | (SMARTIDLE));

    Ditto about parens around SMARTIDLE...

WBR, Sergei
