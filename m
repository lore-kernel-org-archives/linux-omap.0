From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 04/10] I2C: OMAP: Fix the error handling
Date: Mon, 23 Apr 2012 19:10:09 +0200
Message-ID: <20120423171009.GI27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-5-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53017 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2DWRKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 13:10:11 -0400
Content-Disposition: inline
In-Reply-To: <1334842101-20670-5-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The subject is too generic. (I don't want to be negative always: The
following description of the problem is good :))

On Thu, Apr 19, 2012 at 06:58:15PM +0530, Shubhrajyoti D wrote:
> Currently in probe
>       pm_runtime_put(dev->dev);

Indentation wrong.

>=20
> ...
>         /* i2c device drivers may be active on return from add_adapter() =
*/
>         adap->nr =3D pdev->id;
>         r =3D i2c_add_numbered_adapter(adap);
>         if (r) {
>                 dev_err(dev->dev, "failure adding adapter\n");
>                 goto err_free_irq;
>         }
> ...
>=20
>         return 0;
>=20
> err_free_irq:
>         free_irq(dev->irq, dev);
> err_unuse_clocks:
>         omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>         pm_runtime_put(dev->dev);
>=20
> This may access the i2c registers without the clocks.
> Attempting to fix the same by moving the pm_rintime_put after the error c=
heck.

Drop "Attempting".

>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index bf07ffd..1777d79 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1061,8 +1061,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
>  		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> =20
> -	pm_runtime_put(dev->dev);
> -
>  	adap =3D &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner =3D THIS_MODULE;
> @@ -1082,6 +1080,8 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	of_i2c_register_devices(adap);
> =20
> +	pm_runtime_put(dev->dev);
> +
>  	return 0;
> =20
>  err_free_irq:
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VjPEACgkQD27XaX1/VRsuQgCfdPTzNuqN5U2w5lCBNn6TZdt4
P/QAoKzin1b/pX2ypfFe5ZbLoe+6/LFQ
=bB19
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
