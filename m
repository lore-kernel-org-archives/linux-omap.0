From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: MUSB regression in 2.6.31-rc6
Date: Sat, 15 Aug 2009 20:19:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
References: <20090815174352.c2883585.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090815174352.c2883585.jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Hi
> 
> BeagleBoard stopped booting at 2.6.31-rc6 and it turned out that this
> commit broke it:
> 
> commit e8e2ff462dd92693f29eb848f42d3eb720390d59
> Author: Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Date:   Wed Jul 29 11:58:57 2009 +0530
> 
>     USB: musb: fix the nop registration for OMAP3EVM
> 
> While this is easy to fix for the Beagle with a patch below, I don't know
> how many other OMAP boards there are which should be fixed as well.
> Or would it be better to revert the patch itself for 2.6.31?
> 
> 
> --
> Jarkko
> 
> ---
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 991ac9c..2ca0d44 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -30,6 +30,7 @@
> 
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/usb/otg.h>
> 
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -406,6 +407,10 @@ static void __init omap3_beagle_init(void)
>         /* REVISIT leave DVI powered down until it's needed ... */
>         gpio_direction_output(170, true);
> 
> +#ifdef CONFIG_NOP_USB_XCEIV
> +       /* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
> +       usb_nop_xceiv_register();
> +#endif
>         usb_musb_init();
>         omap3beagle_flash_init();
>  }
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 803adcb..e27ed96 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -13,6 +13,7 @@ config USB_MUSB_HDRC
>         select NOP_USB_XCEIV if ARCH_DAVINCI
>         select TWL4030_USB if MACH_OMAP_3430SDP
>         select NOP_USB_XCEIV if MACH_OMAP3EVM
> +       select NOP_USB_XCEIV if MACH_OMAP3_BEAGLE

Shouldn't we be selecting TWL4030_USB if MACH_OMAP3_BEAGLE.
The beagleboard does use the PHY in the TWL4030, and not
a transparent PHY.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
