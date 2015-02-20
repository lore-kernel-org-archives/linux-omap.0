From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Return correct error values from device and hwmod
Date: Fri, 20 Feb 2015 10:50:04 +0100
Message-ID: <201502201050.04334@pali>
References: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com> <20150220082226.GB14057@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6393971.hWtle2QBfc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220082226.GB14057@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart6393971.hWtle2QBfc
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 February 2015 09:22:26 Pavel Machek wrote:
> On Fri 2015-02-20 00:41:41, Pali Roh=C3=A1r wrote:
> > Without this patch function pm_runtime_get_sync() returns 0
> > even when some omap subfunction fails. This patch properly
> > propagate error codes from omap functions back to caller.
> >=20
> > This patch fix problem, when loading omap-aes driver in qemu
> > cause kernel oops.
>=20
> "fixes"
>=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> > @@ -3350,16 +3350,17 @@ int omap_hwmod_enable(struct
> > omap_hwmod *oh)
> >=20
> >   */
> > =20
> >  int omap_hwmod_idle(struct omap_hwmod *oh)
> >  {
> >=20
> > +	int r;
> >=20
> >  	unsigned long flags;
> >  =09
> >  	if (!oh)
> >  =09
> >  		return -EINVAL;
> >  =09
> >  	spin_lock_irqsave(&oh->_lock, flags);
> >=20
> > -	_idle(oh);
> > +	r =3D _idle(oh);
> >=20
> >  	spin_unlock_irqrestore(&oh->_lock, flags);
> >=20
> > -	return 0;
> > +	return r;
> >=20
> >  }
>=20
> Normally, such variable is called ret or res...
>=20
> 									Pavel

In other parts of this code is used name "r" not "ret".

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6393971.hWtle2QBfc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTnA0wACgkQi/DJPQPkQ1KrGQCeOP88CjlhSwJkQfoquq7EhzmH
ikMAnRoROXHo2jfuIJb3abSPyZCZ1FMt
=hEZh
-----END PGP SIGNATURE-----

--nextPart6393971.hWtle2QBfc--
