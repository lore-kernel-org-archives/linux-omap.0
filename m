From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 5/7] i2c: omap: wait for transfer completion before
 sending STP bit
Date: Thu, 25 Oct 2012 15:32:20 +0300
Message-ID: <20121025123220.GW21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-6-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7DA0n3a+SnB4bJ2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47830 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2JYMiX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 08:38:23 -0400
Content-Disposition: inline
In-Reply-To: <1351167915-15079-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Benoit Cousson <b-cousson@ti.com>, w.sang@pengutronix.de, ben-linux@fluff.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, michael@amarulasolutions.com

--H7DA0n3a+SnB4bJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 03:25:13PM +0300, Felipe Balbi wrote:
> Later patches will come adding support for
> reporting amount of bytes transferred so that
> client drivers can count how many bytes are
> left to transfer.
>=20
> This is useful mostly in case of NACKs when
> client driver wants to know exactly which
> byte got NACKed so it doesn't have to resend
> all bytes again.
>=20
> In order to make that work with OMAP's I2C
> controller, we need to prevent sending STP
> bit until message is transferred. The reason
> behind that is because OMAP_I2C_CNT_REG gets
> reset to original value after STP bit is
> shifted through I2C_SDA line and that would
> prevent us from reading the correct number of
> bytes left to transfer.
>=20
> The full programming model suggested by IP
> owner was the following:
>=20
> - start I2C transfer (without STP bit)
> - upon completion or NACK, read I2C_CNT register
> - write STP bit to I2C_CON register
> - wait for ARDY bit
>=20
> With this patch we're implementing all steps
> except step #2 which will come in a later
> patch adding such support.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 89 ++++++++++++++++---------------------=
------
>  1 file changed, 33 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 20f9ad6..699fa12 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -438,9 +438,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> =20
>  	/* Enable interrupts */
>  	dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> -			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> -			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
> -				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
> +			OMAP_I2C_IE_NACK | OMAP_I2C_IE_AL)  |
> +			((dev->fifo_size) ? (OMAP_I2C_IE_RDR |
> +				OMAP_I2C_IE_XDR) : 0);
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>  	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>  		dev->pscstate =3D psc;
> @@ -470,6 +470,22 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev =
*dev)
>  	return 0;
>  }
> =20
> +static int omap_i2c_wait_for_ardy(struct omap_i2c_dev *dev)
> +{
> +	unsigned long timeout;
> +
> +	timeout =3D jiffies + OMAP_I2C_TIMEOUT;
> +	while (!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_ARDY=
)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(dev->dev, "timeout waiting for access ready\n");
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(800, 1200);
> +	}
> +
> +	return 0;
> +}
> +
>  static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool=
 is_rx)
>  {
>  	u16		buf;
> @@ -515,7 +531,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  {
>  	struct omap_i2c_dev *dev =3D i2c_get_adapdata(adap);
>  	unsigned long timeout;
> -	int ret;
> +	int ret =3D 0;
>  	u16 w;
> =20
>  	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
> @@ -556,35 +572,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  	if (!(msg->flags & I2C_M_RD))
>  		w |=3D OMAP_I2C_CON_TRX;
> =20
> -	if (!dev->b_hw && stop)
> -		w |=3D OMAP_I2C_CON_STP;
> -
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> =20
>  	/*
> -	 * Don't write stt and stp together on some hardware.
> -	 */
> -	if (dev->b_hw && stop) {
> -		unsigned long delay =3D jiffies + OMAP_I2C_TIMEOUT;
> -		u16 con =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> -		while (con & OMAP_I2C_CON_STT) {
> -			con =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> -
> -			/* Let the user know if i2c is in a bad state */
> -			if (time_after(jiffies, delay)) {
> -				dev_err(dev->dev, "controller timed out "
> -				"waiting for start condition to finish\n");
> -				return -ETIMEDOUT;
> -			}
> -			cpu_relax();
> -		}
> -
> -		w |=3D OMAP_I2C_CON_STP;
> -		w &=3D ~OMAP_I2C_CON_STT;
> -		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> -	}
> -
> -	/*
>  	 * REVISIT: We should abort the transfer on signals, but the bus goes
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
> @@ -594,36 +584,36 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
>  	if (timeout =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		ret =3D -ETIMEDOUT;
> -		goto err_i2c_init;
> +		omap_i2c_init(dev);
> +		goto out;
>  	}
> =20
>  	/* We have an error */
>  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
>  		ret =3D -EIO;
> -		goto err_i2c_init;
> +		omap_i2c_init(dev);
> +		goto out;
>  	}
> =20
>  	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
>  		if (msg->flags & I2C_M_IGNORE_NAK)
>  			return 0;
> =20
> -		if (stop) {
> -			w =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> -			w |=3D OMAP_I2C_CON_STP;
> -			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> -		}
> -
>  		ret =3D -EREMOTEIO;
> -		goto err;
> +		omap_i2c_init(dev);

this is wrong. I will resend this patch alone. My bad.

--=20
balbi

--H7DA0n3a+SnB4bJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiTFUAAoJEIaOsuA1yqRE+wUP/AzTnXoEfo0ptlQYQKDEpfZt
hBHs6A6OxjrDVd1NkUmw9t0cNyKaeOsq7mcZIeiV9kCSqKGir3Nohhkt5bsfZ7Z2
Xup2sTb5IKeoIRH5Fg9PSG5at/e2TqJ77PZZNk49c5qySPogKRVEkN1yXEDq20Ni
7MTdcEVLuKzhF0eq0I73GcllETB/EykjnCuwCN9Vyn5sug4ZmcBOX4Tj/QDSHHCy
8K9wXO8pxUI6qKrLozbkBA3tp7qvjdYT+5K2pO4T+5kEykfAzCnn4lbR1Bj6PEgN
11kRrTakRMqJBD6ku76yKhiBNxnVWHjWfoSMFDeVe51PNO+cQZTPBGKbfz8jDor1
6GERo3seDwKigVlQDcgUCgh4kQuNe6JBz+AmW99OU/xLUf6rrJKRH6fG5lvTND66
yls1bekmHa7zJ+zWUPIQAaPxZfyI6Aoj+zQCQp7FNdHe28bBFosfspKFob422J+S
gk6mM4UDsH5Y4YFbzrdDidSmA8qvicCtjbT9l765liXZdYlhnbuW++uTrrmmpGtg
Iv1SfSgv/3+v6egwrV0Rl84zxrGT5tmSN0PF7Fbws0K7QEqAqViI5LOwAAE6qDeP
gFpqcj9Rho/LesPxcSDM7oHpoK6bVZ8FHfLpHV6uRh0o1K/KtbjGm+aWm7vjdLTd
nHGR8nv/EAE/y0g/lKa/
=fMKU
-----END PGP SIGNATURE-----

--H7DA0n3a+SnB4bJ2--
