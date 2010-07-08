From: "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: musb: Offmode fix for idle path
Date: Thu, 8 Jul 2010 19:13:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305C11CBF@dbde02.ent.ti.com>
References: <1278584916-21288-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278584916-21288-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hema,

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Kalliguddi, Hema
> Sent: Thursday, July 08, 2010 3:59 PM
> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Kalliguddi, Hema; Mankad, Maulik Ojas; Felipe Balbi; Tony Lindgren; Kevin Hilman
> Subject: [PATCH] usb: musb: Offmode fix for idle path
> 
> From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>
> 
> With OMAP coreoff support usb was not functional as context was getting
> lost after wakeup from coreoff. And also usb was blocking the coreoff
> after loading the gadget driver even with no cable connected sometimes.
> 
> Added the conext save/restore api in the platform layer which will
> be called in the idle and wakeup path.
> 
> Changed the usb sysconfig settings as per the usbotg functional spec.
> When the device is not used, configure in force idle and force standby mode.
> When it is being used, configure in smart standby and smart idle mode.
> So while attempting to coreoff the usb is configured to force standby and
> force idle mode, after wakeup configured in smart idle and smart standby.
> 
> Since clock used for musb is auto gated, there is no need to specifically
> enable/disable the clock. Removed enable/disable clock in suspend resume api.
> 
> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> 
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
> Based off : Kevin pm branch.
> 
>  arch/arm/mach-omap2/pm34xx.c          |    4 ++++
>  arch/arm/mach-omap2/usb-musb.c        |   15 +++++++++++++++
>  arch/arm/plat-omap/include/plat/usb.h |    2 ++
>  drivers/usb/musb/musb_core.c          |   11 -----------
>  drivers/usb/musb/omap2430.c           |   32
> ++++++++++++++++++++++++++++----
>  5 files changed, 49 insertions(+), 15 deletions(-)
> 
> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> =====================================================
> ==============
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> @@ -431,6 +431,8 @@ void omap_sram_idle(void)
>  		if (core_next_state == PWRDM_POWER_OFF) {
>  			omap3_core_save_context();
>  			omap3_prcm_save_context();
> +			/* Save MUSB context */
> +			musb_context_save_restore(1);
Do you really need to save and restore USB context in every OS Idle? Can't it be done on a need basis like when USB is connected?
>  		}
>  	}
> 
> @@ -479,6 +481,8 @@ void omap_sram_idle(void)
>  			omap3_prcm_restore_context();
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
> +			/* Restore MUSB context */
> +			musb_context_save_restore(0);
>  			/*
>  			 * Errata 1.164 fix : OTG autoidle can prevent
>  			 * sleep
> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> =====================================================
> ==============
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
> +	if (dev->driver) {
> +
> +		const struct dev_pm_ops *pm = drv->pm;
> +
> +		if (save)
> +			pm->suspend(dev);
> +		else
> +			pm->resume_noirq(dev);
> +	}
> +}
> +
>  #else
>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  {
> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
> =====================================================
> ==============
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
> =====================================================
> ==============
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
>  	musb_restore_context(musb);
> 
>  	/* for static cmos like DaVinci, register values were preserved
> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> =====================================================
> ==============
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c
> @@ -257,15 +257,39 @@ int __init musb_platform_init(struct mus
>  void musb_platform_save_context(struct musb *musb,
>  		struct musb_context_registers *musb_context)
>  {
> -	musb_context->otg_sysconfig = musb_readl(musb->mregs,
> OTG_SYSCONFIG);
> -	musb_context->otg_forcestandby = musb_readl(musb->mregs,
> OTG_FORCESTDBY);
> +	/*
> +	 * As per the specification, configure it to forced standby
> +	 * and  force idle mode when no activity on usb.
> +	 */
> +	void __iomem *musb_base = musb->mregs;
> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) & ~(NOSTDBY | SMARTSTDBY));
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +					OTG_SYSCONFIG) & ~(AUTOIDLE));
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) & ~(NOIDLE | SMARTIDLE));
> +
> +	musb_writel(musb_base, OTG_FORCESTDBY, 1);
>  }

Since this is called from OS Idle, I would suggest to optimize this code so that you will save the context only when currently saved context is different from the already stored one. Otherwise you will end of saving the same context every time unnecessary. 
> 
>  void musb_platform_restore_context(struct musb *musb,
>  		struct musb_context_registers *musb_context)
>  {
> -	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context-
> >otg_sysconfig);
> -	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context-
> >otg_forcestandby);
> +	/*
> +	 * As per the specification, configure it smart standby
> +	 * and smart idle during operation.
> +	 */
> +	void __iomem *musb_base = musb->mregs;
> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) | (SMARTSTDBY));
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +					OTG_SYSCONFIG) | (SMARTIDLE));
>  }
Restore should be one only if context is lost. If Core fails to enter off state, then there is no need to restore context.

Vishwa
>  #endif
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
