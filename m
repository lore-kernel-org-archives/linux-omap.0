From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/8] omap: zoom2: split baord file for reuse
Date: Tue, 3 Nov 2009 16:17:25 -0600
Message-ID: <4AF0ABF5.2030700@ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com> <1257283215-6448-2-git-send-email-vikram.pandita@ti.com> <1257283215-6448-3-git-send-email-vikram.pandita@ti.com> <1257283215-6448-4-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40998 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399AbZKCWRV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Nov 2009 17:17:21 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3MHQ5j029683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 16:17:26 -0600
In-Reply-To: <1257283215-6448-4-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vikram Pandita <vikram.pandtia@ti.com>


Pandita, Vikram had written, on 11/03/2009 03:20 PM, the following:
Please fix subject typo:
[PATCH 3/8] omap: zoom2: split baord file for reuse
				^^^^
				board
[...]
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> new file mode 100755
> index 0000000..c799eca
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
generic -> zoom Vs LDP.. Vs Zoom2 Vs Zoom3 naming conventions.. are we 
saying we dont care about LDP anymore? all zooms are zoom2 or zoom3?

[...]
> +
> +//static struct twl4030_gpio_platform_data zoom_gpio_data = {
> +//     .gpio_base              = OMAP_MAX_GPIO_LINES,
> +//     .irq_base               = TWL4030_GPIO_IRQ_BASE,
> +//     .irq_end                = TWL4030_GPIO_IRQ_END,
> +//     .pulldowns              = BIT(0) | BIT(1) | BIT(2) | BIT(3)
> +//                             | BIT(4) | BIT(5)
> +//                             | BIT(8) | BIT(9) | BIT(10) | BIT(11)
> +//                             | BIT(12) | BIT(13) | BIT(14) | BIT(15)
> +//                             | BIT(16) | BIT(17) ,
> +//     .setup                  = zoom_twlgpio_setup,
> +//};
NAK to //

> +static struct twl4030_gpio_platform_data zoom_gpio_data = {
> +       .gpio_base      = OMAP_MAX_GPIO_LINES,
> +       .irq_base       = TWL4030_GPIO_IRQ_BASE,
> +       .irq_end        = TWL4030_GPIO_IRQ_END,
> +       .setup          = zoom_twl_gpio_setup,
> +};
> +
> +static struct twl4030_usb_data zoom_usb_data = {
> +       .usb_mode               = T2_USB_MODE_ULPI,
> +};
> +
> +/* TODO: enable T2 scripts */
> +#if 0
NAK to #if 0 - introduce seperately if not operational.

[...]

> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> old mode 100644
> new mode 100755
> index 4ad9b94..abcc1ae
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -1,8 +1,6 @@
>  /*
>   * Copyright (C) 2009 Texas Instruments Inc.
> - * Mikkel Christensen <mlc@ti.com>
>   *
> - * Modified from mach-omap2/board-ldp.c
[Should we loose the history?]
[...]
> -static void __init omap_zoom2_init_irq(void)
> +static void __init omap_zoom_init_irq(void)
Question on naming.. as raised above.
[...]

-- 
Regards,
Nishanth Menon
