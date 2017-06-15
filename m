From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: cpcap-charger: Add missing
 power_supply_config
Date: Thu, 15 Jun 2017 14:55:18 +0200
Message-ID: <20170615125518.xesqz6a2qwjtal7x@earth>
References: <20170615044108.26707-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fh5tfmqzfinl3wiw"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170615044108.26707-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--fh5tfmqzfinl3wiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 14, 2017 at 09:41:08PM -0700, Tony Lindgren wrote:
> Otherwise cpcap-battery won't probe properly with the power-supplies
> property configured but will fail with "Not all required supplies found,
> defer probe".
>=20
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/cpcap-charger.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -637,6 +637,7 @@ static int cpcap_charger_probe(struct platform_device=
 *pdev)
>  {
>  	struct cpcap_charger_ddata *ddata;
>  	const struct of_device_id *of_id;
> +	struct power_supply_config psy_cfg =3D {};
>  	int error;
> =20
>  	of_id =3D of_match_device(of_match_ptr(cpcap_charger_id_table),
> @@ -665,9 +666,12 @@ static int cpcap_charger_probe(struct platform_devic=
e *pdev)
> =20
>  	atomic_set(&ddata->active, 1);
> =20
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D ddata;
> +
>  	ddata->usb =3D devm_power_supply_register(ddata->dev,
>  						&cpcap_charger_usb_desc,
> -						NULL);
> +						&psy_cfg);
>  	if (IS_ERR(ddata->usb)) {
>  		error =3D PTR_ERR(ddata->usb);
>  		dev_err(ddata->dev, "failed to register USB charger: %i\n",
> --=20
> 2.13.0

--fh5tfmqzfinl3wiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCg7YACgkQ2O7X88g7
+ppgAA/+OrT/7a/9NSb21Sh6z/S977OXk6960D/STLWby5UHpIPWx1qMwcN9mg1Q
fcQS/nWBXtVq2kUpR7YRgkYuwSj4XmE86/upv+DsY5oeLsbJEU43qUZPU8J8PBa3
xu13tKnk6BW2kMlok5vLztZ4wccAKYKr8T84jnrNn1r7c1LuPLV0vBiL/XbFkMCZ
xoj0U7I0S4Tgw/6Os1dst8RnUOiy8IlLLy0suJ3GEs20ffiy1aH5ogYGzkWN62yO
jPFo7/6x8zgpqBCH9FlJl3cZYoZpg0JhFlUer/SMke2VjBvvcfBlOHK/69h39k7x
KJVbLj8qy+KXC//iJ8Bowpke+sk/xfqFNitN0QJThLwswifO0uUnSXwESL7oF/oM
Sjd2rfa40JSRM1GZUFc8b4wM0M/aHqH9fxTYbhFZi2FNjPOfngS4A4O9G2lsm8zu
i4Xk1QGJePta2KYkocIGnO3zn5y8Fh0eaYJQDZJZGRnyuzF6Zxnld/BEFy2ygQVH
EBuu5xUinFG9ujvXyDNAFseZoleDaXUjpO6rgpxXAcv849KzaUqFQg9ZDDvrMxQM
hUjtco8/3oQCtjTQVsiDlNmEBEuQkOmQZHOgElK5qA4pr3Q/BTqbGjYMXQom/nDy
wycuUlTT9na4xsTt8oplGK5zPhCtRfePoxwkNvalw7bm/mVIz6w=
=LY3m
-----END PGP SIGNATURE-----

--fh5tfmqzfinl3wiw--
