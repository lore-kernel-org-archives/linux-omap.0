From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 08/10] I2C: OMAP: fix missing handling of errata
 I2C_OMAP3_1P153
Date: Mon, 23 Apr 2012 18:43:56 +0200
Message-ID: <20120423164356.GD27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-9-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47520 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab2DWQn6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 12:43:58 -0400
Content-Disposition: inline
In-Reply-To: <1334842101-20670-9-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Tasslehoff Kjappfot <tasskjapp@gmail.com>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 06:58:19PM +0530, Shubhrajyoti D wrote:
> From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
>=20
> i2c_probe set the dev->errata flag, but omap_i2c_init cleared the flag ag=
ain.
> Move the errata handling to i2c_probe.
>=20
> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Subject looks bogus to me. You are handling I207 here.

> ---
>  drivers/i2c/busses/i2c-omap.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d555dcd..9323201 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -427,11 +427,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	/* Take the I2C module out of reset: */
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> =20
> -	dev->errata =3D 0;
> -
> -	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> -		dev->errata |=3D I2C_OMAP_ERRATA_I207;
> -
>  	/* Enable interrupts */
>  	dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> @@ -1023,6 +1018,11 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> =20
> +	dev->errata =3D 0;
> +
> +	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> +		dev->errata |=3D I2C_OMAP_ERRATA_I207;
> +
>  	if (dev->rev <=3D OMAP_I2C_REV_ON_3430)
>  		dev->errata |=3D I2C_OMAP3_1P153;
> =20
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VhswACgkQD27XaX1/VRs/PgCgrj6vIqzS+VrcAaGc8NWELE6R
Hh4An1ygqJhLFceYBPtmEvlJV2g0JkO6
=EjbH
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
