From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/15] twl4030_charger: use runtime_pm to keep usb phy
 active while charging.
Date: Wed, 25 Feb 2015 07:24:43 +0000
Message-ID: <20150225072443.GG21323@x1>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043350.4243.51289.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043350.4243.51289.stgit@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 24 Feb 2015, NeilBrown wrote:

> The twl4030 usb phy needs to be active while we are using
> the USB VBUS as a current source for charging.
> In particular, the usb3v1 regulator must be enabled and the
> PHY_PWR_PHYPWD bit must be set to keep the phy powered.
>=20
> commit ab37813f4093a5f59cb8e083cde277289dc72ed3
>     twl4030_charger: Allow charger to control the regulator that feed=
s it
>=20
> Gave the charger control over the regulator, but didn't resolve
> the PHY_PWR_PHYPWD issue.
>=20
> Now that both of these are controlled by runtime_pm in
> phy-twl4030-usb, we can simply take a runtime_pm reference to the USB
> phy whenever the charger wants to use it as a current source.
>=20
> So this patch reverts the above commit, and adds the necessary
> runtime_pm calls.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/mfd/twl-core.c          |    9 ++++-----

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/power/twl4030_charger.c |   18 +++++-------------
>  2 files changed, 9 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 489674a2497e..831696ee2472 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -788,9 +788,8 @@ add_children(struct twl4030_platform_data *pdata,=
 unsigned irq_base,
>  		static struct regulator_consumer_supply usb1v8 =3D {
>  			.supply =3D	"usb1v8",
>  		};
> -		static struct regulator_consumer_supply usb3v1[] =3D {
> -			{ .supply =3D	"usb3v1" },
> -			{ .supply =3D	"bci3v1" },
> +		static struct regulator_consumer_supply usb3v1 =3D {
> +			.supply =3D	"usb3v1",
>  		};
> =20
>  	/* First add the regulators so that they can be used by transceiver=
 */
> @@ -818,7 +817,7 @@ add_children(struct twl4030_platform_data *pdata,=
 unsigned irq_base,
>  				return PTR_ERR(child);
> =20
>  			child =3D add_regulator_linked(TWL4030_REG_VUSB3V1,
> -						      &usb_fixed, usb3v1, 2,
> +						      &usb_fixed, &usb3v1, 1,
>  						      features);
>  			if (IS_ERR(child))
>  				return PTR_ERR(child);
> @@ -838,7 +837,7 @@ add_children(struct twl4030_platform_data *pdata,=
 unsigned irq_base,
>  		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && child) {
>  			usb1v5.dev_name =3D dev_name(child);
>  			usb1v8.dev_name =3D dev_name(child);
> -			usb3v1[0].dev_name =3D dev_name(child);
> +			usb3v1.dev_name =3D dev_name(child);
>  		}
>  	}
> =20
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index 51321f0c5548..11f352a5ef55 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -22,7 +22,6 @@
>  #include <linux/power_supply.h>
>  #include <linux/notifier.h>
>  #include <linux/usb/otg.h>
> -#include <linux/regulator/machine.h>
> =20
>  #define TWL4030_BCIMSTATEC	0x02
>  #define TWL4030_BCIICHG		0x08
> @@ -94,7 +93,6 @@ struct twl4030_bci {
>  	struct work_struct	work;
>  	int			irq_chg;
>  	int			irq_bci;
> -	struct regulator	*usb_reg;
>  	int			usb_enabled;
> =20
>  	unsigned long		event;
> @@ -208,7 +206,7 @@ static int twl4030_charger_enable_usb(struct twl4=
030_bci *bci, bool enable)
>  {
>  	int ret;
> =20
> -	if (enable) {
> +	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
>  		/* Check for USB charger connected */
>  		if (!twl4030_bci_have_vbus(bci))
>  			return -ENODEV;
> @@ -222,14 +220,9 @@ static int twl4030_charger_enable_usb(struct twl=
4030_bci *bci, bool enable)
>  			return -EACCES;
>  		}
> =20
> -		/* Need to keep regulator on */
> +		/* Need to keep phy powered */
>  		if (!bci->usb_enabled) {
> -			ret =3D regulator_enable(bci->usb_reg);
> -			if (ret) {
> -				dev_err(bci->dev,
> -					"Failed to enable regulator\n");
> -				return ret;
> -			}
> +			pm_runtime_get_sync(bci->transceiver->dev);
>  			bci->usb_enabled =3D 1;
>  		}
> =20
> @@ -244,7 +237,8 @@ static int twl4030_charger_enable_usb(struct twl4=
030_bci *bci, bool enable)
>  	} else {
>  		ret =3D twl4030_clear_set_boot_bci(TWL4030_BCIAUTOUSB, 0);
>  		if (bci->usb_enabled) {
> -			regulator_disable(bci->usb_reg);
> +			pm_runtime_mark_last_busy(bci->transceiver->dev);
> +			pm_runtime_put_autosuspend(bci->transceiver->dev);
>  			bci->usb_enabled =3D 0;
>  		}
>  	}
> @@ -602,8 +596,6 @@ static int __init twl4030_bci_probe(struct platfo=
rm_device *pdev)
>  	bci->usb.num_properties =3D ARRAY_SIZE(twl4030_charger_props);
>  	bci->usb.get_property =3D twl4030_bci_get_property;
> =20
> -	bci->usb_reg =3D regulator_get(bci->dev, "bci3v1");
> -
>  	ret =3D devm_power_supply_register(&pdev->dev, &bci->usb);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register usb: %d\n", ret);
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
