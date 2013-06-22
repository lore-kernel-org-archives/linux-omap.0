From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCHv2 2/2] ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION
 board.
Date: Sat, 22 Jun 2013 16:48:45 +0200
Message-ID: <51C5B94D.7080008@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34829 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3FVOst (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Jun 2013 10:48:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Florian Vaussard <florian.vaussard@epfl.ch>

On Thu, Jun 20, 2013 at 10:16 AM, Enric Balletbo i Serra <eballetbo@iseebcn.com>
wrote:
> The IGEP AQUILA EXPANSION board is a development platform for the IGEP COM
> AQUILA AM335x boards.
>
> The board adds the following connectivity:
>
>     o USB OTG
>     o USB HOST
>     o HDMI
>     o Ethernet
>     o Serial Debug (3.3V)
>     o 2x46 pin headers
>     o EEPROM
>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> ---
>  arch/arm/boot/dts/Makefile            |  1 +
>  arch/arm/boot/dts/am335x-base0033.dts | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8e50761..cb675d2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -154,6 +154,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>         am335x-evm.dtb \
>         am335x-evmsk.dtb \
>         am335x-bone.dtb \
> +       am335x-base0033.dtb \
>         am3517-evm.dtb \
>         am3517_mt_ventoux.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
> diff --git a/arch/arm/boot/dts/am335x-base0033.dts
b/arch/arm/boot/dts/am335x-base0033.dts
> new file mode 100644
> index 0000000..d6bb791
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-base0033.dts
> @@ -0,0 +1,16 @@
> +/*
> + * am335x-base0033.dtsi - Device Tree file for IGEP AQUILA EXPANSION
> + *
> + * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "am335x-igep0033.dtsi"
> +
> +/ {
> +       model = "IGEP COM AM335x on AQUILA Expansion";
> +       compatible = "ti,am335x-base0033", "ti,am335x-igep0033", "ti,am33xx";
> +};
> --
> 1.8.1.2
>

Hi Enric

Just small comment. I think it's better to make it compatible with
"isee,am335x-base0033", "isee,am335x-igep0033", "ti,am33xx" since these boards
are manufactured by ISEE and not by Texas Instrument.

I see that other boards such as the omap3-tobi.dts use the same convention that
you are using here and make it compatible with "ti,omap3-tobi",
"ti,omap3-overo", "ti,omap3" instead of something like "gumstix,omap3-tobi",
"gumstix,omap3-overo", "ti,omap3" that I think it would be better.

But maybe I'm just wrong and misunderstanding the convention on how to define
the compatible string for boards.

Anyway, the patch looks good to me now:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
