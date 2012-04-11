From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 14/18] I2C: OMAP: Use SET_RUNTIME_PM_OPS
Date: Wed, 11 Apr 2012 15:10:58 +0300
Message-ID: <20120411121056.GJ12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
 <20120411113537.GG12064@arwen.pp.htv.fi>
 <1BAFE6F6C881BF42822005164F1491C331829571@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hvDi6/M7gW6JbuLr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52144 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667Ab2DKMLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 08:11:48 -0400
Received: by lbbgi11 with SMTP id gi11so589064lbb.38
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 05:11:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C331829571@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "tony@atomide.com" <tony@atomide.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--hvDi6/M7gW6JbuLr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 12:09:22PM +0000, Hebbar, Gururaja wrote:
> Bablpi,
>=20
> On Wed, Apr 11, 2012 at 17:05:38, Balbi, Felipe wrote:
> > On Wed, Apr 11, 2012 at 04:42:52PM +0530, Shubhrajyoti D wrote:
> > > Use SET_RUNTIME_PM_OPS macro to set runtime functions.
> > >=20
> > > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > > ---
> > >  drivers/i2c/busses/i2c-omap.c |   11 ++++-------
> > >  1 files changed, 4 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> > > index dd65416..28de1d2 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -1217,15 +1217,12 @@ static int omap_i2c_runtime_resume(struct dev=
ice *dev)
> > > =20
> > >  	return 0;
> > >  }
> > > +#endif
> > > =20
> > >  static struct dev_pm_ops omap_i2c_pm_ops =3D {
> > > -	.runtime_suspend =3D omap_i2c_runtime_suspend,
> > > -	.runtime_resume =3D omap_i2c_runtime_resume,
> > > +	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> > > +			   omap_i2c_runtime_resume, NULL)
> > >  };
> > > -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> > > -#else
> > > -#define OMAP_I2C_PM_OPS NULL
> > > -#endif
> >=20
> > I think you should keep this define, otherwise the pm pointer will
> > always be valid.
>=20
> No. using SET_RUNTIME_PM_OPS will make it NULL when !CONFIG_PM_RUNTIME
> Kindly correct me if I am wrong.

you will have a defined structure with NULL members, but the structure
itself is still valid.

--=20
balbi

--hvDi6/M7gW6JbuLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhXTQAAoJEIaOsuA1yqREV6IP/jeBS/+15Q76Rfog1sHSBPnH
u+qVOwmg6H/x4JAb1VRFSIKhal9WbmD7Py1na8tEtJ/qTx3FZi4Mgir4gJ+zz5+I
mtmkuTeE54B1UDaYdJy3vtPYPGkNYarz/L9Mo/sr6CNTVghg6X49PByLRzNpjy8I
mgE4LQNOtfcvzLwIFNgUaVxcMMiBjvd22U5JzVB9XpBcFVg0SRby1ViHjQ39rE2O
g9WbIleP8QrG12yt3GJZcqLJPh9+jgyhvNQ6kHnhjajSXaPRQCSJyMFHEAzKG17B
oO1khoa37GmCUzUtaS2sQvEJnsC1lBKRwplYCs2L/shztJtijEr7jikBRxxujERm
2fFpVflW5sTIqLQO3i9oP7VZv9OlY6qUyh0mpw0X82W2KgZJwY9CsW05l0P90FgO
wDYnYy6tGBQTtsVzg5miI77Ve9/B7XIl5scfbxTrCC1YGs69RSUpDLitLOUIO3ZE
sUjXe9THxjR4lkiYyOzo4ajGZK6vn0F5yeqT5Cg9wwgOAbiArwMlqVEF0eKW33zN
N4+t0sIOqFrpNRa0CigjrME96+6N7s5a/l5kWoWjBtoTYcejivjnYiscHcwOvDtw
wE32qa0ikzOXNu14StRxYi4KLEJOK6l2XtdQndJA33lsXa8+t1zFzP2Y4Tk7t7ye
jQE6orVcDOREJab2bx31
=6t6+
-----END PGP SIGNATURE-----

--hvDi6/M7gW6JbuLr--
