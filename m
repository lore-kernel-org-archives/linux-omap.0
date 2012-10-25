From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/7] i2c: omap: reorder exit path of
 omap_i2c_xfer_msg()
Date: Thu, 25 Oct 2012 15:40:26 +0300
Message-ID: <20121025124026.GZ21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-3-git-send-email-balbi@ti.com>
 <50893398.6070004@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ozVqH6bFr/3sC51"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50893398.6070004-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--1ozVqH6bFr/3sC51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 06:12:00PM +0530, Santosh Shilimkar wrote:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> >just a cleanup patch trying to make exit path
> >more straightforward. No changes otherwise.
> >
> >Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >---
> >  drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap=
=2Ec
> >index c07d9c4..bea0277 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -505,6 +505,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
> >  {
> >  	struct omap_i2c_dev *dev =3D i2c_get_adapdata(adap);
> >  	unsigned long timeout;
> >+	int ret;
> You might want to initialize the error value to avoid return 0. Compiler
> might be already cribbing for it
>=20
> >  	u16 w;
> >
> >  	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
> >@@ -582,31 +583,38 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *a=
dap,
> >  	dev->buf_len =3D 0;
> >  	if (timeout =3D=3D 0) {
> >  		dev_err(dev->dev, "controller timed out\n");
> >-		omap_i2c_init(dev);
> >-		return -ETIMEDOUT;
> >+		ret =3D -ETIMEDOUT;
> >+		goto err_i2c_init;
> >  	}
> >
> >-	if (likely(!dev->cmd_err))
> >-		return 0;
> >-
> Have you have drooped this check completely ?

yes, the idea is to have a single exit point, so all checks below would
be executed.

> >  	/* We have an error */
> >  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> >  			    OMAP_I2C_STAT_XUDF)) {
> >-		omap_i2c_init(dev);
> >-		return -EIO;
> >+		ret =3D -EIO;
> >+		goto err_i2c_init;
> >  	}
> >
> >  	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
> >  		if (msg->flags & I2C_M_IGNORE_NAK)
> >  			return 0;
> >+
> >  		if (stop) {
> >  			w =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> >  			w |=3D OMAP_I2C_CON_STP;
> >  			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> >  		}
> >-		return -EREMOTEIO;
> >+
> >+		ret =3D -EREMOTEIO;
> >+		goto err;
> >  	}
> >-	return -EIO;
> >+
> >+	return 0;
> With initialized value you can use
> return ret;

hmm, I guess I did that on a follow up patch where I grouped the stop
handling.

--=20
balbi

--1ozVqH6bFr/3sC51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiTM6AAoJEIaOsuA1yqREerEP/jprc6vBFjzwzRSyIpgZmI07
zqIUHWHelrI4f1sCNYY97IDsttALvOKW+FppCIEXjudfLlZCJruxK27k9nYdRbTd
RkAIhQyXHC6vwIYm5erj/g26TNe+CE+zT7W9VQ1Bu61irLhlYM8VJwCwLqumYrGh
bhP7CsEFnAu8BTCGamroeGKJ/BWM/gqcgU02ZpqqQfbRiCs2g8u1D0CFbE8yGfGJ
lsz1seb0896TbsgkBIlxSEMiTP8RQZBC2yqqGj/EXHBBddI8UIBUsxkjpOJrjFKa
5W0UuCfRB31Vpuk8QVJhhXWoc+DbDs4e4I6GqqbvauNo+I18r16brrtpDhRh3cDt
vMwBj8FIWutT4hB7QCYFE3Fr9/kZVylYpsEHrztJVka6VZJD/ZVu8lstxcsauQw3
6byYTnnwCcGrD8664Kmd8LaTOs67V53Fw/QcoiGRuAZSn4f7+3enWUf43MfTdzZH
3J3+gFyLUgSCBHE88d10PRbk1yrGrh2pJsKL4KKwgMAp1EngNmm2hKcqZ3VQbKZB
+ID4RqKGXpWBX+ElWUaI26FdprGY2F4EyGz+w/CgntTMzSfWtctmTEvI6LebWnhz
cKGU0LW6PEuExVBoIm5a5r/qhF80ThVmo2f7bKTzVan6h4ZxVTOxfDbH3h9UxYgp
dN79sra5uRSKqIUqLuHu
=Z9jG
-----END PGP SIGNATURE-----

--1ozVqH6bFr/3sC51--
