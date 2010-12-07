From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v8 04/11] OMAP7xx: GPIO: Introduce support for GPIO init
Date: Mon, 6 Dec 2010 21:20:24 -0800
Message-ID: <AANLkTi=jjqj8Gv5tWqfMnndM037U-Qidtp=ju3VmhQyF@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com> <1290689318-10191-5-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55648 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0LGFUq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:20:46 -0500
Received: by wwa36 with SMTP id 36so13718732wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:20:45 -0800 (PST)
In-Reply-To: <1290689318-10191-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> Add support for handling OMAP7xx specific gpio_init by
> providing platform device data and doing device registration.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
> =C2=A0arch/arm/mach-omap1/gpio7xx.c | =C2=A0261 +++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 261 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/arm/mach-omap1/gpio7xx.c
>
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio=
7xx.c
> new file mode 100644
> index 0000000..94bccd4
> --- /dev/null
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -0,0 +1,261 @@
> +/*
> + * OMAP7xx specific gpio init
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * Author:
> + * =C2=A0 =C2=A0 Charulatha V <charu@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/gpio.h>
> +
> +#define OMAP7XX_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbc000
> +#define OMAP7XX_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbc800
> +#define OMAP7XX_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbd000
> +#define OMAP7XX_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbd800
> +#define OMAP7XX_GPIO5_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbe000
> +#define OMAP7XX_GPIO6_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbe800
> +#define OMAP1_MPUIO_VBASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0OMAP1_MPUIO_BASE
> +
> +/* mpu gpio */
> +static struct __initdata resource omap7xx_mpu_gpio_resources[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0=3D O=
MAP1_MPUIO_VBASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0=
=3D OMAP1_MPUIO_VBASE + SZ_2K - 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D I=
ORESOURCE_MEM,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0=3D I=
NT_7XX_MPUIO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D I=
ORESOURCE_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_co=
nfig =3D {
> + =C2=A0 =C2=A0 =C2=A0 .virtual_irq_start =C2=A0 =C2=A0 =C2=A0=3D IH_=
MPUIO_BASE,
> + =C2=A0 =C2=A0 =C2=A0 .bank_type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D METHOD_MPUIO,
> + =C2=A0 =C2=A0 =C2=A0 .bank_width =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D 32,

I think we need

    .dbck_flag =3D false,

here -- we don't have a dbclk on omap7xx.  Without this, we get:

    omap_gpio omap_gpio.5: Could not get gpio dbck
    omap_gpio omap_gpio.6: Could not get gpio dbck

This needs to be added to the other 5 GPIO blocks in this file as well.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
