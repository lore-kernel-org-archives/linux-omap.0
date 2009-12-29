From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Tue, 29 Dec 2009 10:29:22 +0200
Message-ID: <87d41yxjx9.fsf@purkki.valot.fi>
References: <200912290152.16357.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752667AbZL2I32@vger.kernel.org>
In-Reply-To: <200912290152.16357.luke@dashjr.org> (Luke-Jr's message of "Tue\, 29 Dec 2009 01\:52\:04 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

"Luke-Jr" <luke@dashjr.org> writes:

> Add platform data and initialization for USB on Nokia N800 and N810 devices
> via the TUSB6010 chipset.

Excellent, thank you for doing this.

> Tested on Nokia N810 in Linux-OMAP tree. Mainline is not bootable yet.

What's the problem in mainline? I haven't tested n8x0 for months :(

> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -117,6 +117,11 @@ config MACH_NOKIA_N8X0
>  	select MACH_NOKIA_N810
>  	select MACH_NOKIA_N810_WIMAX
>  
> +config MACH_NOKIA_N8X0_USB
> +	bool
> +	depends on MACH_NOKIA_N8X0 && MACH_OMAP2_TUSB6010
> +	default y
> +

Is is really needed to add new kconfig variable? Can't we just use
MACH_OMAP2_TUSB6010 in code?

> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-n8x0-usb.c

I think a separate file is not needed, it's not that much code. I
recommend to just adding it directly to board-n8x0.c. It's simple and
easier for everyone.

> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -109,8 +109,16 @@ static void __init n8x0_init_irq(void)
>  	omap_gpio_init();
>  }
>  
> +#ifdef CONFIG_MACH_NOKIA_N8X0_LCD
> +extern void n8x0_usb_init(void);
> +#else
> +static inline void n8x0_usb_init (void) {}
> +#endif

CONFIG_MACH_NOKIA_N8X0_LCD does not look right here.

-- 
Kalle Valo
