From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v6 4/4] power: supply: twl4030-charger: add deferred
 probing for phy and iio
Date: Thu, 15 Jun 2017 13:57:57 +0200
Message-ID: <20170615115757.wuhzc6c2qrme2te6@earth>
References: <cover.1497432355.git.hns@goldelico.com>
 <6573ec523aa73971562c9b7e7d89f6045185d8c4.1497432355.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yei5vw3glv6etrnr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6573ec523aa73971562c9b7e7d89f6045185d8c4.1497432355.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--yei5vw3glv6etrnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 14, 2017 at 11:25:56AM +0200, H. Nikolaus Schaller wrote:
> This fixes an issue if both this twl4030_charger driver and
> phy-twl4030-usb are compiled as modules and loaded in random order.
>=20
> It has been observed on GTA04 and OpenPandora devices that in worst
> case the boot process hangs and in best case the AC detection fails
> with a warning.
>=20
> Therefore we add deferred probing checks for the usb_phy and the
> iio channel for AC detection.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/power/supply/twl4030_charger.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 3bebeecb4a1f..6ac8816262bd 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -989,15 +989,21 @@ static int twl4030_bci_probe(struct platform_device=
 *pdev)
> =20
>  		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
>  						  NULL, "ti,twl4030-usb");
> -		if (phynode)
> +		if (phynode) {
>  			bci->transceiver =3D devm_usb_get_phy_by_node(
>  				bci->dev, phynode, &bci->usb_nb);
> +			if (IS_ERR(bci->transceiver) &&
> +			    PTR_ERR(bci->transceiver) =3D=3D -EPROBE_DEFER)
> +				return -EPROBE_DEFER;	/* PHY not ready */
> +		}
>  	}

Let's also set to NULL + dev_warn for other errors (like the iio
channel error handling).

>  	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>  	if (IS_ERR(bci->channel_vac)) {
> -		bci->channel_vac =3D NULL;
> +		if (PTR_ERR(bci->channel_vac) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;	/* iio not ready */
>  		dev_warn(&pdev->dev, "could not request vac iio channel");
> +		bci->channel_vac =3D NULL;
>  	}
> =20
>  	bci->ac =3D devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,

-- Sebastian

--yei5vw3glv6etrnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCdj4ACgkQ2O7X88g7
+pq3pQ//YdgjK08d4Qo+JNTJvl7rl1a8qj9xta76fAxITCzbXNMtv8vgcU28tAoD
xJWXEViSC5BBkhc2sS5UW9qErCppSGsPixef5jF4OtYY7J4QTSJvlHuC1N94R9SR
aXSHJpYqBLcgkba8Zxl/MpI0Kp6+8z0Rk7IelxQrdP7ZkNyBayEj6wNZLysaJbfv
/qb4Ec/uHOKq+/lIcl2Z8s9S7iNCKqsoEM4UmBLUAWpnkqSHfRmmyoGHYa73NwaB
4U+VLN2w1qPcUYfhXTfqZNz7Q47LrVfVaCQZbH+oNtJ7fSTi9RzLMDMS7Qw+6jc+
ooa5iBS1PsEMMXXrX9FEarlFaLqud9eyW5jIvu15VqYc7IaZMY5oYWF7eWTzMvNa
rWaitrCIZuEKlu5Twcqm7beBH7xFNwVZlWaB+v2gbqLYYVE0JodoHBHAQTQkYlpz
Z78lThBMrXgXv6+Z7vge7chohDrfUuXhfBezZM3UfHrfh2/oJNhllLk9rwYv+eAB
nZ1LcI2+h3iJlV/6qrBOIHd1sWL6TE4SDFoprj89gpT2IL2JbVp4IiSBoiLtY3D+
umffIUQjp5g6fN/4nxCnQFsO2uuzlnXcacazc8xB1Km3RnSq/7vuewIcAlJQXQOC
A/uetea2pnQeQL+R8oS+odJgGXKj8D/fyM6li6fXFwLTF/hdK7E=
=mtLQ
-----END PGP SIGNATURE-----

--yei5vw3glv6etrnr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
