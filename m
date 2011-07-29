From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Fri, 29 Jul 2011 15:07:12 +0300
Message-ID: <20110729120711.GL31013@legolas.emea.dhcp.ti.com>
References: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40044 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754726Ab1G2MHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 08:07:18 -0400
Content-Disposition: inline
In-Reply-To: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, santosh.shilimkar@ti.com, Andy Green <andy@warmcat.com>


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 05:18:42PM +0530, Shubhrajyoti D wrote:
> Currently for OMAP4 the I2C_WE is not programmed.
> This patch enables the programming for OMAP4.
>=20
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> TODO:
> Currently all the wakeup sources are enabled.
> There is scope of optimising the same. Will revisit it.
> Rebased on Kevin's wip/i2c branch
> Tested on OMAP4430.
>=20
>  drivers/i2c/busses/i2c-omap.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d05efe7..18cc0af 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -313,9 +313,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		 * REVISIT: Some wakeup sources might not be needed.
>  		 */
>  		dev->westate =3D OMAP_I2C_WE_ALL;
> -		if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
> -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> -							dev->westate);
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> +						dev->westate);

this is also enabling for 3530, have you tested there too ?? On the
other hand, this looks like it's fixing a bogus change on commit
a3a7acbcc3df4e9ecc12aa1fc435534d74ebbdf4 (I2C: OMAP2+: address confused
probed version naming) specifically on the hunk below [1]:

@@ -379,7 +379,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
                         * REVISIT: Some wkup sources might not be needed.
                         */
                        dev->westate =3D OMAP_I2C_WE_ALL;
-                       omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westa=
te);
+                       if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
+                               omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+                                                               dev->westat=
e);
                }
        }
        omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);

if that's the case, you should either update your commit log stating
that this is a fix to a bug introduced by that commit, or fold this
patch in the same. You should also Cc the patch author to clarify why
the dev->rev check was added.

Andy, can you clarify why you added the revision check which didn't
exist before ?

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=
=3Dcommitdiff;h=3Da3a7acbcc3df4e9ecc12aa1fc435534d74ebbdf4

--=20
balbi

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMqJvAAoJEAv8Txj19kN13REH/2nWvs0ctSg/uVIDXTSiOHLG
5xVmKXVydcu3pzct3WhKAZlyxR09kV2fn+5QTN3nQdaQAuJDaRFX+FllL/yEtgd9
EINXv8//H6juOhC2FISU1EWKMw8QNDPRxO14wxsEu9+vavu4s+6YWBtDIH0sEqw2
0k483FSUQJJAiogpn0rjppKPiy/8qWzOE3rwvy+aOqts+eJwH3Y0GpTvjjW11KCg
l3DS5Q8RPfI51AF6KTgPhPgJqzMxOis44DkQQAkbRwFPTWhACKgDBp8UOSkTye9P
pXg3IXZVdO/xvgIfquEDNEGeWkwEkxFbzMYKiUBmPdoDDAQIGtkiU29Z1dhBF8A=
=TMaz
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--
