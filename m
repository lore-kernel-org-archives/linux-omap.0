From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2 v2] pwm_bl: Add mandatory backlight enable regulator
Date: Wed, 13 Mar 2013 09:56:57 +0100
Message-ID: <51403F59.2090303@ti.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com> <1363126934-8754-3-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36718 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719Ab3CMI5D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 04:57:03 -0400
In-Reply-To: <1363126934-8754-3-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, linux-omap@vger.kernel.org

On 03/12/2013 11:22 PM, Andrew Chew wrote:
> Many backlights need to be explicitly enabled.  Typically, this is do=
ne
> with a GPIO.  For flexibility, we generalize the enable mechanism to =
a
> regulator.
>=20
> If an enable regulator is not needed, then a dummy regulator can be g=
iven
> to the backlight driver.  If a GPIO is used to enable the backlight,
> then a fixed regulator can be instantiated to control the GPIO.
>=20
> The backlight enable regulator can be specified in the device tree no=
de
> for the backlight, or can be done with legacy board setup code in the
> usual way.
>=20
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  .../bindings/video/backlight/pwm-backlight.txt     |   14 +++++
>  drivers/video/backlight/pwm_bl.c                   |   55 ++++++++++=
++++++----
>  2 files changed, 59 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-ba=
cklight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-bac=
klight.txt
> index 1e4fc72..7e2e089 100644
> --- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight=
=2Etxt
> +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight=
=2Etxt
> @@ -10,6 +10,11 @@ Required properties:
>        last value in the array represents a 100% duty cycle (brightes=
t).
>    - default-brightness-level: the default brightness level (index in=
to the
>        array defined by the "brightness-levels" property)
> +  - enable-supply: A phandle to the regulator device tree node. This
> +      regulator will be turned on and off as the pwm is enabled and =
disabled.
> +      Many backlights are enabled via a GPIO. In this case, we insta=
ntiate
> +      a fixed regulator and give that to enable-supply. If a regulat=
or
> +      is not needed, then provide a dummy fixed regulator.
> =20
>  Optional properties:
>    - pwm-names: a list of names for the PWM devices specified in the
> @@ -19,10 +24,19 @@ Optional properties:
> =20
>  Example:
> =20
> +	bl_en: fixed-regulator {
> +                compatible =3D "regulator-fixed";
> +                regulator-name =3D "bl-en-supply";
> +                regulator-boot-on;
> +                gpio =3D <&some_gpio>;
> +                enable-active-high;
> +	};
> +
>  	backlight {
>  		compatible =3D "pwm-backlight";
>  		pwms =3D <&pwm 0 5000000>;
> =20
>  		brightness-levels =3D <0 4 8 16 32 64 128 255>;
>  		default-brightness-level =3D <6>;
> +		enable-supply =3D <&bl_en>;
>  	};
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index 1fea627..c557c51 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -20,10 +20,13 @@
>  #include <linux/pwm.h>
>  #include <linux/pwm_backlight.h>
>  #include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
> =20
>  struct pwm_bl_data {
>  	struct pwm_device	*pwm;
>  	struct device		*dev;
> +	bool			enabled;
> +	struct regulator	*enable_supply;
>  	unsigned int		period;
>  	unsigned int		lth_brightness;
>  	unsigned int		*levels;
> @@ -35,6 +38,38 @@ struct pwm_bl_data {
>  	void			(*exit)(struct device *);
>  };
> =20
> +static void pwm_backlight_enable(struct backlight_device *bl)
> +{
> +	struct pwm_bl_data *pb =3D dev_get_drvdata(&bl->dev);
> +
> +	/* Bail if we are already enabled. */
> +	if (pb->enabled)
> +		return;
> +
> +	pwm_enable(pb->pwm);
> +
> +	if (regulator_enable(pb->enable_supply) !=3D 0)

I would loose the '!=3D 0'

> +		dev_warn(&bl->dev, "Failed to enable regulator");
> +
> +	pb->enabled =3D true;
> +}
> +
> +static void pwm_backlight_disable(struct backlight_device *bl)
> +{
> +	struct pwm_bl_data *pb =3D dev_get_drvdata(&bl->dev);
> +
> +	/* Bail if we are already disabled. */
> +	if (!pb->enabled)
> +		return;
> +
> +	if (regulator_disable(pb->enable_supply) !=3D 0)
> +		dev_warn(&bl->dev, "Failed to disable regulator");
> +
> +	pwm_disable(pb->pwm);
> +
> +	pb->enabled =3D false;
> +}

Would it not be better to have some locking here since the code started=
 to use
flag for state tracking?

> +
>  static int pwm_backlight_update_status(struct backlight_device *bl)
>  {
>  	struct pwm_bl_data *pb =3D bl_get_data(bl);
> @@ -51,7 +86,7 @@ static int pwm_backlight_update_status(struct backl=
ight_device *bl)
> =20
>  	if (brightness =3D=3D 0) {
>  		pwm_config(pb->pwm, 0, pb->period);
> -		pwm_disable(pb->pwm);
> +		pwm_backlight_disable(bl);
>  	} else {
>  		int duty_cycle;
> =20
> @@ -65,7 +100,7 @@ static int pwm_backlight_update_status(struct back=
light_device *bl)
>  		duty_cycle =3D pb->lth_brightness +
>  		     (duty_cycle * (pb->period - pb->lth_brightness) / max);
>  		pwm_config(pb->pwm, duty_cycle, pb->period);
> -		pwm_enable(pb->pwm);
> +		pwm_backlight_enable(bl);
>  	}
> =20
>  	if (pb->notify_after)
> @@ -138,12 +173,6 @@ static int pwm_backlight_parse_dt(struct device =
*dev,
>  		data->max_brightness--;
>  	}
> =20
> -	/*
> -	 * TODO: Most users of this driver use a number of GPIOs to control
> -	 *       backlight power. Support for specifying these needs to be
> -	 *       added.
> -	 */
> -
>  	return 0;
>  }
> =20
> @@ -206,6 +235,12 @@ static int pwm_backlight_probe(struct platform_d=
evice *pdev)
>  	pb->exit =3D data->exit;
>  	pb->dev =3D &pdev->dev;
> =20
> +	pb->enable_supply =3D devm_regulator_get(&pdev->dev, "enable");
> +	if (IS_ERR(pb->enable_supply)) {
> +		ret =3D PTR_ERR(pb->enable_supply);
> +		goto err_alloc;
> +	}
> +
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> @@ -268,7 +303,7 @@ static int pwm_backlight_remove(struct platform_d=
evice *pdev)
> =20
>  	backlight_device_unregister(bl);
>  	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> +	pwm_backlight_disable(bl);
>  	if (pb->exit)
>  		pb->exit(&pdev->dev);
>  	return 0;
> @@ -283,7 +318,7 @@ static int pwm_backlight_suspend(struct device *d=
ev)
>  	if (pb->notify)
>  		pb->notify(pb->dev, 0);
>  	pwm_config(pb->pwm, 0, pb->period);
> -	pwm_disable(pb->pwm);
> +	pwm_backlight_disable(bl);
>  	if (pb->notify_after)
>  		pb->notify_after(pb->dev, 0);
>  	return 0;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
