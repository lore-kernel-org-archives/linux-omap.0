From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 6/7] pwm: pwm-omap-dmtimer: Adapt driver to utilize
 dmtimer pdata ops
Date: Thu, 9 Nov 2017 17:28:31 +0100
Message-ID: <20171109162831.djbvafalrz5xl24v@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnthuerpmtbaqlen"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-7-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--vnthuerpmtbaqlen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:27PM +0530, Keerthy wrote:
> Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/pwm/pwm-omap-dmtimer.c | 39 ++++++++++++++++++++++--------------=
---
>  1 file changed, 22 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtime=
r.c
> index 5ad42f3..3b27aff 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -23,6 +23,7 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_data/dmtimer-omap.h>
>  #include <linux/platform_data/pwm_omap_dmtimer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -37,7 +38,7 @@ struct pwm_omap_dmtimer_chip {
>  	struct pwm_chip chip;
>  	struct mutex mutex;
>  	pwm_omap_dmtimer *dm_timer;
> -	struct pwm_omap_dmtimer_pdata *pdata;
> +	struct omap_dm_timer_ops *pdata;
>  	struct platform_device *dm_timer_pdev;
>  };
> =20
> @@ -242,19 +243,33 @@ static int pwm_omap_dmtimer_probe(struct platform_d=
evice *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct device_node *timer;
> +	struct platform_device *timer_pdev;
>  	struct pwm_omap_dmtimer_chip *omap;
> -	struct pwm_omap_dmtimer_pdata *pdata;
> +	struct dmtimer_platform_data *timer_pdata;
> +	struct omap_dm_timer_ops *pdata;
>  	pwm_omap_dmtimer *dm_timer;
>  	u32 v;
>  	int status;
> =20
> -	pdata =3D dev_get_platdata(&pdev->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "Missing dmtimer platform data\n");
> +	timer =3D of_parse_phandle(np, "ti,timers", 0);
> +	if (!timer)
> +		return -ENODEV;
> +
> +	timer_pdev =3D of_find_device_by_node(timer);
> +	if (!timer_pdev) {
> +		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
> +		return -ENODEV;
> +	}
> +
> +	timer_pdata =3D dev_get_platdata(&timer_pdev->dev);
> +	if (!timer_pdata) {
> +		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
>  		return -EINVAL;
>  	}
> =20
> -	if (!pdata->request_by_node ||
> +	pdata =3D timer_pdata->timer_ops;
> +
> +	if (!pdata || !pdata->request_by_node ||
>  	    !pdata->free ||
>  	    !pdata->enable ||
>  	    !pdata->disable ||
> @@ -270,10 +285,6 @@ static int pwm_omap_dmtimer_probe(struct platform_de=
vice *pdev)
>  		return -EINVAL;
>  	}
> =20
> -	timer =3D of_parse_phandle(np, "ti,timers", 0);
> -	if (!timer)
> -		return -ENODEV;
> -
>  	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
>  		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
>  		return -ENODEV;
> @@ -291,13 +302,7 @@ static int pwm_omap_dmtimer_probe(struct platform_de=
vice *pdev)
> =20
>  	omap->pdata =3D pdata;
>  	omap->dm_timer =3D dm_timer;
> -
> -	omap->dm_timer_pdev =3D of_find_device_by_node(timer);
> -	if (!omap->dm_timer_pdev) {
> -		dev_err(&pdev->dev, "Unable to find timer pdev\n");
> -		omap->pdata->free(dm_timer);
> -		return -EINVAL;
> -	}
> +	omap->dm_timer_pdev =3D timer_pdev;
> =20
>  	/*
>  	 * Ensure that the timer is stopped before we allow PWM core to call
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--vnthuerpmtbaqlen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEgi8ACgkQ2O7X88g7
+przlQ/+LFFRcpOGnj2yC6+zdsvFNMR0f75n3F3uahAr13V0ew3wzERp/ovZqJiv
d0TOSp1UOP7QbZstunngRXimBnE8MF02OBSwleQWCf9NWo3Gh0m2u8kRIdrB3ugw
rAn409rm94WLVBVK3RA1+o0F62i8sGXu6ID5dffZUfD53/ykDbA6e4om1mQ9IvYw
SVkIDTOrip5T5iokZ6Kpu6QkqHWnEA7P9h6OnFq+Sy+pTlMZSIhETFpLdYVwmV34
0NMbbP5u4hQ+Y+hhlWA56LgaK9Ahj4UIqfWC9OsvGOG9J/oaeEoiWKt+ZhkI9wS+
9MgVU+H6quO2dfc4L8X/cmiNrfLtup/XESfkwBQXzcWrbFxUeXyI4vNaQRKMJGg4
Z13nDg22RicinCTENqNyjYMWKzYuzqDxKygKNBSO+Zkasn8FWppBaY1TYZ6Fy9jD
Et7mmxZQ9059u3727CuZaW66ZIaE2L2j9OCkiEwbE9ka+ywNynk4V4YuUkN7lN8P
f8nZgUXXq0XUfwVYvahQ6znqYHiyKPvdQ/MNjWG8UsCnkp0K2Ql9crqoY5QyCqvj
qPtFiq/R6+y0lZC/Z6U9FiBUElhXt4JR789BrSCyeVsIbUny71xq2y0xFwmqA54j
SIR3PUAjR2IErIgJh9tRCq8KbE08yJ8Bde/W7bekyNPoCpxUMB4=
=tUZD
-----END PGP SIGNATURE-----

--vnthuerpmtbaqlen--
