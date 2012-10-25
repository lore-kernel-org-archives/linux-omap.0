From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/8] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
Date: Thu, 25 Oct 2012 15:01:40 +0300
Message-ID: <20121025120140.GP21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-3-git-send-email-balbi@ti.com>
 <CAM=Q2cvUeLbS20HScrGTOcraSUrCzhzCi8MQLxd9MOb_7ZFFYA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="movZSYdJ761vCHaE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cvUeLbS20HScrGTOcraSUrCzhzCi8MQLxd9MOb_7ZFFYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--movZSYdJ761vCHaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 05:10:10PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Oct 22, 2012 at 3:16 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > just a cleanup patch trying to make exit path
> > more straightforward. No changes otherwise.
> >
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
> > index c07d9c4..bea0277 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -505,6 +505,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
> >  {
> >         struct omap_i2c_dev *dev =3D i2c_get_adapdata(adap);
> >         unsigned long timeout;
> > +       int ret;
> >         u16 w;
> >
> >         dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d=
\n",
> > @@ -582,31 +583,38 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *=
adap,
> >         dev->buf_len =3D 0;
> >         if (timeout =3D=3D 0) {
> >                 dev_err(dev->dev, "controller timed out\n");
> > -               omap_i2c_init(dev);
> > -               return -ETIMEDOUT;
> > +               ret =3D -ETIMEDOUT;
> > +               goto err_i2c_init;
> >         }
> >
> > -       if (likely(!dev->cmd_err))
> > -               return 0;
> > -
> >         /* We have an error */
> >         if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> >                             OMAP_I2C_STAT_XUDF)) {
> > -               omap_i2c_init(dev);
> > -               return -EIO;
> > +               ret =3D -EIO;
> > +               goto err_i2c_init;
> >         }
> >
> >         if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
> >                 if (msg->flags & I2C_M_IGNORE_NAK)
> >                         return 0;
> > +
> >                 if (stop) {
> >                         w =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> >                         w |=3D OMAP_I2C_CON_STP;
> >                         omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> >                 }
> > -               return -EREMOTEIO;
> > +
> > +               ret =3D -EREMOTEIO;
> > +               goto err;
>=20
> This adds reset to nack may be that can be removed.

great catch. I will respin this series.

thanks

--=20
balbi

--movZSYdJ761vCHaE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiSokAAoJEIaOsuA1yqREJsIQAJjcmj1xNrdPh4Bgsz6tGWK7
eohuhwd0QBntKHyhyEvLtebCqwdCFbXOGGURYLZsJckPjjvMySy0/raCjrwY3p7F
wlDZvy/6tsgIzUeadZ9/HoyJ9BQ5QPJ5koJd7v5YB9sd/4Ul75a7piN3ctKULjm4
VEImRMPUCroVQcT15FvX9jeXNdUyud/mGyF7Xx2+PNDOWkQfUEQZGf1wcjmgENGU
6leRvRUkeOZ8NU871oGCPFvejw8T8g2okPWW0LlfTqkfS1II09zmTHaOB02N+QR5
3XPtl6aBdZEW8RQ2dVBqpQGTByRhPQ/wveev1I0tVhgUrobAx5e/qPoKJj0MpiMH
MzHBEYTyXZZYCNkQKyNahlLvsDe4ldJ9eowwxP+v3iHL2qncK5Et1oJuEJpcLVZa
fN2ibyyHaIJt8r0ZiFSd30vJw2r17DtkmcQGFR8OUHqHdTgePptNC5G2n1pm80i1
iWqWGN3cfP2fq65e4gADRs7zBTYC52HSspsnHm5oDa54Fe4o+NovQ5mdH63Uhh2N
AZQVyuyLfV5+TGRiSKDDc9xFvx3jV2T5zO1dqqAMaV+zhJ2U0W/Rv6E5IdPxNmh4
s/uxgHX5Nh6m0fb12gTfy7kpD5QgTSTRXpe0O+BwFo0JbyJZ0jKTdgf81cvyWMvw
ctYb65TPXyuc1I6HgGGI
=0Pvw
-----END PGP SIGNATURE-----

--movZSYdJ761vCHaE--
