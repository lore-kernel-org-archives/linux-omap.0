From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 05/12] omap1: Add 7xx clocks and pin muxes for SPI
Date: Thu, 7 Jan 2010 11:46:23 +0200
Message-ID: <6ed0b2681001070146x4dbf52d9h406d128ccea826cf@mail.gmail.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
	 <20100107001934.21352.83656.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:51979 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab0AGJqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 04:46:24 -0500
Received: by fg-out-1718.google.com with SMTP id 19so7414484fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 07 Jan 2010 01:46:23 -0800 (PST)
In-Reply-To: <20100107001934.21352.83656.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

<snip>

> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devi=
ces.c
> index 23ded2d..17ebb47 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -14,6 +14,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/io.h>
> +#include <linux/spi/spi.h>
>
> =A0#include <mach/hardware.h>
> =A0#include <asm/mach/map.h>
> @@ -23,6 +24,7 @@
> =A0#include <plat/mux.h>
> =A0#include <mach/gpio.h>
> =A0#include <plat/mmc.h>
> +#include <plat/omap7xx.h>
>
> =A0/*----------------------------------------------------------------=
---------*/
>
> @@ -196,6 +198,38 @@ void __init omap1_init_mmc(struct omap_mmc_platf=
orm_data **mmc_data,
>
> =A0/*----------------------------------------------------------------=
---------*/
>
> +/* OMAP7xx SPI support */
> +#if defined(CONFIG_SPI_OMAP_100K) || defined(CONFIG_SPI_OMAP_100K_MO=
DULE)
> +
> +struct platform_device omap_spi1 =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap1_spi100k",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> +};
> +
> +struct platform_device omap_spi2 =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap1_spi100k",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 2,
> +};
> +
> +static void omap_init_spi100k(void)
> +{
> + =A0 =A0 =A0 omap_spi1.dev.platform_data =3D ioremap(OMAP7XX_SPI1_BA=
SE, 0x7ff);
> + =A0 =A0 =A0 if (omap_spi1.dev.platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_register(&omap_spi1);
> +
> + =A0 =A0 =A0 omap_spi2.dev.platform_data =3D ioremap(OMAP7XX_SPI2_BA=
SE, 0x7ff);
> + =A0 =A0 =A0 ifi (omap_spi2.dev.platform_data)

a typo here?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_register(&omap_spi2);
> +}
> +
> +#else
> +static inline void omap_init_spi100k(void)
> +{
> +}
> +#endif
> +
> +/*------------------------------------------------------------------=
-------*/
> +
> =A0#if defined(CONFIG_OMAP_STI)
>
> =A0#define OMAP1_STI_BASE =A0 =A0 =A0 =A0 0xfffea000
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
