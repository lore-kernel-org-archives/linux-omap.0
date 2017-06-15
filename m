From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v6 3/4] power: supply: twl4030-charger: move irq
 allocation to just before irqs are enabled
Date: Thu, 15 Jun 2017 13:47:04 +0200
Message-ID: <20170615114704.odpislk5a4nsigtv@earth>
References: <cover.1497432355.git.hns@goldelico.com>
 <0eeffa7a6ab8e4213f518e2caf6982d2b77dc0b2.1497432355.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k7sxcplenkf75emn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0eeffa7a6ab8e4213f518e2caf6982d2b77dc0b2.1497432355.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--k7sxcplenkf75emn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 14, 2017 at 11:25:55AM +0200, H. Nikolaus Schaller wrote:
> This avoids a potential race if irqs are enabled and triggered too early
> before the worker is properly set up.
>=20
> Suggested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/power/supply/twl4030_charger.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 1fbbe0cc216a..3bebeecb4a1f 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -984,6 +984,16 @@ static int twl4030_bci_probe(struct platform_device =
*pdev)
> =20
>  	platform_set_drvdata(pdev, bci);
> =20
> +	if (bci->dev->of_node) {
> +		struct device_node *phynode;
> +
> +		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> +						  NULL, "ti,twl4030-usb");
> +		if (phynode)
> +			bci->transceiver =3D devm_usb_get_phy_by_node(
> +				bci->dev, phynode, &bci->usb_nb);
> +	}
> +

The notifier is not that much different from an irq. I see
the call can access at least the iio channel (so iio channel
should be registered first). I suspect worker and power-supply
should also be initialized/registered first. Best location seems
to be directly before requesting the irqs.

>  	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>  	if (IS_ERR(bci->channel_vac)) {
>  		bci->channel_vac =3D NULL;
> @@ -1006,6 +1016,10 @@ static int twl4030_bci_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20
> +	INIT_WORK(&bci->work, twl4030_bci_usb_work);
> +	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
> +
> +	bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;

You should configure the notifier block *before* registering it.

>  	ret =3D devm_request_threaded_irq(&pdev->dev, bci->irq_chg, NULL,
>  			twl4030_charger_interrupt, IRQF_ONESHOT, pdev->name,
>  			bci);
> @@ -1023,20 +1037,6 @@ static int twl4030_bci_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20
> -	INIT_WORK(&bci->work, twl4030_bci_usb_work);
> -	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
> -
> -	bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
> -	if (bci->dev->of_node) {
> -		struct device_node *phynode;
> -
> -		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> -						  NULL, "ti,twl4030-usb");
> -		if (phynode)
> -			bci->transceiver =3D devm_usb_get_phy_by_node(
> -				bci->dev, phynode, &bci->usb_nb);
> -	}
> -
>  	/* Enable interrupts now. */
>  	reg =3D ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
>  		TWL4030_TBATOR1 | TWL4030_BATSTS);

-- Sebastian

--k7sxcplenkf75emn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCc7UACgkQ2O7X88g7
+pr4+g/9EwqRqoVSXxtPsq0Df0xwR3FdYw1lz9PAD8emgyiRwGAVkHWEyJZsJwZy
8ccvkSgZmsi/Q9kSYjN9MDY96yt+qaboZsuEtDC9ecsocvt6p/akjgM5Zzy6m1Ms
5cj/bTImQc8vSstzdt24DLh1KhDclAjUhNBV3AodEPl4g2Gq686LEqpWjd0VGQkY
gq77aV3aYtBX7itBMoX4Bc0xX29QhCcS0TtyvDZKCVSIzlX6fs57/N20J3ucbq3f
MjujX1ynkxY5DfzwzseZ9nnzH4ukFhI3CKbA1gkqsXrWrMAEwcvon1MpbQbI7rRX
a2JG9lckAhWNeixEtwb1NdWXv3aI1u2ARm63Eh2iHh2vrIw4UKM3ghbzhq8wVL83
TXv6mVmJIeiwr4M1BtwCEN5oidlmhQgoO7fWEIEPkbXAE6vAzhaTr7F+NlVI3/WP
vZpT+QGgIL3+hgjo+iraCsADvMBcIy6EVIy0ODAZ/CXN0VVgaQkJpr7ACM5p7toG
LN2IwFPjFsRUWruVq9Lf/6RSEJzVjcqPmvbxTMP+NPON4hOpASiARQ7COeGGsRpl
lUrijZdjKDnDQZxptfzbOtoPLadvCH1WBfNK9EIYzyBUZnbqf0WtNMqbvugZL++G
/LHZDFZUs/K9aoKc5ntwNKPizCj/89uUBzFdq6dFvMt2DEduIG0=
=TbWi
-----END PGP SIGNATURE-----

--k7sxcplenkf75emn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
