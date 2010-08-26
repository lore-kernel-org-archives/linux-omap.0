From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 6/8 v2] usb: musb: Offmode fix for idle path
Date: Wed, 25 Aug 2010 17:09:36 -0700
Message-ID: <87iq2y5j5r.fsf@deeprootsystems.com>
References: <1282140624-29715-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282140624-29715-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org> (Hema HK's
	message of "Wed, 18 Aug 2010 19:40:24 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hema HK <hemahk-l0cyMroinI0@public.gmane.org> writes:

> With OMAP core-off support musb was not functional as context was getting
> lost after wakeup from core-off. And also musb was blocking the core-off
> after loading the gadget driver even with no cable connected sometimes.
>
> Added the conext save/restore api in the platform layer which will
> be called in the idle and wakeup path.
>
> Changed the usb sysconfig settings as per the usbotg functional spec.
> When the device is not used, configure to force idle and force standby mode.
> When it is being used, configure in smart standby and smart idle mode.
> So while attempting to coreoff the usb is configured to force standby and
> force idle mode, after wakeup configured in smart idle and smart standby.

You don't describe the new .clk_autogated field added here.  That part
should be a separate patch as it's not directly related to $SUBJECT patch.

> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
>
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/mach-omap2/pm34xx.c          |    5 +++
>  arch/arm/mach-omap2/usb-musb.c        |   42 ++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/usb.h |    2 +
>  drivers/usb/musb/musb_core.c          |   10 +++----
>  drivers/usb/musb/musb_core.h          |    1 -
>  drivers/usb/musb/omap2430.c           |   48 ++++++++++++++++++++++++++++++---
>  include/linux/usb/musb.h              |    6 ++++
>  7 files changed, 102 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fb4994a..7b34201 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -39,6 +39,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/dma.h>
>  #include <plat/dmtimer.h>
> +#include <plat/usb.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -416,6 +417,8 @@ void omap_sram_idle(void)
>  		if (core_next_state == PWRDM_POWER_OFF) {
>  			omap3_core_save_context();
>  			omap3_prcm_save_context();
> +			/* Save MUSB context */
> +			musb_context_save_restore(1);
>  		}
>  	}
>  
> @@ -458,6 +461,8 @@ void omap_sram_idle(void)
>  			omap3_prcm_restore_context();
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
> +			/* restore MUSB context */
> +			musb_context_save_restore(0);
>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index c228cc0..9d10440 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -35,6 +35,7 @@
>  
>  static const char name[] = "musb_hdrc";
>  #define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
> +struct omap_hwmod *oh_p =NULL;
>  
>  static struct musb_hdrc_config musb_config = {
>  	.multipoint	= 1,
> @@ -59,6 +60,9 @@ static struct musb_hdrc_platform_data musb_plat = {
>  	 * "mode", and should be passed to usb_musb_init().
>  	 */
>  	.power		= 50,			/* up to 100 mA */
> +
> +	/* supports clock autogating */
> +	.clk_autogated	= 1,

This appears unrelated, and should be a separate patch.

>  };
>  
>  static u64 musb_dmamask = DMA_BIT_MASK(32);
> @@ -97,7 +101,7 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  	musb_plat.mode = board_data->mode;
>  	musb_plat.extvbus = board_data->extvbus;
>  	pdata = &musb_plat;
> -
> +	oh_p = oh;
>  	od = omap_device_build(name, bus_id, oh, pdata,
>  			       sizeof(struct musb_hdrc_platform_data),
>  						omap_musb_latency,
> @@ -116,8 +120,44 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  
>  }
>  
> +void musb_context_save_restore(int save)
> +{
> +	struct omap_hwmod *oh = oh_p;
> +	struct omap_device *od;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	struct device_driver *drv;
> +	struct musb_hdrc_platform_data *pdata;
> +	const struct dev_pm_ops *pm;
> +
> +	if (!oh)
> +		return;
> +	od = oh->od;
> +	pdev = &od->pdev;
> +	if (!pdev)
> +		return;
> +	dev = &pdev->dev;
> +	drv = dev->driver;
> +
> +	if (drv) {
> +		pdata = dev->platform_data;
> +		pm = drv->pm;
> +
> +		if (!pdata->is_usb_active(dev)) {
> +
> +			if (save)
> +				pm->suspend(dev);
> +			else
> +				pm->resume_noirq(dev);

-ECONFUSED

First, this 'save_restore' function neither saves or restores anything.

Second, I'm thoroughly confused about why you are simulating a system
suspend/resume here? 

Kevin

> +		}
> +	}
> +}
> +
>  #else
>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  {
>  }
> +void musb_context_save_restore(int save)
> +{
> +}
>  #endif /* CONFIG_USB_MUSB_SOC */
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 2a9427c..ed2b41a 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -79,6 +79,8 @@ extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
>  
>  extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
>  
> +/* For saving and restoring the musb context during off/wakeup*/
> +extern void musb_context_save_restore(int save);
>  #endif
>  
>  
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2a50d12..8510e55 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2410,6 +2410,7 @@ static int musb_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	unsigned long	flags;
>  	struct musb	*musb = dev_to_musb(&pdev->dev);
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  
>  	if (!musb->clock)
>  		return 0;
> @@ -2428,9 +2429,7 @@ static int musb_suspend(struct device *dev)
>  
>  	musb_save_context(musb);
>  
> -	if (musb->set_clock)
> -		musb->set_clock(musb->clock, 0);
> -	else
> +	if (!plat->clk_autogated)
>  		clk_disable(musb->clock);
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  	return 0;
> @@ -2440,13 +2439,12 @@ static int musb_resume_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct musb	*musb = dev_to_musb(&pdev->dev);
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  
>  	if (!musb->clock)
>  		return 0;
>  
> -	if (musb->set_clock)
> -		musb->set_clock(musb->clock, 1);
> -	else
> +	if (!plat->clk_autogated)
>  		clk_enable(musb->clock);
>  
>  	musb_restore_context(musb);
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 85a92fd..bfdf54d 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -472,7 +472,6 @@ struct musb_context_registers {
>  
>  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
>      defined(CONFIG_ARCH_OMAP4)
> -	u32 otg_sysconfig, otg_forcestandby;
>  #endif
>  	u8 power;
>  	u16 intrtxe, intrrxe;
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3bae428..dcba935 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -188,6 +188,18 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>  
>  	return 0;
>  }
> +int is_musb_active(struct device *dev)
> +{
> +	struct musb *musb;
> +
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> +	/* usbcore insists dev->driver_data is a "struct hcd *" */
> +	musb = hcd_to_musb(dev_get_drvdata(dev));
> +#else
> +	musb = dev_get_drvdata(dev);
> +#endif
> +	return musb->is_active;
> +}
>  
>  int __init musb_platform_init(struct musb *musb)
>  {
> @@ -246,6 +258,7 @@ int __init musb_platform_init(struct musb *musb)
>  	if (is_host_enabled(musb))
>  		musb->board_set_vbus = omap_set_vbus;
>  
> +	plat->is_usb_active = is_musb_active;
>  	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
>  
>  	return 0;
> @@ -255,15 +268,42 @@ int __init musb_platform_init(struct musb *musb)
>  void musb_platform_save_context(struct musb *musb,
>  		struct musb_context_registers *musb_context)
>  {
> -	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
> -	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
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
> +					OTG_SYSCONFIG) & ~AUTOIDLE);
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
> +	 * As per the omap-usbotg specification, configure it smart standby
> +	 * and smart idle during operation.
> +	 */
> +	void __iomem *musb_base = musb->mregs;
> +
> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) | SMARTSTDBY);
> +
> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
> +				OTG_SYSCONFIG) | SMARTIDLE | ENABLEWAKEUP);
>  }
>  #endif
>  
> diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
> index ee2dd1d..da134ab 100644
> --- a/include/linux/usb/musb.h
> +++ b/include/linux/usb/musb.h
> @@ -126,6 +126,12 @@ struct musb_hdrc_platform_data {
>  
>  	/* Architecture specific board data	*/
>  	void		*board_data;
> +
> +	/* check usb device active state*/
> +	int		(*is_usb_active)(struct device *dev);
> +
> +	/*  indiates whether clock is autogated */
> +	int		clk_autogated;
>  };
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
