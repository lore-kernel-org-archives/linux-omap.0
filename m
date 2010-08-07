From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Sat, 07 Aug 2010 19:25:25 +0400
Message-ID: <4C5D7AE5.7040506@ru.mvista.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281115624-1174-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Hema HK wrote:

> With OMAP core-off support musb was not functional as context was getting
> lost after wakeup from core-off. And also musb was blocking the core-off 
> after loading the gadget driver even with no cable connected sometimes.

> Added the conext save/restore api in the platform layer which will
> be called in the idle and wakeup path.

> Changed the usb sysconfig settings as per the usbotg functional spec.
> When the device is not active, configure to force idle and force standby mode.
> When it is being used, configure in smart standby and smart idle mode.
> So while attempting to coreoff the usb is configured to force standby and 
> force idle mode, after wakeup configured in smart idle and smart standby.

> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>

> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

[...]

> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c	2010-08-06 09:24:23.690112596 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c	2010-08-06 10:44:06.385862697 -0400
> @@ -120,6 +120,27 @@
>  	}
>  }
>  
> +void musb_context_save_restore(int save)
> +{
> +	struct omap_hwmod *oh = omap_hwmod_lookup("usb_otg_hs");
> +	struct omap_device *od = oh->od;
> +	struct platform_device *pdev = &od->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct device_driver *drv = dev->driver;
> +
> +	if (drv) {
> +		struct musb_hdrc_platform_data *pdata = dev->platform_data;
> +		const struct dev_pm_ops *pm = drv->pm;

    Should be an empty line after the declaration block...

> +		if (!pdata->is_usb_active(dev)) {
> +
> +			if (save)
> +				pm->suspend(dev);
> +			else
> +				pm->resume_noirq(dev);
> +		}
> +	}
> +}
> +
>  #else
>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  {
> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c	2010-08-06 09:24:21.069863329 -0400
> +++ linux-omap-pm/drivers/usb/musb/musb_core.c	2010-08-06 10:44:06.369863527 -0400
> @@ -2427,11 +2427,6 @@
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
> @@ -2443,12 +2438,6 @@
>  
>  	if (!musb->clock)
>  		return 0;
> -
> -	if (musb->set_clock)
> -		musb->set_clock(musb->clock, 1);
> -	else
> -		clk_enable(musb->clock);
> -
>  	musb_restore_context(musb);

   The same question again: are you sure that clocks are auto-gated on 
non-OMAP platfroms?

> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c	2010-08-06 09:24:21.069863329 -0400
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c	2010-08-06 10:44:30.093914217 -0400
[...]
> @@ -259,15 +273,42 @@
>  void musb_platform_save_context(struct musb *musb,
>  		struct musb_context_registers *musb_context)
>  {
> -	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
> -	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);

    If you're not saving the registers, you should remove the corresponding 
fields from 'struct musb_context_registers'.

> +	/*
> +	 * As per the omap-usbotg specification, configure it to forced standby
> +	 * and  force idle mode when no activity on usb.
> +	 */
> +	void __iomem *musb_base = musb->mregs;
> +
> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) & ~(NOSTDBY | SMARTSTDBY));
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +					OTG_SYSCONFIG) & ~(AUTOIDLE));

    Pointless parens around AUTOIDLE...

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
> +	 * As per the omap-usbotg specification, configure it smart standby
> +	 * and smart idle during operation.
> +	 */
> +	void __iomem *musb_base = musb->mregs;
> +
> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) | (SMARTSTDBY));

    Pointless parens around SMARTSTDBY...

> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) | (SMARTIDLE));

    Pointless parens around SMARTIDLE...

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
