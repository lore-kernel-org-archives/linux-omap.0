From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Wed, 14 Nov 2012 12:20:50 +0100
Message-ID: <20121114112050.GG5954@pengutronix.de>
References: <20121102085447.GE17063@arwen.pp.htv.fi>
 <1352102683-2243-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37573 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161052Ab2KNLUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 06:20:52 -0500
Content-Disposition: inline
In-Reply-To: <1352102683-2243-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2012 at 10:04:43AM +0200, Felipe Balbi wrote:
> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.
>=20
> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
>=20
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
>=20
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>=20
> Changes since v1:
> 	- use barrier() instead of wmb()
>=20
> Note: this version was compile-tested only
>=20
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..ba03bec 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>  	dev->buf =3D msg->buf;
>  	dev->buf_len =3D msg->len;
> +	barrier();

I agree adding a comment here is a good idea.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjfpIACgkQD27XaX1/VRuPEgCfUNVseZMDikdRcTAf82oWQUHf
iBAAnixd0hIqkR0P7aIvoquz+aXlUnxH
=ZS6b
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
