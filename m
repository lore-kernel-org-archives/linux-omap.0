From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
Date: Sun, 11 Nov 2018 01:06:43 +0100
Message-ID: <20181111000643.rjtdi3htgoeibswi@earth.universe>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xlew7iglpbbgajfk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org


--xlew7iglpbbgajfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 10, 2018 at 08:10:58PM +0200, Andy Shevchenko wrote:
> All current users of extcon_get_extcon_dev() API considers
> an extcon device a mandatory to appear. Thus, they all convert
> NULL pointer to -EPROBE_DEFER error code.
>=20
> There is one more caller anticipated with the same requirements.
>=20
> To decrease a code duplication and a burden to the callers,
> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/extcon/extcon-axp288.c        | 4 ++--
>  drivers/extcon/extcon.c               | 2 +-
>  drivers/power/supply/axp288_charger.c | 8 ++++----
>  drivers/usb/phy/phy-omap-otg.c        | 6 +++---
>  drivers/usb/typec/tcpm/fusb302.c      | 4 ++--
>  5 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp28=
8.c
> index a983708b77a6..3472d3b756ed 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -360,8 +360,8 @@ static int axp288_extcon_probe(struct platform_device=
 *pdev)
>  		name =3D acpi_dev_get_first_match_name("INT3496", NULL, -1);
>  		if (name) {
>  			info->id_extcon =3D extcon_get_extcon_dev(name);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
> =20
>  			dev_info(dev, "controlling USB role\n");
>  		} else {
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 5ab0498be652..2bd0f2f33f05 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -884,7 +884,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *=
extcon_name)
>  		if (!strcmp(sd->name, extcon_name))
>  			goto out;
>  	}
> -	sd =3D NULL;
> +	sd =3D ERR_PTR(-EPROBE_DEFER);
>  out:
>  	mutex_unlock(&extcon_dev_list_lock);
>  	return sd;
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index 735658ee1c60..8558577fccf5 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -768,17 +768,17 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	info->regmap_irqc =3D axp20x->regmap_irqc;
> =20
>  	info->cable.edev =3D extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev =3D=3D NULL) {
> +	if (IS_ERR(info->cable.edev)) {
>  		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
>  			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +		return PTR_ERR(info->cable.edev);
>  	}
> =20
>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>  		info->otg.cable =3D extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable =3D=3D NULL) {
> +		if (IS_ERR(info->otg.cable)) {
>  			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +			return PTR_ERR(info->otg.cable);
>  		}
>  		dev_info(&pdev->dev,
>  			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-ot=
g.c
> index ee0863c6553e..605314ddcd3d 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -91,12 +91,12 @@ static int omap_otg_probe(struct platform_device *pde=
v)
>  	int ret;
>  	u32 rev;
> =20
> -	if (!config || !config->extcon)
> +	if (!config)
>  		return -ENODEV;
> =20
>  	extcon =3D extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
> =20
>  	otg_dev =3D devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fu=
sb302.c
> index 43b64d9309d0..6d332066202b 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1767,8 +1767,8 @@ static int fusb302_probe(struct i2c_client *client,
>  	 */
>  	if (device_property_read_string(dev, "fcs,extcon-name", &name) =3D=3D 0=
) {
>  		chip->extcon =3D extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>  	}
> =20
>  	chip->vbus =3D devm_regulator_get(chip->dev, "vbus");
> --=20
> 2.19.1
>=20

--xlew7iglpbbgajfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvncpAACgkQ2O7X88g7
+pq4oQ//VIu95qNb3TGyNQskz3SvpYJBfrRG9WEfjzEXJUy+y+mrwNnbJNtWAR/X
pQH9If/WwcV5Hbeb8kaWPbZYaHUbo+0z1HJOQ0c9peJa8TUB8RfOLilXBuoLn56T
B0DaJM8KmFOrv5xCMjeo/l98O5/GTRpBXA5zJigaF6ZZfFHHlH2o4dBLHQnaIibT
zJFlaV0puJAlhU9sdPEEa7T9+yhQ5skg17NTgQg151QkkKaz/6p3m+1NGgvopHoD
/GeEP8kR54lIIVYpoq5RHidQYc2mbygts1a7aPZYdEpWKsB036eL/cm1+ZCV58iP
MH3Iqw3Ye2YBMQcKn9PR1yStcSW5jnZ7jAyRgrqzVtWZA2atcaT+BCz9JDGrEXgs
Fj7Kxguo7Kez3aEWRBsDHMB8Gzb/cd4ZI4BjH1x2dcPWaWa3RNhBcZUDcMC25a/+
wTwulM6q1Fi6nWD5cG7rJ1y60FKWfALraqWnXhCwyWfiaTcdmAQhTiOFa6HPrJSZ
oEn7jASxBLSC/LdQz5Y1eoXU30Un1iaDnJY94VYYO1LHDu2lXEMKEev+NRWPml4j
RbukgCrx325rwOJdlpB9BSnxLTt8qKxN+c19H1Qq4FQ9lHPFeEz+r2XbCzLibpUL
P3LxET/y/SWgXFLoQAML7sAxDPfhOwUJTuM+VjE+JrItU2oBhTU=
=QVr3
-----END PGP SIGNATURE-----

--xlew7iglpbbgajfk--
