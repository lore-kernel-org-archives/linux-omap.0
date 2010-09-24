From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Fri, 24 Sep 2010 12:41:34 -0700
Message-ID: <877hib9bf5.fsf@deeprootsystems.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57412 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab0IXTli (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 15:41:38 -0400
In-Reply-To: <1285201846-26599-1-git-send-email-hemahk@ti.com> (Hema HK's
	message of "Wed, 22 Sep 2010 20:30:46 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hema HK <hemahk@ti.com> writes:

> With OMAP core-off support musb was not functional as context was getting
> lost after wakeup from core-off. 

This should be a separate patch.

> And also musb was blocking the core-off after loading the gadget
> driver even with no cable connected sometimes.

this too

> Added the idle and wakeup APIs in the platform layer which will
> be called in the idle and wakeup path.

And this errata fix should be a separate patch, with reference to the
errata etc.

> Used the pm_runtime_put_sysc API to configure the
> musb to force idle/standby modes, saving the context and disable the clk in 
> while idling if there is no activity on the usb bus. 

Why?  This should not be part of the idle path.

If there is no activity on the bus, why hasn't the musb driver already
runtime suspended itself?

If the driver want's to runtime_suspend itself based on inactivity, it
should use an inactivity timer, not hook into the idle loop.   The
runtime PM API has a function for a deferred suspend

    int pm_schedule_suspend(struct device *dev, unsigned int delay)

The only thing in the idle loop in the current code is the errata fix,
and even that I'm not sure I'm ready to merge.

I'd really like to see even the errata fix out of the idle
path.   I wonder if usb-musb.c could create a periodic, deferrable timer
to fire that ensure that autoidle is disabled.

> Used the pm_runtime_get_sync API to configure the musb to
> no idle/standby modes, enable the clock and restore the context
> after wakeup when there is no activity on the usb bus.

Why would you wakeup MUSB in the idle path if there is no activity on
the bus?

I don't understand the motiviation or these last two changes, and they
are a departure from the behavior of the previous code.

At a minimum, they should be separated into a separate patch, and
thoroughly described, including an answer to "why?"

Kevin

> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c     |    1 
>  arch/arm/mach-omap2/pm34xx.c          |    3 
>  arch/arm/mach-omap2/usb-musb.c        |  107 ++++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/usb.h |    2 
>  drivers/usb/musb/musb_core.c          |   15 ++++
>  drivers/usb/musb/omap2430.c           |   14 ++++
>  include/linux/usb/musb.h              |    9 ++
>  7 files changed, 149 insertions(+), 2 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/cpuidle34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -31,6 +31,7 @@
>  #include <plat/clockdomain.h>
>  #include <plat/control.h>
>  #include <plat/serial.h>
> +#include <plat/usb.h>
>  
>  #include "pm.h"
>  
> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> @@ -38,6 +38,7 @@
>  #include <plat/prcm.h>
>  #include <plat/gpmc.h>
>  #include <plat/dma.h>
> +#include <plat/usb.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -324,11 +325,13 @@ static void restore_table_entry(void)
>  void omap3_device_idle(void)
>  {
>  	omap2_gpio_prepare_for_idle();
> +	musb_prepare_for_idle();
>  }
>  
>  void omap3_device_resume(void)
>  {
>  	omap2_gpio_resume_after_idle();
> +	musb_wakeup_from_idle();
>  }
>  
>  void omap_sram_idle(void)
> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> @@ -25,16 +25,21 @@
>  #include <linux/io.h>
>  
>  #include <linux/usb/musb.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
>  #include <plat/usb.h>
>  #include <plat/omap_device.h>
> +#include <plat/powerdomain.h>
>  
>  #ifdef CONFIG_USB_MUSB_SOC
>  static const char name[] = "musb_hdrc";
>  #define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
>  
> +struct omap_hwmod *oh_p;
> +static struct powerdomain *core_pwrdm;
> +
>  static struct musb_hdrc_config musb_config = {
>  	.multipoint	= 1,
>  	.dyn_fifo	= 1,
> @@ -58,6 +63,10 @@ static struct musb_hdrc_platform_data mu
>  	 * "mode", and should be passed to usb_musb_init().
>  	 */
>  	.power		= 50,			/* up to 100 mA */
> +
> +	/* OMAP supports offmode */
> +	.save_context	= 1,
> +	.restore_context	= 1,
>  };
>  
>  static u64 musb_dmamask = DMA_BIT_MASK(32);
> @@ -80,6 +89,7 @@ void __init usb_musb_init(struct omap_mu
>  	const char *oh_name = "usb_otg_hs";
>  	struct musb_hdrc_platform_data *pdata;
>  
> +	core_pwrdm = pwrdm_lookup("per_pwrdm");
>  	oh = omap_hwmod_lookup(oh_name);
>  
>  	if (!oh) {
> @@ -97,6 +107,7 @@ void __init usb_musb_init(struct omap_mu
>  	musb_plat.extvbus = board_data->extvbus;
>  
>  	pdata = &musb_plat;
> +	oh_p = oh;
>  
>  	od = omap_device_build(name, bus_id, oh, pdata,
>  			       sizeof(struct musb_hdrc_platform_data),
> @@ -115,8 +126,101 @@ void __init usb_musb_init(struct omap_mu
>  	put_device(dev);
>  }
>  
> +void musb_prepare_for_idle()
> +{
> +	int core_next_state;
> +	struct omap_hwmod *oh = oh_p;
> +	struct omap_device *od;
> +	struct platform_device *pdev;
> +	struct musb_hdrc_platform_data *pdata;
> +	struct device *dev;
> +
> +	if (!core_pwrdm)
> +		return;
> +
> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> +	if (core_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
> +	if (!oh)
> +		return;
> +
> +	od = oh->od;
> +	pdev = &od->pdev;
> +
> +	if (!pdev)
> +		return;
> +	dev = &pdev->dev;
> +
> +	if (dev->driver) {
> +		pdata = dev->platform_data;
> +
> +	if (pdata->is_usb_active)
> +		if (!pdata->is_usb_active(dev)) {
> +			if (core_next_state == PWRDM_POWER_OFF) {
> +				pdata->save_context = 1;
> +				pm_runtime_put_sync(dev);
> +			} else if  (core_next_state == PWRDM_POWER_RET) {
> +				pdata->save_context = 0;
> +				pm_runtime_put_sync(dev);
> +			}
> +		}
> +	}
> +}
> +
> +void musb_wakeup_from_idle()
> +{
> +	int core_next_state;
> +	int core_prev_state;
> +	struct omap_hwmod *oh = oh_p;
> +	struct omap_device *od;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	struct musb_hdrc_platform_data *pdata;
> +
> +	if (!core_pwrdm)
> +		return;
> +
> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> +
> +	if (core_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
> +	 core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
> +
> +	 if (!oh)
> +		return;
> +	 od = oh->od;
> +	 pdev = &od->pdev;
> +
> +	 if (!pdev)
> +		return;
> +
> +	 dev = &pdev->dev;
> +
> +	 if (dev->driver) {
> +		pdata = dev->platform_data;
> +
> +		if (pdata->is_usb_active)
> +			if (!pdata->is_usb_active(dev)) {
> +				if (core_prev_state == PWRDM_POWER_OFF) {
> +					pdata->restore_context = 1;
> +					 pm_runtime_get_sync(dev);
> +				} else {
> +					 pdata->restore_context = 0;
> +					 pm_runtime_get_sync(dev);
> +				}
> +			 }
> +	 }
> +}
>  #else
>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>  {
>  }
> +
> +void musb_prepare_for_idle()
> +{
> +}
> +
> +void musb_wakeup_from_idle()
> +{
> +}
>  #endif /* CONFIG_USB_MUSB_SOC */
> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h
> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
> @@ -79,6 +79,8 @@ extern void usb_ehci_init(const struct e
>  
>  extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
>  
> +extern void musb_prepare_for_idle(void);
> +extern void musb_wakeup_from_idle(void);
>  #endif
>  
>  
> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
> +++ linux-omap-pm/drivers/usb/musb/musb_core.c
> @@ -2410,6 +2410,7 @@ static int musb_suspend(struct device *d
>  	struct platform_device *pdev = to_platform_device(dev);
>  	unsigned long	flags;
>  	struct musb	*musb = dev_to_musb(&pdev->dev);
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  
>  	if (!musb->clock)
>  		return 0;
> @@ -2425,6 +2426,9 @@ static int musb_suspend(struct device *d
>  		 * they will even be wakeup-enabled.
>  		 */
>  	}
> +
> +	if (plat->save_context)
> +		plat->save_context = 1;
>  	pm_runtime_put_sync(dev);
>  
>  #ifndef CONFIG_PM_RUNTIME
> @@ -2443,10 +2447,13 @@ static int musb_resume_noirq(struct devi
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct musb	*musb = dev_to_musb(&pdev->dev);
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  
>  	if (!musb->clock)
>  		return 0;
>  
> +	if (plat->restore_context)
> +		plat->restore_context = 1;
>  	pm_runtime_get_sync(dev);
>  
>  #ifndef CONFIG_PM_RUNTIME
> @@ -2468,16 +2475,20 @@ static int musb_resume_noirq(struct devi
>  static int musb_runtime_suspend(struct device *dev)
>  {
>  	struct musb	*musb = dev_to_musb(dev);
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  
> -	musb_save_context(musb);
> +	if (plat->save_context)
> +		musb_save_context(musb);
>  	return 0;
>  }
>  
>  static int musb_runtime_resume(struct device *dev)
>  {
>  	struct musb	*musb = dev_to_musb(dev);
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  
> -	musb_restore_context(musb);
> +	if (plat->restore_context)
> +		musb_restore_context(musb);
>  	return 0;
>  }
>  static const struct dev_pm_ops musb_dev_pm_ops = {
> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c
> @@ -189,6 +189,19 @@ int musb_platform_set_mode(struct musb *
>  	return 0;
>  }
>  
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
> +
>  int __init musb_platform_init(struct musb *musb)
>  {
>  	u32 l;
> @@ -232,6 +245,7 @@ int __init musb_platform_init(struct mus
>  		musb->board_set_vbus = omap_set_vbus;
>  
>  	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
> +	plat->is_usb_active = is_musb_active;
>  
>  	return 0;
>  }
> Index: linux-omap-pm/include/linux/usb/musb.h
> ===================================================================
> --- linux-omap-pm.orig/include/linux/usb/musb.h
> +++ linux-omap-pm/include/linux/usb/musb.h
> @@ -93,6 +93,8 @@ struct musb_hdrc_config {
>  
>  };
>  
> +struct device;
> +
>  struct musb_hdrc_platform_data {
>  	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
>  	u8		mode;
> @@ -126,6 +128,17 @@ struct musb_hdrc_platform_data {
>  
>  	/* Architecture specific board data	*/
>  	void		*board_data;
> +
> +	/* check usb device active state*/
> +	int		(*is_usb_active)(struct device *dev);
> +
> +	/*
> +	 * Used for saving and restoring the registers only when core
> +	 * next state is off and previous state was off.
> +	 * Otherwise avoid save restore.
> +	 */
> +	int		save_context;
> +	int		restore_context;
>  };
>  
>  
