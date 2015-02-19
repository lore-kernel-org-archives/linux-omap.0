From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Thu, 19 Feb 2015 12:09:06 -0600
Message-ID: <20150219180906.GE13603@saruman.tx.rr.com>
References: <1424369209-26735-1-git-send-email-balbi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424369209-26735-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
> If either SCL or SDA are stuck low, we need to
> recover the bus using the procedure described
> on section 3.1.16 of the I2C specification.
>=20
> Note that we're trying to implement the procedure
> exactly as described by that section. First we
> check which line is stuck low, then implement
> one or the other procedure. If SDA recovery procedure
> fails, we reset our IP in an attempt to make it work.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>=20
> Tested with AM437x IDK, AM437x SK, BeagleBoneBlack and Beagle X15 with
> 1000 iterations of i2cdetect on all available buses.
>=20
> That said, I couldn't get any device to hold the bus busy so I could
> see this working. If anybody has any good way of forcing a condition
> so that we need bus recovery, I'd be glad to look at.
>=20
> cheers
>=20
>  drivers/i2c/busses/i2c-omap.c | 71 +++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 69 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0e894193accf..c3e4da751adf 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -472,6 +472,73 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	return 0;
>  }
> =20
> +static void omap_i2c_clock_pulse(struct omap_i2c_dev *dev)
> +{
> +	u32 reg;
> +	int i;
> +
> +	/* Enable testmode */
> +	reg =3D omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	reg |=3D OMAP_I2C_SYSTEST_ST_EN;
> +	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
> +
> +	for (i =3D 0; i < 9; i++) {
> +		reg |=3D OMAP_I2C_SYSTEST_SCL_O;
> +		omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
> +		mdelay(100);
> +		reg &=3D ~OMAP_I2C_SYSTEST_SCL_O;
> +		omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
> +		mdelay(100);
> +	}
> +
> +	/* Disable testmode */
> +	reg &=3D ~OMAP_I2C_SYSTEST_ST_EN;
> +	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
> +}
> +
> +static void omap_i2c_bus_recover(struct omap_i2c_dev *dev)
> +{
> +	u32 reg1;
> +	u32 reg2;
> +
> +	/*
> +	 * First differentiate SCL stuck low from SDA stuck low using our
> +	 * SYSTEST register. Depending on which line is stuck low, we will
> +	 * either Reset our I2C IP (SCL stuck low) or drive 9 clock pulses on
> +	 * SCL (SDA stuck low) to tell the device to release the bus.
> +	 *
> +	 * If, after 9 clock pulses on SCL device still doesn't release the
> +	 * bus, there's nothing more we can do; we will still try to Reset
> +	 * our I2C IP anyway.
> +	 */
> +
> +	reg1 =3D omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	msleep(1);

Hmm... I wonder if this msleep() should be scaled based on i2c bus
frequency.

--=20
balbi

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5ibCAAoJEIaOsuA1yqREIDIP+gIfV/unwo8He+ejU7bI5OFU
d5lW2IGKHk45wPybY2NY4waZJJyt1pY6DRjd0mIb74/uU6mix7R+I4A5pV3E1R4d
UrXFgNQaEyPOb1zHa1LuB5LhSy2+qPAkJBEEQwNhCtADHUzth8c8jepctOCPe02o
FPMHRG7QvFoCfFO1XKW+FfDgiJocRptdv5juxTjjhHU0OiCwL1uTEpPKJjNJxd3n
F50CBocUFjghLG5S9C9JHQ7oAvTn+qNcP0Pzqqo0Atl0pKL0OetiONnyuKbE7Dqb
9Qct/y/Ix5CiXr1g2+wH7arF7LGPgKhDNsasMJyHFmXGDpMiEBFlSOTlePiQEDYd
+t63Widgmtttl82a5NnTzERMnk0OkcOjzJzPwjKmAGn/xQ8MFPyxYwgklz6qiP/M
9RT+lDZENJ9wvI/9D4P1t767Doy88Zp+0tsx5BjMtinhhLLe+IE0EW4aTZTzgVF7
jRWfyyZ+2bVN9ITF5mmU0/orIdMeMmaMa2eHcVXee5gPiuhyB06Zhw/GMSHT39BL
A+8RTClwvYoy8MigFTTVqEHzfZx1B1NHDi1hHoh7EPeS/mLvLMRkVkoaWuk4f/iH
FLbd784wUeoZrkJeAFWQ+GvxMG/w3cpMfYziWO7a8hmSwAxGQbT1/wwKbuTvfKeF
KJ8UqyX7gw2CAhKMuEdl
=RYtQ
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
