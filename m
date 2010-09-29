From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3 v4] musb: add musb support for AM35x
Date: Wed, 29 Sep 2010 19:33:15 +0400
Message-ID: <4CA35C3B.3000002@ru.mvista.com>
References: <1285764321-13934-1-git-send-email-ajay.gupta@ti.com> <1285764321-13934-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285764321-13934-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> AM35x has musb interface and uses CPPI4.1 DMA engine.
> Current patch supports only PIO mode. DMA support can be
> added later once basic CPPI4.1 DMA patch is accepted.

> Also added USB_MUSB_AM35X which is required to differentiate musb ips
> between OMAP3x and AM35x. This config would be used to for below
> purposes,
>         - Select am35x.c instead of omap2430.c for compilation
>           at drivers/usb/musb directory. Please note there are
>           significant differneces in these two files as musb ip
>           in quite different on AM35x.
>         - Select workaround codes applicable for AM35x musb issues.
>           one such workaround is for bytewise read issue on AM35x.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

[...]

> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 1dd21c2..0941a32 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -60,6 +60,17 @@ comment "OMAP 44xx high speed USB support"
>  comment "Blackfin high speed USB Support"
>  	depends on USB_MUSB_HDRC && ((BF54x && !BF544) || (BF52x && !BF522 && !BF523))
>  
> +config USB_MUSB_AM35X
> +	boolean "AM35X MUSB support"
> +	depends on USB_MUSB_HDRC && MACH_OMAP3517EVM

    As I've already said, depending on the board type won't scale... :-(

> +	select NOP_USB_XCEIV
> +	default y
> +	help
> +	  Select this option if your platform is based on AM35x. As
> +	  AM35x has an updated MUSB with CPPI4.1 DMA so this config
> +	  is introduced to differentiate musb ip between OMAP3x and
> +	  AM35x platforms.

    OK, but why it's made visible?

> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> new file mode 100644
> index 0000000..ee0c104
> --- /dev/null
> +++ b/drivers/usb/musb/am35x.c
> @@ -0,0 +1,510 @@
> +/*
> + * Texas Instruments AM35x "glue layer"
> + *
> + * Copyright (c) 2010, by Texas Instruments
> + *
> + * Based on the DA8xx "glue layer" code.
> + * Copyright (C) 2005-2006 by Texas Instruments

    There's no code by TI in the DA8xx layer -- that copyright comes from the 
DaVinci code.

> + * Copyright (c) 2008, MontaVista Software, Inc. <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>

    I've extended it to 2008-2009 (and should have to 2010 :-).

> +/* USB interrupt register bits */
> +#define USB_INTR_USB_SHIFT	16
> +#define USB_INTR_USB_MASK	(0x1ff << USB_INTR_USB_SHIFT)

    Don't seem like good names (USB_ repeated twice)...

[...]

> +int __init musb_platform_init(struct musb *musb, void *board_data)
> +{
> +	void __iomem *reg_base = musb->ctrl_base;
> +	struct clk *otg_fck;
> +	u32 rev, lvl_intr, sw_reset;
> +	int status;
> +
> +	musb->mregs += USB_MENTOR_CORE_OFFSET;
> +
> +	if (musb->set_clock)
> +		musb->set_clock(musb->clock, 1);

    OMAP doesn't use plat->set_clock anymore, does it?

> +	else
> +		clk_enable(musb->clock);
> +	DBG(2, "usbotg_ck=%lud\n", clk_get_rate(musb->clock));
> +
> +	otg_fck = clk_get(musb->controller, "fck");
> +	if (IS_ERR(otg_fck)) {
> +		status = PTR_ERR(otg_fck);
> +		otg_fck = NULL;

    This assignment does not seem necessary.

> +		goto exit0;
> +	}
[...]
> +exit1:
> +	clk_disable(otg_fck);
> +exit0:
> +	clk_disable(musb->clock);
> +	return status;
> +}
> +
> +int musb_platform_exit(struct musb *musb)
> +{
> +	struct clk *otg_fck;
> +
> +	if (is_host_enabled(musb))
> +		del_timer_sync(&otg_workaround);
> +
> +	phy_off();
> +
> +	otg_put_transceiver(musb->xceiv);
> +	usb_nop_xceiv_unregister();
> +
> +	if (musb->set_clock)
> +		musb->set_clock(musb->clock, 0);

    Looks like it may be dropped...

> +	else
> +		clk_disable(musb->clock);
> +
> +	otg_fck = clk_get(musb->controller, "fck");

    Isn't it better to store this in some static variable? I don't think there's 
or there'll be multiple instances of MUSB on AM35x...

> +	if (IS_ERR(otg_fck)) {
> +		DBG(2, "clk_get() failed for otg_fck.\n");
> +	} else {
> +		clk_put(otg_fck);
> +		clk_put(otg_fck);
> +		clk_disable(otg_fck);
> +	}
> +
> +	return 0;
> +}

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
