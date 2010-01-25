From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCH] usb: musb: support for OFF-mode
Date: Mon, 25 Jan 2010 12:16:51 +0200
Message-ID: <1264414611.3890.23.camel@kauppi-desktop>
References: <1264149739-21223-1-git-send-email-ext-arnaud.2.mandy@nokia.com>
	 <1264149739-21223-2-git-send-email-ext-arnaud.2.mandy@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22381 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab0AYKRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jan 2010 05:17:42 -0500
In-Reply-To: <1264149739-21223-2-git-send-email-ext-arnaud.2.mandy@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mandy Arnaud.2 (EXT-Teleca/Helsinki)" <ext-arnaud.2.mandy@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>

On Fri, 2010-01-22 at 09:42 +0100, Mandy Arnaud.2 (EXT-Teleca/Helsinki)
wrote:

Hi,

> using a wrapper between the transceiver driver and the controller
> driver to signal the controller driver to turn on/off the controller
> when VBUS event is detected.

I think there is one register mismatch, please see below.

> based-on: Heikki Krogerus <ext-heikki.krogerus@nokia.com>
> Signed-off-by: Arnaud Mandy <ext-arnaud.2.mandy@nokia.com>
> ---
>  drivers/usb/musb/musb_core.c  |   30 +++++++++++++++++-
>  drivers/usb/musb/musb_core.h  |   17 +++++++++-
>  drivers/usb/musb/omap2430.c   |   66 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/usb/otg/otg.c         |   16 ++++++++++
>  drivers/usb/otg/twl4030-usb.c |    2 +
>  include/linux/usb/otg.h       |   11 +++++++
>  6 files changed, 137 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2f59892..ab97a02 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -965,6 +965,8 @@ void musb_start(struct musb *musb)
>  	}
>  	musb_platform_enable(musb);
>  	musb_writeb(regs, MUSB_DEVCTL, devctl);
> +
> +	musb_save_context(musb);
>  }
>  
> 
> @@ -1948,6 +1950,25 @@ static void musb_free(struct musb *musb)
>  #endif
>  }
>  
> +int musb_power_controller(struct otg_controller *controller, bool vbus)
> +{
> +	struct musb *musb = dev_to_musb(controller->dev);
> +
> +	if (!musb->off_mode_support)
> +		return 0;
> +
> +	if (vbus)
> +		musb_power_on_controller(musb);
> +	else
> +		musb_power_off_controller(musb);
> +
> +	return 0;
> +}
> +
> +struct otg_controller musb_controller = {
> +	.power_controller = musb_power_controller,
> +};
> +
>  /*
>   * Perform generic per-controller initialization.
>   *
> @@ -2044,6 +2065,9 @@ bad_config:
>  		goto fail2;
>  	}
>  
> +	musb_controller.dev = dev;
> +	musb->xceiv->controller = &musb_controller;
> +
>  #ifndef CONFIG_MUSB_PIO_ONLY
>  	if (use_dma && dev->dma_mask) {
>  		struct dma_controller	*c;
> @@ -2313,7 +2337,8 @@ void musb_save_context(struct musb *musb)
>  
>  	musb_writeb(musb_base, MUSB_INDEX, musb_context.index);
>  
> -	musb_platform_save_context(musb, &musb_context);
> +	if (!musb->off_mode)
> +		musb_platform_save_context(musb, &musb_context);
>  }
>  
>  void musb_restore_context(struct musb *musb)
> @@ -2322,7 +2347,8 @@ void musb_restore_context(struct musb *musb)
>  	void __iomem *musb_base = musb->mregs;
>  	void __iomem *ep_target_regs;
>  
> -	musb_platform_restore_context(musb, &musb_context);
> +	if (!musb->off_mode)
> +		musb_platform_restore_context(musb, &musb_context);
>  
>  	if (is_host_enabled(musb)) {
>  		musb_writew(musb_base, MUSB_FRAME, musb_context.frame);
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 1e3da4e..8105a47 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -448,6 +448,11 @@ struct musb {
>  	struct usb_gadget	g;			/* the gadget */
>  	struct usb_gadget_driver *gadget_driver;	/* its driver */
>  #endif
> +	/* true if off-mode is supported */
> +	unsigned		off_mode_support:1;
> +
> +	/* true if off-mode is requested */
> +	unsigned                off_mode:1;
>  
>  	/* true if we're using dma */
>  	unsigned		use_dma:1;
> @@ -498,8 +503,16 @@ extern void musb_platform_restore_context(struct musb *musb,
>  #define musb_platform_save_context(m, x)	do {} while (0)
>  #define musb_platform_restore_context(m, x)	do {} while (0)
>  #endif
> -
> -#endif
> +extern void musb_power_on_controller(struct musb *musb);
> +extern void musb_power_off_controller(struct musb *musb);
> +void musb_save_context(struct musb *musb);
> +void musb_restore_context(struct musb *musb);
> +#else
> +static inline void musb_power_on_controller(struct musb *musb) {};
> +static inline void musb_power_off_controller(struct musb *musb) {};
> +static inline void musb_save_context(struct musb *musb) {};
> +static inline void musb_restore_context(struct musb *musb) {};
> +#endif /* CONFIG_PM */
>  
>  static inline void musb_set_vbus(struct musb *musb, int is_on)
>  {
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 21cff53..3cc894b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -220,6 +220,9 @@ int __init musb_platform_init(struct musb *musb)
>  
>  	musb_platform_resume(musb);
>  
> +#ifdef CONFIG_PM
> +	musb->off_mode_support = 1;
> +#endif
>  	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>  	l &= ~ENABLEWAKEUP;	/* disable wakeup */
>  	l &= ~NOSTDBY;		/* remove possible nostdby */
> @@ -271,7 +274,68 @@ void musb_platform_restore_context(struct musb *musb,
>  	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context->otg_sysconfig);
>  	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context->otg_forcestandby);
>  }
> -#endif
> +
> +void musb_power_off_controller(struct musb *musb)
> +{
> +	u32 l;
> +
> +	DBG(3, "allow OFF-mode\n");
> +
> +	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
> +	l |= ENABLEFORCE;	/* enable MSTANDBY */
> +	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
> +
> +	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
> +	l |= ENABLEWAKEUP;	/* enable wakeup */
> +	l &= ~NOSTDBY;		/* disable nostdby */
> +	l |= SMARTSTDBY;	/* enable smart standby */
> +
> +	l |= AUTOIDLE;		/* enable auto idle */
> +	l &= ~NOIDLE;		/* disable noidle */
> +	l |= SMARTIDLE;		/* enable smart idle */
> +
> +	musb_writel(musb->mregs, OTG_SYSCONFIG, l);

Here you read from OTG_FORCESTDBY, tweak bits and write to
OTG_SYSCONFIG? I guess the read should be from OTG_SYSCONFIG?

> +
> +	if (!cpu_is_omap3430())
> +		l |= AUTOIDLE;		/* enable auto idle */
> +	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
> +}
> +EXPORT_SYMBOL_GPL(musb_power_off_controller);
> +
> +void musb_power_on_controller(struct musb *musb)
> +{
> +	u32 l;
> +
> +	DBG(3, "wake-up from OFF-mode\n");
> +
> +	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
> +	l &= ~ENABLEWAKEUP;	/* disable wakeup */
> +	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
> +
> +	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
> +	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
> +	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
> +
> +	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
> +	l |= NOSTDBY;		/* enable nostdby */
> +	l &= ~SMARTSTDBY;	/* disable smart standby */
> +
> +	l &= ~AUTOIDLE;		/* disable auto idle */
> +	l |= NOIDLE;		/* enable noidle */
> +	l &= ~SMARTIDLE;	/* disable smart idle */
> +	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
> +
> +	l = musb_readl(musb->mregs, OTG_INTERFSEL);
> +	l |= ULPI_12PIN;
> +	musb_writel(musb->mregs, OTG_INTERFSEL, l);
> +
> +	/* Restore register context */
> +	musb->off_mode = 1;
> +	musb_restore_context(musb);
> +	musb->off_mode = 0;
> +}
> +EXPORT_SYMBOL_GPL(musb_power_on_controller);
> +#endif /* CONFIG_PM */
>  
>  int musb_platform_suspend(struct musb *musb)
>  {
> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
> index 0a43a7d..8ab45a7 100644
> --- a/drivers/usb/otg/otg.c
> +++ b/drivers/usb/otg/otg.c
> @@ -64,3 +64,19 @@ int otg_set_transceiver(struct otg_transceiver *x)
>  	return 0;
>  }
>  EXPORT_SYMBOL(otg_set_transceiver);
> +
> +/**
> + * otg_power_controller - control power on/off of tranceiver.
> + * @x: the USB OTG transceiver to be used; or NULL
> + * @vbus: VBUS presence.
> + * This call is to save and power off the usb controller based on
> + * VBUS level detected by the transceiver.
> + */
> +int otg_power_controller(struct otg_transceiver *x, bool vbus)
> +{
> +	if (x->controller && x->controller->power_controller)
> +		x->controller->power_controller(x->controller, vbus);
> +	return 0;
> +}
> +EXPORT_SYMBOL(otg_power_controller);
> +
> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> index 488b0a3..3aa84ea 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -503,6 +503,7 @@ static void twl4030_phy_suspend(struct twl4030_usb *twl, int controller_off)
>  
>  	twl4030_phy_power(twl, 0);
>  	twl->asleep = 1;
> +	otg_power_controller(&twl->otg, 0);
>  }
>  
>  static void twl4030_phy_resume(struct twl4030_usb *twl)
> @@ -516,6 +517,7 @@ static void twl4030_phy_resume(struct twl4030_usb *twl)
>  	if (twl->usb_mode == T2_USB_MODE_ULPI)
>  		twl4030_i2c_access(twl, 0);
>  	twl->asleep = 0;
> +	otg_power_controller(&twl->otg, 1);
>  }
>  
>  static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index e328a89..77c4bdc 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -60,6 +60,14 @@ struct otg_io_access_ops {
>  	int (*write)(struct otg_transceiver *otg, u32 val, u32 reg);
>  };
>  
> +/* the otg driver needs to inform the usb controller driver when vbus
> + * is present or not.
> + */
> +struct otg_controller {
> +	struct device *dev;
> +	int (*power_controller)(struct otg_controller *otg, bool vbus);
> +};
> +
>  /*
>   * the otg driver needs to interact with both device side and host side
>   * usb controllers.  it decides which controller is active at a given
> @@ -93,6 +101,8 @@ struct otg_transceiver {
>  	u16			port_status;
>  	u16			port_change;
>  
> +	struct otg_controller   *controller;
> +
>  	/* initialize/shutdown the OTG controller */
>  	int	(*init)(struct otg_transceiver *otg);
>  	void	(*shutdown)(struct otg_transceiver *otg);
> @@ -171,6 +181,7 @@ otg_shutdown(struct otg_transceiver *otg)
>  /* for usb host and peripheral controller drivers */
>  extern struct otg_transceiver *otg_get_transceiver(void);
>  extern void otg_put_transceiver(struct otg_transceiver *);
> +extern int otg_power_controller(struct otg_transceiver *, bool);
>  
>  /* Context: can sleep */
>  static inline int

--
Ari

