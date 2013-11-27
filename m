From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: Clean up module by removing twl603x pdata
 handling
Date: Wed, 27 Nov 2013 12:19:08 +0000
Message-ID: <20131127121908.GE3296@lee--X1>
References: <1385036008-1727-1-git-send-email-ruslan.ruslichenko@globallogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:61726 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab3K0MTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 07:19:14 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so5010275yha.31
        for <linux-omap@vger.kernel.org>; Wed, 27 Nov 2013 04:19:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385036008-1727-1-git-send-email-ruslan.ruslichenko@globallogic.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Ruslichenko <ruslan.ruslichenko@globallogic.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, 21 Nov 2013, Ruslan Ruslichenko wrote:

> Since currently nobody uses TWL603x platform data and all new

Hmm... when you say nobody, how did you come to this conclusion?

Without digging into it and probably not that relevant, it
appears there is some references to it in platform data still:

$ git grep twl603 -- arch/ | grep -v dts
arch/arm/mach-omap2/common.h:extern int omap4_twl6030_hsmmc_init(struct=
 omap2_hsmmc_info *controllers);
arch/arm/mach-omap2/omap4-common.c:static int omap4_twl6030_hsmmc_late_=
init(struct device *dev)
arch/arm/mach-omap2/omap4-common.c:		irq =3D twl6030_mmc_card_detect_co=
nfig();
arch/arm/mach-omap2/omap4-common.c:		pdata->slots[0].card_detect =3D tw=
l6030_mmc_card_detect;
arch/arm/mach-omap2/omap4-common.c:static __init void omap4_twl6030_hsm=
mc_set_late_init(struct device *dev)
arch/arm/mach-omap2/omap4-common.c:	pdata->init =3D	omap4_twl6030_hsmmc=
_late_init;
arch/arm/mach-omap2/omap4-common.c:int __init omap4_twl6030_hsmmc_init(=
struct omap2_hsmmc_info *controllers)
arch/arm/mach-omap2/omap4-common.c:		omap4_twl6030_hsmmc_set_late_init(=
&c->pdev->dev);
arch/arm/mach-omap2/omap4-common.c:int __init omap4_twl6030_hsmmc_init(=
struct omap2_hsmmc_info *controllers)
arch/arm/mach-omap2/omap_twl.c:static unsigned long twl6030_vsel_to_uv(=
const u8 vsel)
arch/arm/mach-omap2/omap_twl.c:static u8 twl6030_uv_to_vsel(unsigned lo=
ng uv)
arch/arm/mach-omap2/omap_twl.c:	if (uv > twl6030_vsel_to_uv(0x39)) {
arch/arm/mach-omap2/omap_twl.c:			__func__, uv, twl6030_vsel_to_uv(0x39=
));
arch/arm/mach-omap2/omap_twl.c:	.vsel_to_uv		=3D twl6030_vsel_to_uv,
arch/arm/mach-omap2/omap_twl.c:	.uv_to_vsel		=3D twl6030_uv_to_vsel,
arch/arm/mach-omap2/omap_twl.c:	.vsel_to_uv		=3D twl6030_vsel_to_uv,
arch/arm/mach-omap2/omap_twl.c:	.uv_to_vsel		=3D twl6030_uv_to_vsel,
arch/arm/mach-omap2/omap_twl.c:	.vsel_to_uv		=3D twl6030_vsel_to_uv,
arch/arm/mach-omap2/omap_twl.c:	.uv_to_vsel		=3D twl6030_uv_to_vsel,

> users will supply it through device tree, handling of these
> data within twl-core will never be used, so remove it.
>=20
> Signed-off-by: Ruslan Ruslichenko <ruslan.ruslichenko@globallogic.com=
>
> ---
>=20
> Tested on TI SDP/Tablet OMAP4460 board
> Based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit 5e01dc7 Linux 3.12
>=20
>  drivers/mfd/twl-core.c | 198 ---------------------------------------=
----------
>  1 file changed, 198 deletions(-)
>=20
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 29473c2..c3c28b9 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -701,62 +701,6 @@ add_children(struct twl4030_platform_data *pdata=
, unsigned irq_base,
>  			usb3v1[0].dev_name =3D dev_name(child);
>  		}
>  	}
> -	if (IS_ENABLED(CONFIG_TWL6030_USB) && pdata->usb &&
> -	    twl_class_is_6030()) {
> -
> -		static struct regulator_consumer_supply usb3v3;
> -		int regulator;
> -
> -		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030)) {
> -			/* this is a template that gets copied */
> -			struct regulator_init_data usb_fixed =3D {
> -				.constraints.valid_modes_mask =3D
> -					REGULATOR_MODE_NORMAL
> -					| REGULATOR_MODE_STANDBY,
> -				.constraints.valid_ops_mask =3D
> -					REGULATOR_CHANGE_MODE
> -					| REGULATOR_CHANGE_STATUS,
> -			};
> -
> -			if (features & TWL6032_SUBCLASS) {
> -				usb3v3.supply =3D	"ldousb";
> -				regulator =3D TWL6032_REG_LDOUSB;
> -			} else {
> -				usb3v3.supply =3D "vusb";
> -				regulator =3D TWL6030_REG_VUSB;
> -			}
> -			child =3D add_regulator_linked(regulator, &usb_fixed,
> -							&usb3v3, 1,
> -							features);
> -			if (IS_ERR(child))
> -				return PTR_ERR(child);
> -		}
> -
> -		pdata->usb->features =3D features;
> -
> -		child =3D add_child(TWL_MODULE_USB, "twl6030_usb",
> -			pdata->usb, sizeof(*pdata->usb), true,
> -			/* irq1 =3D VBUS_PRES, irq0 =3D USB ID */
> -			irq_base + USBOTG_INTR_OFFSET,
> -			irq_base + USB_PRES_INTR_OFFSET);
> -
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -		/* we need to connect regulators to this transceiver */
> -		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && child)
> -			usb3v3.dev_name =3D dev_name(child);
> -	} else if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) &&
> -		   twl_class_is_6030()) {
> -		if (features & TWL6032_SUBCLASS)
> -			child =3D add_regulator(TWL6032_REG_LDOUSB,
> -						pdata->ldousb, features);
> -		else
> -			child =3D add_regulator(TWL6030_REG_VUSB,
> -						pdata->vusb, features);
> -
> -			if (IS_ERR(child))
> -					return PTR_ERR(child);
> -	}
> =20
>  	if (IS_ENABLED(CONFIG_TWL4030_WATCHDOG) && twl_class_is_4030()) {
>  		child =3D add_child(TWL_MODULE_PM_RECEIVER, "twl4030_wdt", NULL,
> @@ -870,148 +814,6 @@ add_children(struct twl4030_platform_data *pdat=
a, unsigned irq_base,
>  			return PTR_ERR(child);
>  	}
> =20
> -	/* twl6030 regulators */
> -	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && twl_class_is_6030() &&
> -			!(features & TWL6032_SUBCLASS)) {
> -		child =3D add_regulator(TWL6030_REG_VDD1, pdata->vdd1,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VDD2, pdata->vdd2,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VDD3, pdata->vdd3,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_V1V8, pdata->v1v8,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_V2V1, pdata->v2v1,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VPP, pdata->vpp,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VUSIM, pdata->vusim,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VCXIO, pdata->vcxio,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VDAC, pdata->vdac,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VAUX1_6030, pdata->vaux1,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VAUX2_6030, pdata->vaux2,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_VAUX3_6030, pdata->vaux3,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6030_REG_CLK32KG, pdata->clk32kg,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -	}
> -
> -	/* 6030 and 6025 share this regulator */
> -	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && twl_class_is_6030()) {
> -		child =3D add_regulator(TWL6030_REG_VANA, pdata->vana,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -	}
> -
> -	/* twl6032 regulators */
> -	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && twl_class_is_6030() &&
> -			(features & TWL6032_SUBCLASS)) {
> -		child =3D add_regulator(TWL6032_REG_LDO5, pdata->ldo5,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDO1, pdata->ldo1,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDO7, pdata->ldo7,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDO6, pdata->ldo6,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDOLN, pdata->ldoln,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDO2, pdata->ldo2,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDO4, pdata->ldo4,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_LDO3, pdata->ldo3,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_SMPS3, pdata->smps3,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_SMPS4, pdata->smps4,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -		child =3D add_regulator(TWL6032_REG_VIO, pdata->vio6025,
> -					features);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
> -
> -	}
> -
>  	if (IS_ENABLED(CONFIG_CHARGER_TWL4030) && pdata->bci &&
>  			!(features & (TPS_SUBSET | TWL5031))) {
>  		child =3D add_child(TWL_MODULE_MAIN_CHARGE, "twl4030_bci",

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
