From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred
 probing for phy and iio
Date: Wed, 7 Jun 2017 22:44:44 +0200
Message-ID: <20170607204444.zumcreuqdnv7euv2@earth>
References: <cover.1495363097.git.hns@goldelico.com>
 <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42ssb5kxbkw37n7a"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--42ssb5kxbkw37n7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 21, 2017 at 12:38:18PM +0200, H. Nikolaus Schaller wrote:
> This fixes an issue if both this twl4030_charger driver and
> phy-twl4030-usb are compiled as modules and loaded in random order.
> It has been observed on GTA04 and OpenPandora devices that in worst
> case the boot process hangs and in best case the AC detection fails
> with a warning.
>
> Therefore we add deferred probing checks for the usb_phy and the
> iio channel for AC detection.
>=20
> For implementing this we must reorder code because we can't safely
> return -EPROBE_DEFER after allocating any devm managed interrupt
> (it might already/still be enabled without working interrupt handler).
>
> So the check for required resources that may abort probing by
> returning -EPROBE_DEFER, must come first.

This sounds fishy. EPROBE_DEFER should not be different from
other error codes in this regard and devm_ requested resources
should be free'd on any error. Why is irq handler not working?

> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/power/supply/twl4030_charger.c | 37 ++++++++++++++++++++--------=
------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 785a07bc4f39..945eabdbbc89 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -984,6 +984,28 @@ static int twl4030_bci_probe(struct platform_device =
*pdev)
> =20
>  	platform_set_drvdata(pdev, bci);
> =20
> +	if (bci->dev->of_node) {
> +		struct device_node *phynode;
> +
> +		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> +						  NULL, "ti,twl4030-usb");
> +		if (phynode) {
> +			bci->transceiver =3D devm_usb_get_phy_by_node(
> +				bci->dev, phynode, &bci->usb_nb);
> +			if (IS_ERR(bci->transceiver) &&
> +			    PTR_ERR(bci->transceiver) =3D=3D -EPROBE_DEFER)
> +				return -EPROBE_DEFER;	/* PHY not ready */
> +		}
> +	}
> +
> +	bci->channel_vac =3D iio_channel_get(&pdev->dev, "vac");
> +	if (IS_ERR(bci->channel_vac)) {
> +		if (PTR_ERR(bci->channel_vac) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;	/* iio not ready */
> +		dev_warn(&pdev->dev, "could not request vac iio channel");
> +		bci->channel_vac =3D NULL;
> +	}
> +

You should not request non-devm managed iio_channel before
devm-managed power-supply. This could be fixed by switching to
devm_iio_channel_get(), which also cleans up some code.

I suspect, that this is also your IRQ problem, since iio_channel
is currently free'd before irqs are free'd, but its used in irq
code.

>  	bci->ac =3D devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
>  					     NULL);
>  	if (IS_ERR(bci->ac)) {
> @@ -1017,25 +1039,10 @@ static int twl4030_bci_probe(struct platform_devi=
ce *pdev)
>  		return ret;
>  	}
> =20
> -	bci->channel_vac =3D iio_channel_get(&pdev->dev, "vac");
> -	if (IS_ERR(bci->channel_vac)) {
> -		bci->channel_vac =3D NULL;
> -		dev_warn(&pdev->dev, "could not request vac iio channel");
> -	}
> -
>  	INIT_WORK(&bci->work, twl4030_bci_usb_work);
>  	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
> =20
>  	bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
> -	if (bci->dev->of_node) {
> -		struct device_node *phynode;
> -
> -		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> -						  NULL, "ti,twl4030-usb");
> -		if (phynode)
> -			bci->transceiver =3D devm_usb_get_phy_by_node(
> -				bci->dev, phynode, &bci->usb_nb);
> -	}
> =20
>  	/* Enable interrupts now. */
>  	reg =3D ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |

-- Sebastian

--42ssb5kxbkw37n7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4ZbkACgkQ2O7X88g7
+pptvw//a8dYAo4KgM93YvGnAAi2yCSPaj4XmIoIs+bRi8KO5bsap3leBhGshK96
EnYbLABAQ6a5OULJqEbefvwgpMHRyy09zJl++DhyQgQi0d3nS9n3YS0g5xac0qVY
cfHpAt8KGEkXdyUQRovlZJ8AVkDcXWGeyDI1bO30BY+GHLprQQ5t8Gi38VO3ErUB
DPZgVCzn+ALCDIzLHTPXWJJ27TZKOylc++lXil2ptktI4l+YJXpMY9YmM64Al61I
0Etx6XVZ73QgRxEa+SgEs0ovmHJ6B09tpk6v+8Q95XG6lhTFyVrKt9LA8pBGuhAP
zgkVLE7gvFM8FedVt3M82OTwK/vcU3XCwZQhWfDr61aGO8bpxPuQ3iyZrHCD0g80
YCJvxPwLd5EtFOE8Vo4SvT+fOG25nCjpCg0MKRgMp1zy9mab3zdAGbR2qxqgUhqw
iPIONO60zpGczDsE2M8roU0MyXrhk03gsMYNrugmULILQr9zvJTQocF/NpbSmtOo
gobXaUNdULo0FR8fSrJMwNdXXncShriA5tnUpFsk3Bn2cfKvx7RNNWQo56CPbgO2
HVCrqJdmGlxAkfodzU4IZXl9ctfwJ570J5qJaM0VVr/uglpc8NEkGG7+9s0mtX+2
DOhJgqJtDlVJAGtg76HWwRsWDdRd3NxPUvgEljRkdyu3GYSZT9s=
=JPQe
-----END PGP SIGNATURE-----

--42ssb5kxbkw37n7a--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
