From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/16] mfd: omap-usb-tll: Avoid creating copy of platform
 data
Date: Wed, 21 Nov 2012 13:42:34 +0200
Message-ID: <20121121114234.GC10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-2-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab2KULtF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 06:49:05 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:33:59PM +0200, Roger Quadros wrote:
> Just a pointer to the platform data should suffice.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

this looks fine to me:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mfd/omap-usb-tll.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 4b7757b..d1750a4 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -98,7 +98,7 @@
>  struct usbtll_omap {
>  	struct clk				*usbtll_p1_fck;
>  	struct clk				*usbtll_p2_fck;
> -	struct usbtll_omap_platform_data	platdata;
> +	struct usbtll_omap_platform_data	*pdata;
>  	/* secure the register updates */
>  	spinlock_t				lock;
>  };
> @@ -223,8 +223,7 @@ static int __devinit usbtll_omap_probe(struct platfor=
m_device *pdev)
> =20
>  	spin_lock_init(&tll->lock);
> =20
> -	for (i =3D 0; i < OMAP3_HS_USB_PORTS; i++)
> -		tll->platdata.port_mode[i] =3D pdata->port_mode[i];
> +	tll->pdata =3D pdata;
> =20
>  	tll->usbtll_p1_fck =3D clk_get(dev, "usb_tll_hs_usb_ch0_clk");
>  	if (IS_ERR(tll->usbtll_p1_fck)) {
> @@ -362,7 +361,7 @@ static int __devexit usbtll_omap_remove(struct platfo=
rm_device *pdev)
>  static int usbtll_runtime_resume(struct device *dev)
>  {
>  	struct usbtll_omap			*tll =3D dev_get_drvdata(dev);
> -	struct usbtll_omap_platform_data	*pdata =3D &tll->platdata;
> +	struct usbtll_omap_platform_data	*pdata =3D tll->pdata;
>  	unsigned long				flags;
> =20
>  	dev_dbg(dev, "usbtll_runtime_resume\n");
> @@ -388,7 +387,7 @@ static int usbtll_runtime_resume(struct device *dev)
>  static int usbtll_runtime_suspend(struct device *dev)
>  {
>  	struct usbtll_omap			*tll =3D dev_get_drvdata(dev);
> -	struct usbtll_omap_platform_data	*pdata =3D &tll->platdata;
> +	struct usbtll_omap_platform_data	*pdata =3D tll->pdata;
>  	unsigned long				flags;
> =20
>  	dev_dbg(dev, "usbtll_runtime_suspend\n");
> --=20
> 1.7.4.1
>=20

--=20
balbi

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrL4qAAoJEIaOsuA1yqREcREP/jxq/xxe3HE9CUtGaclRi9NA
cK+QtmK3IX9g4HjulmURuyieppGauAu18HyYEegm7KasylsVUOaZGp4ayh3J0KDx
bNHwJFxQAppTeHb5HPevt0a1jmbuNEsLxDnhOWXYx0uwabpL9kD54rQ4RuYCSR1l
39yQCpzHVM7d1MaCk6SfyNkQWXsi345Y95ZGbkabS+yoNCZBkgRsYahwxOdbLS5g
3N6CvRMfy9z9XEmmlgxfzU+4Oejnj6tOVL5YM4nGV2yU5I8/1oO1sQ457tdwSojQ
tZlbXwDYd3Hb+t9Ml78vyB8l/qyL7sbXRtPvSE3A+K+3OgqsXceBUeuKX1O4YC9q
dmGmnaLtHgQmj8yHhqIpu6FmirhSJ0Cq7fWPWyxSvXaIj7NIa4DH01E5LR4gsWF0
h3dzH8vnOfPKfWZsOgeIBDVQuzYxVmnLKa7FRurZS0HdYN5sOSiLWhivbIQMYb1v
yT3cnQ9IlGjQU0zLn1KkEc0DUbFkPhkDDfU3kOevRSD8/CW+cRUqAbLPgg5F4xfS
Evoh7qUX+SHJRBQciojDBzIT23cI3kyndrvaXoW+G85fAxUebAXOlyVSnpwjnGK+
GDojajljMtXHKSb/3ctw66I9QQ08TRYrDYlR9RK9sjBXRRwogzYxkGFTt+YaT6I7
aUHSvHJnQGJRZVxijMhx
=PRCQ
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
