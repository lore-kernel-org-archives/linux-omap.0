From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable
 and disable
Date: Mon, 23 Apr 2012 17:43:45 +0200
Message-ID: <20120423154345.GA27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab2DWPns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 11:43:48 -0400
Content-Disposition: inline
In-Reply-To: <1334842101-20670-3-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 06:58:13PM +0530, Shubhrajyoti D wrote:
> Currently the i2c driver calls the pm_runtime_enable and never
> the disable. This may cause a warning when pm_runtime_enable
> checks for the count match.Attempting to fix the same by calling
> pm_runtime_disable in the error and the remove path.

Why "attempting"?

>=20
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4f4188d..c851672 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1090,6 +1090,7 @@ err_unuse_clocks:
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(dev->dev);
>  	iounmap(dev->base);
> +	pm_runtime_disable(&pdev->dev);
>  err_free_mem:
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(dev);
> @@ -1110,6 +1111,7 @@ omap_i2c_remove(struct platform_device *pdev)
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	pm_runtime_disable(&pdev->dev);
>  	iounmap(dev->base);
>  	kfree(dev);
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VeLEACgkQD27XaX1/VRtADgCfYP/8EsIUTqpJJOT0eddyPPr0
V04AoK1HA98AGLRlVqfli8pqH9y5QGPo
=mpw+
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
