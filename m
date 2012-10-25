From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 10:03:50 +0300
Message-ID: <20121025070349.GA5259@arwen.pp.htv.fi>
References: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
 <20121025063608.GA5084@arwen.pp.htv.fi>
 <CAM=Q2cvzQ7fVL1-vUpWZdwhGk3s0GpO3uG3MH9CAzBvyeSftKQ@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cvzQ7fVL1-vUpWZdwhGk3s0GpO3uG3MH9CAzBvyeSftKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 12:23:56PM +0530, Shubhrajyoti Datta wrote:
> >> @@ -1268,23 +1276,8 @@ static int omap_i2c_runtime_resume(struct devic=
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
> >> +     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> >> +             __omap_i2c_init(_dev);
> >>
> >>       return 0;
> >>  }
> >
> > you continue to miss the changes in omap_i2c_xfer_msg() and your
> > explanation of why not doing it wasn't good enough IMHO.
>=20
> Will do that . I am preparing a seperate patch for moving the
> calculation to a seperate function.

why do you need yet another function ? omap_i2c_init() does all
calculation and __omap_i2c_init() doesn't do any calculations. What's
the point for yet another function ?

--=20
balbi

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiORVAAoJEIaOsuA1yqREXKcQAJOMG185ltstM8rsworPylCc
Z2I67tx33pKCKuW3WdxtlDzipXYKjxFD8roLfHvp5zgFGdT5O3yUZGq1x260SDkm
dgHg/tKM/2KvRoWZm2zviybfuBHeXEjdHj+X2YBvr1Ox65mpntvVPoxYXgN57itz
9ET31l5nkHGj+9Bc0PaY2ylEMA1SyMbWMHCY5Rpcrx+vSkJP8r+1C/8pTIteQfgO
VMBL6vPfRfFUFUBEcxbpQ8T/BHQD0kBrHR54R9hKqVyLImtno6iVAsoyBzM1KGMy
rL0/5XWQlmiEvwnpkyCn1HeTrFyS8H5OZp8P1WG0rGHeU3qlosjGruM9iyMtq1nQ
y1T1z4J82PVLOVAw0hZUobC86FwxkEAklfL2/fAxD7BJcNvbnzUyy2m/4ii3Nadi
u3W9rZzZ1nTwAn0xBoes4DcUv+lPEt10t59c73qwOCQnwQCcrwOhwNPFfISQIvtO
UU9XBmut+yupr+ZQw0hvWlKKo11sN2UFThtTU6xJfr297Ack7UeK31IwSvUkjyCf
Wbuh6y9CsLCN9+UbJzz/fOBGK5pzVkDD5xH6tknu5adeFk1eWTlbTeGEqZXY/yN2
FcJCmAtY5VapDBU99SaFWK5hB+DLha5LZPsO2UoKW7iUaVLxWpq6IGXF0rMwjg2H
LPYm+bml0STY/2CCZ+9i
=vwtM
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
