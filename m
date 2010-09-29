From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/3 v4] musb: add musb support for AM35x
Date: Wed, 29 Sep 2010 21:26:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404A9D8ABA3@dbde02.ent.ti.com>
References: <1285764321-13934-1-git-send-email-ajay.gupta@ti.com>
 <1285764321-13934-2-git-send-email-ajay.gupta@ti.com>
 <4CA35C3B.3000002@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CA35C3B.3000002-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> >
> > +config USB_MUSB_AM35X
> > +	boolean "AM35X MUSB support"
> > +	depends on USB_MUSB_HDRC && MACH_OMAP3517EVM
> 
>     As I've already said, depending on the board type won't scale... :-(

..and to scale it up we need to add "select USB_MUSB_AM35X" in
arch/arm/mach-omap2/Kconfig for all the boards having AM35x. 

Felipe, what's your opinion on this?

 
> 
> > +	select NOP_USB_XCEIV
> > +	default y
> > +	help
> > +	  Select this option if your platform is based on AM35x. As
> > +	  AM35x has an updated MUSB with CPPI4.1 DMA so this config
> > +	  is introduced to differentiate musb ip between OMAP3x and
> > +	  AM35x platforms.
> 
>     OK, but why it's made visible?

Hmm, can be made hidden.

> 
> > diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> > new file mode 100644
> > index 0000000..ee0c104
> > --- /dev/null
> > +++ b/drivers/usb/musb/am35x.c
> > @@ -0,0 +1,510 @@
> > +/*
> > + * Texas Instruments AM35x "glue layer"
> > + *
> > + * Copyright (c) 2010, by Texas Instruments
> > + *
> > + * Based on the DA8xx "glue layer" code.
> > + * Copyright (C) 2005-2006 by Texas Instruments
> 
>     There's no code by TI in the DA8xx layer -- that copyright comes from
> the
> DaVinci code.
Yes, it's from DaVinci. 

> 
> > + * Copyright (c) 2008, MontaVista Software, Inc. <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> 
>     I've extended it to 2008-2009 (and should have to 2010 :-).
no issue, I will update it.

> 
> > +/* USB interrupt register bits */
> > +#define USB_INTR_USB_SHIFT	16
> > +#define USB_INTR_USB_MASK	(0x1ff << USB_INTR_USB_SHIFT)
> 
>     Don't seem like good names (USB_ repeated twice)...
Ok, will try to get a better name in next version :)

> 
> [...]
> 
> > +int __init musb_platform_init(struct musb *musb, void *board_data)
> > +{
> > +	void __iomem *reg_base = musb->ctrl_base;
> > +	struct clk *otg_fck;
> > +	u32 rev, lvl_intr, sw_reset;
> > +	int status;
> > +
> > +	musb->mregs += USB_MENTOR_CORE_OFFSET;
> > +
> > +	if (musb->set_clock)
> > +		musb->set_clock(musb->clock, 1);
> 
>     OMAP doesn't use plat->set_clock anymore, does it?

Yes it doesn't anymore so can be removed.

> 
> > +	else
> > +		clk_enable(musb->clock);
> > +	DBG(2, "usbotg_ck=%lud\n", clk_get_rate(musb->clock));
> > +
> > +	otg_fck = clk_get(musb->controller, "fck");
> > +	if (IS_ERR(otg_fck)) {
> > +		status = PTR_ERR(otg_fck);
> > +		otg_fck = NULL;
> 
>     This assignment does not seem necessary.
Yes.

> 
> > +		goto exit0;
> > +	}
> [...]
> > +exit1:
> > +	clk_disable(otg_fck);
> > +exit0:
> > +	clk_disable(musb->clock);
> > +	return status;
> > +}
> > +
> > +int musb_platform_exit(struct musb *musb)
> > +{
> > +	struct clk *otg_fck;
> > +
> > +	if (is_host_enabled(musb))
> > +		del_timer_sync(&otg_workaround);
> > +
> > +	phy_off();
> > +
> > +	otg_put_transceiver(musb->xceiv);
> > +	usb_nop_xceiv_unregister();
> > +
> > +	if (musb->set_clock)
> > +		musb->set_clock(musb->clock, 0);
> 
>     Looks like it may be dropped...
> 
> > +	else
> > +		clk_disable(musb->clock);
> > +
> > +	otg_fck = clk_get(musb->controller, "fck");
> 
>     Isn't it better to store this in some static variable? I don't think
> there's
> or there'll be multiple instances of MUSB on AM35x...

AM35x has only one instance but future coming platform does have
two musb interfaces and so we would face this issue. I think it's
better to add another entry in "struct musb" itself.

Felipe, any comment?

Thanks,
Ajay

> 
> > +	if (IS_ERR(otg_fck)) {
> > +		DBG(2, "clk_get() failed for otg_fck.\n");
> > +	} else {
> > +		clk_put(otg_fck);
> > +		clk_put(otg_fck);
> > +		clk_disable(otg_fck);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
