From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7] mfd: twl4030-power: Add generic reset configuration
Date: Tue, 20 May 2014 16:12:05 +0100
Message-ID: <20140520151205.GY24991@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56612 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaETPMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 11:12:10 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so595945iec.29
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 08:12:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400031250-29542-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>


> The twl4030 PMIC needs to be configured properly for things like
> warm reset and deeper idle states so the PMIC manages the regulators
> properly based on the hardware triggers from the SoC.
>=20
> For example, when rebooting an OMAP3530 at 125 MHz, it hangs.
> With this patch, TWL4030 will be reset when a warm reset occures.
> This way the OMAP3530 does not hang on reboot.
>=20
> Let's use this as the default when compatible =3D "ti,twl4030-power".
> Other more complicated configurations can be added to the driver
> based on other compatible flags.
>=20
> Based on earlier patch by Matthias Brugger <matthias.bgg@gmail.com>:
>=20
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/14=
4165.html
>=20
> And Lesly A M <leslyam@ti.com>:
>=20
> https://github.com/openembedded/openembedded/blob/master/recipes/linu=
x/linux-omap-2.6.39/mfd/0010-MFD-TWL4030-power-scripts-for-OMAP3-boards=
=2Epatch
>=20
> For more information about twl4030 configuration for the
> "power scripts" see:
>=20
> http://www.omappedia.com/wiki/TWL4030_power_scripts

Do you really want this bumph in the commit log?

> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt      |  7 +-
>  drivers/mfd/twl4030-power.c                        | 99 ++++++++++++=
+++++++---
>  include/linux/i2c/twl.h                            |  3 +
>  3 files changed, 95 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt =
b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> index 8e15ec3..b906116 100644
> --- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> +++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> @@ -5,7 +5,12 @@ to control the power resources, including power scri=
pts. For now, the
>  binding only supports the complete shutdown of the system after powe=
roff.
> =20
>  Required properties:
> -- compatible : must be "ti,twl4030-power"
> +- compatible : must be one of the following
> +	"ti,twl4030-power"
> +	"ti,twl4030-power-reset"
> +
> +The use of ti,twl4030-power-reset is recommended at least on
> +3530 that needs a special configuration for warm reset to work.
> =20
>  Optional properties:
>  - ti,use_poweroff: With this flag, the chip will initiates an ACTIVE=
-to-OFF or
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index c0e4fc3..b61b725 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -29,6 +29,7 @@
>  #include <linux/i2c/twl.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> =20
>  #include <asm/mach-types.h>
> =20
> @@ -128,6 +129,30 @@ static u8 res_config_addrs[] =3D {
>  	[RES_MAIN_REF]	=3D 0x94,
>  };
> =20
> +/*
> + * Usable values for .remap_sleep and .remap_off
> + * Based on table "5.3.3 Resource Operating modes"
> + */
> +enum {
> +	TWL_REMAP_OFF =3D 0,
> +	TWL_REMAP_SLEEP =3D 8,
> +	TWL_REMAP_ACTIVE =3D 9,
> +};
> +
> +#define TWL_RESOURCE_ON(res)						\
> +	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_ACTIVE), 0x02 }

Was ist das? Magic, floating, fluffy numbers.

> +#define TWL_RESOURCE_OFF(res)						\
> +	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_OFF), 0x02 }
> +#define TWL_RESOURCE_RESET(res)						\
> +	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_WRST), 0x02 }
> +#define TWL_RESOURCE_GROUP_RESET(group, type1, type2)			\
> +	{ MSG_BROADCAST(DEV_GRP_NULL, (group), (type1), (type2),	\
> +		RES_STATE_WRST), 0x02 }
> +#define TWL_REMAP_SLEEP(res, devgrp, typ, typ2)				\
> +	{ .resource =3D (res), .devgroup =3D (devgrp),			\
> +	  .type =3D (typ), .type2 =3D (typ2),				\
> +	  .remap_off =3D TWL_REMAP_OFF, .remap_sleep =3D TWL_REMAP_SLEEP, }
> +
>  static int twl4030_write_script_byte(u8 address, u8 byte)
>  {
>  	int err;
> @@ -502,7 +527,8 @@ int twl4030_remove_script(u8 flags)
>  	return err;
>  }
> =20
> -static int twl4030_power_configure_scripts(struct twl4030_power_data=
 *pdata)
> +static int
> +twl4030_power_configure_scripts(const struct twl4030_power_data *pda=
ta)

Is this doing anything besides some sneaky clean-up?  If not, it
might be worth mentioning that you're taking advantage of these
changes to conduct such activities.

>  {
>  	int err;
>  	int i;
> @@ -518,7 +544,8 @@ static int twl4030_power_configure_scripts(struct=
 twl4030_power_data *pdata)
>  	return 0;
>  }
> =20
> -static int twl4030_power_configure_resources(struct twl4030_power_da=
ta *pdata)
> +static int
> +twl4030_power_configure_resources(const struct twl4030_power_data *p=
data)

Ditto.

>  {
>  	struct twl4030_resconfig *resconfig =3D pdata->resource_config;
>  	int err;
> @@ -550,7 +577,7 @@ void twl4030_power_off(void)
>  		pr_err("TWL4030 Unable to power off\n");
>  }
> =20
> -static bool twl4030_power_use_poweroff(struct twl4030_power_data *pd=
ata,
> +static bool twl4030_power_use_poweroff(const struct twl4030_power_da=
ta *pdata,
>  					struct device_node *node)

Etc.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
