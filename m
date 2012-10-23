From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: re-factor omap_i2c_init function
Date: Tue, 23 Oct 2012 20:57:06 +0300
Message-ID: <20121023175706.GC32517@arwen.pp.htv.fi>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
 <20121023171840.GA32167@arwen.pp.htv.fi>
 <CAM=Q2cs-+O_BFrZFX4fuBooogEZiQO2Zxbm8W40vN9hmampLCA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cs-+O_BFrZFX4fuBooogEZiQO2Zxbm8W40vN9hmampLCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2012 at 11:26:15PM +0530, Shubhrajyoti Datta wrote:
> >> @@ -1268,23 +1271,8 @@ static int omap_i2c_runtime_resume(struct devic=
e *dev)
> >>  {
> >>       struct omap_i2c_dev *_dev =3D dev_get_drvdata(dev);
> >>
> >> -     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstat=
e);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllst=
ate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhst=
ate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstat=
e);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscst=
ate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_=
EN);
> >> -     }
> >> -
> >> -     /*
> >> -      * Don't write to this register if the IE state is 0 as it can
> >> -      * cause deadlock.
> >> -      */
> >> -     if (_dev->iestate)
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
> >
> > this part is not on __omap_i2c_init() so you're potentially causing a
> > regression here.
>=20
> iestate is set at init so cannot be zero. so the check was removed.

so you never read it back ? Then you need to add a note for that in
changelog, since this is a behavior change ;-)


--=20
balbi

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhtpyAAoJEIaOsuA1yqREBOUQAJlzewx6t4lR6gdufvPBC91Y
k0S8qDCe+IfnIMbyMWUSOYSmDROirz6u9xMnBxQR6LvuD/qN2a3/DYq/uHiuWYco
xFLgGn0rgpPtBFIy6z9gLlko5gvPYXXti2bA7+kF2rOcCFXPlWLtpsvbKtrVAnIM
WCmJ6v3jJYVavqt039RoC9ZRCwD8qvgC2alG04QuQBAjMrCN338wtwbw+TMDJIf+
hOBvnfghutDlbTg6w9RJR8hbWxRcrrLHQdoOo68neJCp1j8MZO+nMo+apb0CEsZP
r7pdd6q7CZKkaFC+ISfSPIzNlcwD3y/ED2Cyf9UWbH0K0rIPyIW362ownIdz410X
PLTzxr/d4JTg9lCROe56VnU9eLa+aycyb1bALeky7tqTbvpioNWV9K784fLa2VqW
rCNex0hVZ38/9rClQIGSx0zo4CABeFeXlF/crh4kWg6PIaU02qHLuAN/evF6k54F
YXG6+dPofYjZSoMYj6RFT1sY01tbKzATzO7skfd7IVANaYzd7nKadiTrbvDAYVtD
8esOvmBw6pjK5fGvqSzCjOsJ1ikWH8b/Aq+2YEiWKgo4GZizC6QPKj0UzLZ5LeuS
GoJOW0GuEcYYM3uTyZgWZnEziSfghSaA+E4jnOiru6xZrGz5ZGIInc5rDaUJTuYJ
IeDsRS5kudbtRoU9P/Cj
=YFWg
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
