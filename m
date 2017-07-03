From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v7 2/2] power: supply: twl4030-charger: add deferred
 probing for phy and iio
Date: Mon, 3 Jul 2017 14:59:54 +0200
Message-ID: <20170703125954.csrdoxlr3oda57m4@earth>
References: <cover.1497861705.git.hns@goldelico.com>
 <63d2c2c5bfb1bb8ec006c1991bbd01e8d102c341.1497861705.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cveuc4wd3brkn3v7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63d2c2c5bfb1bb8ec006c1991bbd01e8d102c341.1497861705.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--cveuc4wd3brkn3v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 19, 2017 at 10:41:46AM +0200, H. Nikolaus Schaller wrote:
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

Looks fine to me.

-- Sebastian

> ---
>  drivers/power/supply/twl4030_charger.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 9d974f1e3957..0d2125e4f735 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -989,8 +989,12 @@ static int twl4030_bci_probe(struct platform_device =
*pdev)
> =20
>  	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>  	if (IS_ERR(bci->channel_vac)) {
> +		ret =3D PTR_ERR(bci->channel_vac);
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			return ret;	/* iio not ready */
> +		dev_warn(&pdev->dev, "could not request vac iio channel (%d)",
> +			ret);
>  		bci->channel_vac =3D NULL;
> -		dev_warn(&pdev->dev, "could not request vac iio channel");
>  	}
> =20
>  	if (bci->dev->of_node) {
> @@ -1002,6 +1006,14 @@ static int twl4030_bci_probe(struct platform_devic=
e *pdev)
>  			bci->transceiver =3D devm_usb_get_phy_by_node(
>  				bci->dev, phynode, &bci->usb_nb);
>  			bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
> +			if (IS_ERR(bci->transceiver)) {
> +				ret =3D PTR_ERR(bci->transceiver);
> +				if (ret =3D=3D -EPROBE_DEFER)
> +					return ret;	/* phy not ready */
> +				dev_warn(&pdev->dev, "could not request transceiver (%d)",
> +					ret);
> +				bci->transceiver =3D NULL;
> +			}
>  		}
>  	}
> =20
> --=20
> 2.12.2
>=20

--cveuc4wd3brkn3v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaP8oACgkQ2O7X88g7
+podHQ/2OyugFpGGyRTApvYP848WX7afY7R0XOPh2GzTrkA6S8Hzg7k/EPyPGpCi
jcxv4Ff1716Oz3tKYGBkG0hM81lT5qqe6zMp5xpAG5SEM7kxiFNvIfNPIVrvv6Z+
hRKbhvBoUhIFZrE0nw0MAuUJjLu0OUKNwkjsmSYrUFpF5pMEHKnj+sw1//3AloOk
nSbtbDst6mtwRvOxbTvQQX34mEpT7k4aYvObKrNRZ8bagRlLnDXA9BRKwKhc+TwP
zY+sHlm5h3yrTDOR5oiNgj7uM8r3WsLT0htmCmc/35Ah0AlhSDsC8Z4bDWF7w8H+
qF97fKfnhkKA4F2+xcprBfYl06XNYgCeE6GJW9ujmr2f+mViFoqopdYv5I8bxbIC
8RsJPTnh54lWhC9eTlIHhTIAqMmhRggMVm7/NrRFBEBO0f/UOEH5zXfnCzfyaH7i
4xZysyn8xxK+yzJCTh+vogkwtdcx1dzNWg8qzRjJ28o3+vwJCnk0UPmeCrnZ9lxQ
zL96O9l9fr+7gR/HQsYC+YH02sW+FhFK0EQt+jTDX7ndPFilV+Zna36wt6ZJWGPs
yb26O4REOhIKaj6BBnuAt9Do3EvmJTdSQIfWNNVI6S29MKVkJZHONFAhmmwm+hTs
2LEq9QxD4SDV2qaIr7TGSMaipNnXyhjtENqu1Y3A5DfgTGIFLQ==
=JNj2
-----END PGP SIGNATURE-----

--cveuc4wd3brkn3v7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
