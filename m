From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/4] power: supply: twl4030-charger: move allocation
 of iio channel to the beginning
Date: Wed, 14 Jun 2017 22:13:51 +0200
Message-ID: <20170614201351.ixpfellwc35u27id@earth>
References: <cover.1497432355.git.hns@goldelico.com>
 <0aa7052c6c8183ef12c08ed6aa069ddf8c748809.1497432355.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqho5hzbgzetc2ah"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0aa7052c6c8183ef12c08ed6aa069ddf8c748809.1497432355.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--sqho5hzbgzetc2ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 14, 2017 at 11:25:54AM +0200, H. Nikolaus Schaller wrote:
> This is in prepraration for EPROBE_DEFER handling because it is quite
> likely that geting the (madc) iio channel is deferred more often than
> later steps.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 9507c24495ba..1fbbe0cc216a 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -984,6 +984,12 @@ static int twl4030_bci_probe(struct platform_device =
*pdev)
> =20
>  	platform_set_drvdata(pdev, bci);
> =20
> +	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
> +	if (IS_ERR(bci->channel_vac)) {
> +		bci->channel_vac =3D NULL;
> +		dev_warn(&pdev->dev, "could not request vac iio channel");
> +	}
> +
>  	bci->ac =3D devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
>  					     NULL);
>  	if (IS_ERR(bci->ac)) {
> @@ -1017,12 +1023,6 @@ static int twl4030_bci_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20
> -	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
> -	if (IS_ERR(bci->channel_vac)) {
> -		bci->channel_vac =3D NULL;
> -		dev_warn(&pdev->dev, "could not request vac iio channel");
> -	}
> -
>  	INIT_WORK(&bci->work, twl4030_bci_usb_work);
>  	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
> =20
> --=20
> 2.12.2
>=20

--sqho5hzbgzetc2ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllBmP8ACgkQ2O7X88g7
+poByQ/7B/RW5R7aGBgAKN401evrnIeX+y/kRJslSP9VVyLk/ExnKf0PxpbUsQ5I
X1NU6Sa996sb0TOumwB0goNt84nJnSRgIfltSs1kNq2GYFzlDuAG8ebDgEOakERJ
2kwBRb7st/FuBqan7MIPmR4jdCwqop65mFtruczSUKjGU1W0CyTULN84UG11RCB4
3ixPVZgY7BiyrB0X049uRLZbnVg41H/mUVWf8wRbupK+RLBwBY5LQFsNipeAZeDp
lNUi1VGI0YzJFoZduB+BpA+76f8XKULcgHS+/SN1RYUYN0vJ8RGBn8fmKZXC7O/p
2LXXCrqMQsagDlbPDsMDq3oBS3KEc4SfnYEL3hGRLC0Scl1LbA1U0jYWC0FNbYjn
LGxJFXGfVZDIg+IJMEDcDY85uDwzKdngCimH5RMVsiCr5mUQZDBlVcNmwj3QM4vI
ZJc6G3OgaSUumF9vjw2PazJPd9YYIh/JXoncHTxjaXJmUmKmWYX8ULk/oflbXU/r
8S4XXCjzF8FhZEKu3Jurd7st5DpI9uoR4wKjdOMOlUS4k80TywXc1/GOX4ZsGN8D
OnXjjlPRB0SQkvQ6cUaC5ltuNbZjLCtS9Jk2kQz6hTF01uWLaiuBRBN6Su2rlZYH
2FZXyGZRvGLk9/x49H634QFTUK65Ugxr/vKjcwBieImX8Z/gnIA=
=HROy
-----END PGP SIGNATURE-----

--sqho5hzbgzetc2ah--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
