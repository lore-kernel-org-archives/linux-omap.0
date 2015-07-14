From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix bus recovery setup
Date: Tue, 14 Jul 2015 13:10:05 +0200
Message-ID: <20150714111004.GB1517@katana>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436366127-24756-1-git-send-email-jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to

Felipe: it seems you did not need this; is this AM335x specific?

> allow direct access to the SCL and SDA pins. In addition to ST_EN, we
> need to set the TMODE to 0b11 (Loop back & SDA/SCL IO mode select).
> Also, as the reset values of SCL_O and SDA_O are 0 (which means "drive
> low level"), we need to set them to 1 (which means "high-impedance") to
> avoid unwanted changes on the pins.
>=20
> As a precaution, reset all these bits to their default values after
> recovery is complete.
>=20
> Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d1c22e3fdd14..fc9bf7f30e35 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1247,7 +1247,14 @@ static void omap_i2c_prepare_recovery(struct i2c_a=
dapter *adap)
>  	u32 reg;
> =20
>  	reg =3D omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	/* enable test mode */
>  	reg |=3D OMAP_I2C_SYSTEST_ST_EN;
> +	/* select SDA/SCL IO mode */
> +	reg |=3D 3 << OMAP_I2C_SYSTEST_TMODE_SHIFT;
> +	/* set SCL to high-impedance state (reset value is 0) */
> +	reg |=3D OMAP_I2C_SYSTEST_SCL_O;
> +	/* set SDA to high-impedance state (reset value is 0) */
> +	reg |=3D OMAP_I2C_SYSTEST_SDA_O;
>  	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
>  }
> =20
> @@ -1257,7 +1264,11 @@ static void omap_i2c_unprepare_recovery(struct i2c=
_adapter *adap)
>  	u32 reg;
> =20
>  	reg =3D omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	/* restore reset values */
>  	reg &=3D ~OMAP_I2C_SYSTEST_ST_EN;
> +	reg &=3D ~OMAP_I2C_SYSTEST_TMODE_MASK;
> +	reg &=3D ~OMAP_I2C_SYSTEST_SCL_O;
> +	reg &=3D ~OMAP_I2C_SYSTEST_SDA_O;
>  	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
>  }
> =20
> --=20
> 2.1.4
>=20

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpO4MAAoJEBQN5MwUoCm2UioP+wR7mlSAYqA1KhLA0NvJCLl/
lg0p8M3CahfjkI64nqzcZpLSYWOsZxtpoaJ1txRVHEjlFwvUh/uX3f1z5aEilLia
Xx2j6jRo+BlKZ6QUYM1biA7f8GAIRF1sUm0UD5lCSIQjaF78uLrVSp/xLU8/8Cnd
ocahJ/kNRetThRzx3N2Q7zFPtFw6gbu9etmFcwZtVd50mOeyHtG1PT8HP/baTc8/
uopN6BlQmvMJUA06SfNXtS890r4Hcu8hVwPouZ1+6MbBYCc3Bqa0hlAwpsz2cH6w
ebwa8In67f7bNhlxPtFAgv9B4oTBzbb88eSiw6wWxe53/qPLTRXaoO7CkJNwze1+
krWIqMoqHU1VmxvohxrnSKOloFb7EzWmXexnrzWbh0FPqjThc41yHSsayEW9icBW
2S5BaBSaZ1zcKieezlqJAtXczNdTXIUG/UC2jMq98ApsS/8vHTopSXdegO0pqnA4
vij6LPSYDT2yFX6I3um+b38xU7DRCrCG6OtFRVE+nLG1IplUHuGMQ4R4vx6HRabj
2i+xl+UhTsfc7Z9YcHafPLZqgAUq/6x0mGKZRykjygypJdHq4QkYzVd73uuYiax8
/O8HTXZEmKp8Uj1xv4Yxa7BdDUQLSIBGwFhLHjYVsdEinMwK6erZGmLh/it8YeCB
/2vQhkxnIHzbFhJ/wOsa
=7oIj
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
