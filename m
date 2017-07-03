From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v7 1/2] power: supply: twl4030-charger: move irq
 allocation to just before irqs are enabled
Date: Mon, 3 Jul 2017 14:55:56 +0200
Message-ID: <20170703125556.kaeds2qwk3hxgkw4@earth>
References: <cover.1497861705.git.hns@goldelico.com>
 <2b919bea97f23c952e0141ed63d04dbbcea5c695.1497861705.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45iesxufwisbf3hp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2b919bea97f23c952e0141ed63d04dbbcea5c695.1497861705.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--45iesxufwisbf3hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 19, 2017 at 10:41:45AM +0200, H. Nikolaus Schaller wrote:
> And initialize workers and notifiers as soon as possible.
>=20
> This avoids a potential race if irqs are enabled and triggered too early
> before the worker is properly set up.
>=20
> Suggested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/power/supply/twl4030_charger.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 1fbbe0cc216a..9d974f1e3957 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -984,12 +984,27 @@ static int twl4030_bci_probe(struct platform_device=
 *pdev)
> =20
>  	platform_set_drvdata(pdev, bci);
> =20
> +	INIT_WORK(&bci->work, twl4030_bci_usb_work);
> +	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
> +
>  	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>  	if (IS_ERR(bci->channel_vac)) {
>  		bci->channel_vac =3D NULL;
>  		dev_warn(&pdev->dev, "could not request vac iio channel");
>  	}
> =20
> +	if (bci->dev->of_node) {
> +		struct device_node *phynode;
> +
> +		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> +						  NULL, "ti,twl4030-usb");
> +		if (phynode) {
> +			bci->transceiver =3D devm_usb_get_phy_by_node(
> +				bci->dev, phynode, &bci->usb_nb);
> +			bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;

those two should be the other way around.

-- Sebastian

--45iesxufwisbf3hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaPtkACgkQ2O7X88g7
+pqw1Q//R09pCXLxnVIrPjpWMn8qY26Hsi9Kz6EX1mUpHdJVjR2tdu5LqsIifbNb
e3Re4XLt0lQs/gMga+6CWRChlYiGYCZKqrCaKVNG61r97KWthXdvmyPgN36b8nMm
dmpCjyzU4nf5vOfz3EzmUnpgkvDpLCegMXSPXwTYjX4TupZkFcX2c1ZVL09Jf7je
1dHiMm8AxpcxK16uBdFUCC56tDG/EgG1qns7IqIXB4+mk2KtzRhNnO1Kf5hdfT/M
DF9IXM7+G2rmWSJKYluLIzPxcgC1IsbqaL7IbD28pzCiZCauEaoP85+6fum8k+D5
STXNVTMayt+Do29/N4hDugWsO9q/z7BpujH9aXet7VDdefCofJyQIVot78zR/fb3
hprw/S1vKuMZ65JoGKuukz3I0ScW2+0cAcLtvn/97tEtjKo8sUu4sMQGqj13apqM
HP+fQbbUtFMvnI1zNlxC6yazMaSIx4BVbVFsUKwQ4i3mHSapLiHAihyxie+0qB2A
3b/ygQx9oQR9Bloce+Qyz702+sSenxjLn5hN83zf/SXaOLuoIEgVAvCotFJqVi1W
nqBeyPHIKV33B5QxEWZ+ncLSA8HX1qEyPI+pex+pVuS0pUYgH6AbY84BdbwXyV46
LV5fgiNNdaEQfgLeU9UfYcdBXWlUKJWsvDh3O5ayrx4m6gDvr5E=
=Wxp8
-----END PGP SIGNATURE-----

--45iesxufwisbf3hp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
