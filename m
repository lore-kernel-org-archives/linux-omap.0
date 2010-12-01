From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC v2 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Wed, 1 Dec 2010 11:34:22 +0530
Message-ID: <AANLkTi=q1HzYBpMH_pP+S5BtBQpHs62+zNfd_MtWHFuu@mail.gmail.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com> <1291147139-23472-2-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44344 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998Ab0LAGFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 01:05:04 -0500
In-Reply-To: <1291147139-23472-2-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>

David,

On Wed, Dec 1, 2010 at 01:28, David Sin <davidsin@ti.com> wrote:
> This patch adds support for DMM-PAT initialization and programming.
>
> Signed-off-by: David Sin <davidsin@ti.com>
> Signed-off-by: Lajos Molnar <molnar@ti.com>
> ---
> =A0arch/arm/mach-omap2/dmm-omap44xx.c =A0 =A0 | =A0 81 ++++++++++++++
> =A0arch/arm/mach-omap2/include/mach/dmm.h | =A0 92 ++++++++++++++++
> =A0drivers/misc/tiler/dmm-main.c =A0 =A0 =A0 =A0 =A0| =A0187 ++++++++=
++++++++++++++++++++++++
> =A03 files changed, 360 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/dmm-omap44xx.c
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/dmm.h
> =A0create mode 100644 drivers/misc/tiler/dmm-main.c
>
> diff --git a/arch/arm/mach-omap2/dmm-omap44xx.c b/arch/arm/mach-omap2=
/dmm-omap44xx.c
> new file mode 100644
> index 0000000..2919d8e
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmm-omap44xx.c
> @@ -0,0 +1,81 @@
> +/*
> + * DMM driver support functions for TI OMAP processors.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <mach/dmm.h>
> +#include <plat/omap_device.h>
> +#include <plat/omap_hwmod.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +
> +static struct dmm *plat_data;
> +static int pdata;
> +
> +#ifdef CONFIG_ARCH_OMAP4

Do not use these #ifdefs as it would not work as intended in multi-omap=
 build.
This driver is making use of omap_hwmod fw. Try to take advantage of hw=
mod_fw
and avoid these checks.

> +static struct dmm omap4_plat_data[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .oh_name =3D "dmm",

Do not use "oh_name" as it is confusing.

> + =A0 =A0 =A0 },
> +};
> +#define NUM_PDATA ARRAY_SIZE(omap4_plat_data)
> +#else
> +#define omap4_plat_data NULL
> +#define NUM_PDATA 0
> +#endif
> +
> +static struct omap_device_pm_latency omap_dmm_latency[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_h=
wmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =3D omap_device_enable_h=
wmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJ=
UST,
> + =A0 =A0 =A0 },
> +};
> +
> +static s32 __init dmm_omap_init(void)
> +{
> + =A0 =A0 =A0 struct omap_hwmod *oh =3D NULL;
> + =A0 =A0 =A0 struct omap_device *od =3D NULL;
> + =A0 =A0 =A0 struct omap_device_pm_latency *ohl =3D NULL;

Any specific reson for not assigning it directly to omap_dmm_latency?
I think this is redundant and omap_dmm_latency can be directly passed
to omap_device_build()

> + =A0 =A0 =A0 int ohlc =3D 0, i =3D 0;
> +
> + =A0 =A0 =A0 plat_data =3D omap4_plat_data;
> + =A0 =A0 =A0 pdata =3D NUM_PDATA;

name "pdata" is confusing. Also no need to iterate over the list of
devices using
NUM_PDATA. If you have multiple devices, make use of hwmod class.

> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dmm *data =3D &plat_data[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_hwmod_lookup(data->oh_name)

I do not find any other devices sharing same name for the device name
and oh->name.
Normally the device's name is preferred to be "omap_devname.id" to be
consistent across all drivers
and the oh->name is given as "devname(id)"

example: McSPI's device name could be "omap_mcspi" and it's hwmod name
could be "mcspi"

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->base =3D oh->_mpu_rt_va;

not required. Make use of platform_get APIs in probe to extract the
base, dma and irq info using pdev.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohl =3D omap_dmm_latency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohlc =3D ARRAY_SIZE(omap_dmm_latency);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 od =3D omap_device_build(data->oh_name,=
 i, oh, data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0sizeof(*data), ohl, ohlc, false);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(od))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +error:
> + =A0 =A0 =A0 return -ENODEV;

print the error message.

> +}
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("David Sin <davidsin@ti.com>");
> +MODULE_AUTHOR("Lajos Molnar <molnar@ti.com>");
> +device_initcall(dmm_omap_init);

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
