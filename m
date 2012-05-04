From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: Finish ehci omap phy reset cycle before adding hcd.
Date: Fri, 4 May 2012 14:34:42 +0300
Message-ID: <20120504113427.GT1156@arwen.pp.htv.fi>
References: <1336130687-5933-1-git-send-email-Russ.Dill@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="msgLTjjeumHWYklJ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336130687-5933-1-git-send-email-Russ.Dill-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Raja Govindraj <govindraj.raja-l0cyMroinI0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--msgLTjjeumHWYklJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 04, 2012 at 04:24:47AM -0700, Russ Dill wrote:
> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0f) created =
a regression
> with Beagleboard xM if booting the kernel after running 'usb start' under=
 u-boot.
>=20
> Finishing the reset before calling 'usb_add_hcd' fixes the regression. Th=
is is most likely due to
> usb_add_hcd calling the driver's reset and init functions which expect th=
e hardware to be
> up and running.
>=20
> Signed-off-by: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>

looks correct to me:

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/usb/host/ehci-omap.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 5c78f9e..e669c6a 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -242,15 +242,6 @@ static int ehci_hcd_omap_probe(struct platform_devic=
e *pdev)
> =20
>  	ehci_reset(omap_ehci);
> =20
> -	ret =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
> -	if (ret) {
> -		dev_err(dev, "failed to add hcd with err %d\n", ret);
> -		goto err_add_hcd;
> -	}
> -
> -	/* root ports should always stay powered */
> -	ehci_port_power(omap_ehci, 1);
> -
>  	if (pdata->phy_reset) {
>  		/* Hold the PHY in RESET for enough time till
>  		 * PHY is settled and ready
> @@ -264,6 +255,15 @@ static int ehci_hcd_omap_probe(struct platform_devic=
e *pdev)
>  			gpio_set_value(pdata->reset_gpio_port[1], 1);
>  	}
> =20
> +	ret =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
> +	if (ret) {
> +		dev_err(dev, "failed to add hcd with err %d\n", ret);
> +		goto err_add_hcd;
> +	}
> +
> +	/* root ports should always stay powered */
> +	ehci_port_power(omap_ehci, 1);
> +
>  	return 0;
> =20
>  err_add_hcd:
> --=20
> 1.7.9.5
>=20

--=20
balbi

--msgLTjjeumHWYklJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPo77RAAoJEIaOsuA1yqREbDgP/iI/nzHiG+9rJxA1AMWr33Qr
MZMoB+WFbGtJKKk8scuEkOIFPanW7tMYuRhJlZMOYoDuq4ICG1VclzuzosogPa7U
WqgZ4RFyO+YZj92OE8MwdFBTDmuV3fqJyUPGqLYGa2gMsgVew6ZMU6kN9VEb8JWD
6kz5I+IY5h7O51dL62l41Fg8xPNPgFN7cCjwumIHuwTxFw+tVIitg/4+6QdCpjor
h4267bK+Oikj5gn7Tw2qCxsMBeRX/wVjXHdKiXRzFxoMdtAZ2MPwhAk+BmG1F2nP
iP0PTZ9hCrEXDkKSSxQAmlATKwl4tZS6lrg5pehLa/Vh8+vwI6umqRBJQfG2LQn/
/HzS3bBzDYY3XRDZ6+l1qDb1/0DBAN+Drnp5133cec2qMvJQ4nXY0ckeM3IcEDBe
pwcnhBCvsBaw2GU0IeSWGdCHQx975rGVa9v6BRg7TBqfcMYrBLl0wlZBKiqRcGvg
g8szWrsdADhII479lDorNJk/X0AJNOCRC9QqzItdc0XluWCz4Yhwe87AtgN/WYNz
ZkbbZ9jLGbXAh4VAYgEsAZtF/cBS9aJ22wslsR2J6xY3umV4qP6PoKYUl1dNKAzM
NQAZYmbkhNSwBXVPlGYInlrMHj4b5QGoFL4fGYWDK/z3Pi4yslIw8QRfJXJgtgeA
OzYSpKcnkSaPvOGPY9FT
=n19K
-----END PGP SIGNATURE-----

--msgLTjjeumHWYklJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
