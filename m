From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/7] mfd: menelaus: delete platform data support
Date: Tue, 20 Jan 2015 13:54:39 +0000
Message-ID: <20150120135439.GN13701@x1>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-6-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:47657 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbATNzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 08:55:09 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so7979191iec.7
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2015 05:55:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419702779-16001-6-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 27 Dec 2014, Aaro Koskinen wrote:

> Delete platform data support.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap2/common-board-devices.h |  2 --
>  drivers/mfd/menelaus.c                     | 10 +---------
>  include/linux/mfd/menelaus.h               |  6 ------
>  3 files changed, 1 insertion(+), 17 deletions(-)

Applied, thanks.

> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/ma=
ch-omap2/common-board-devices.h
> index 07c88ae..7a30228 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -2,7 +2,6 @@
>  #define __OMAP_COMMON_BOARD_DEVICES__
> =20
>  #include <sound/tlv320aic3x.h>
> -#include <linux/mfd/menelaus.h>
>  #include "twl-common.h"
> =20
>  #define NAND_BLOCK_SIZE	SZ_128K
> @@ -14,7 +13,6 @@ void omap_ads7846_init(int bus_num, int gpio_pendow=
n, int gpio_debounce,
>  		       struct ads7846_platform_data *board_pdata);
>  void *n8x0_legacy_init(void);
> =20
> -extern struct menelaus_platform_data n8x0_menelaus_platform_data;
>  extern struct aic3x_pdata n810_aic33_data;
> =20
>  #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 3e04c64..4a900cc 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1181,8 +1181,6 @@ static int menelaus_probe(struct i2c_client *cl=
ient,
>  	int			rev =3D 0;
>  	int			err =3D 0;
>  	struct device_node	*np =3D client->dev.of_node;
> -	struct menelaus_platform_data *menelaus_pdata =3D
> -					dev_get_platdata(&client->dev);
> =20
>  	if (the_menelaus) {
>  		dev_dbg(&client->dev, "only one %s for now\n",
> @@ -1240,13 +1238,7 @@ static int menelaus_probe(struct i2c_client *c=
lient,
>  	else
>  		menelaus->vcore_hw_mode =3D 0;
> =20
> -	if (menelaus_pdata !=3D NULL) {
> -		if (menelaus_pdata->late_init !=3D NULL) {
> -			err =3D menelaus_pdata->late_init(&client->dev);
> -			if (err < 0)
> -				goto fail;
> -		}
> -	} else if (np) {
> +	if (np) {
>  		u32 vcore_min;
>  		u32 vcore_max;
> =20
> diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelau=
s.h
> index 9e85ac0..21eeff5 100644
> --- a/include/linux/mfd/menelaus.h
> +++ b/include/linux/mfd/menelaus.h
> @@ -5,12 +5,6 @@
>  #ifndef __ASM_ARCH_MENELAUS_H
>  #define __ASM_ARCH_MENELAUS_H
> =20
> -struct device;
> -
> -struct menelaus_platform_data {
> -	int (* late_init)(struct device *dev);
> -};
> -
>  extern int menelaus_register_mmc_callback(void (*callback)(void *dat=
a, u8 card_mask),
>  					  void *data);
>  extern void menelaus_unregister_mmc_callback(void);

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
