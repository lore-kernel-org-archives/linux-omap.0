From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 5/6] drm/omap: add framedone interrupt support
Date: Mon, 19 Nov 2018 13:12:56 +0100
Message-ID: <20181119121255.GA23830@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-6-sebastian.reichel@collabora.com>
 <20181117210840.GE22813@amd>
 <20181119120520.qaw6qyxyirjahzcn@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119120520.qaw6qyxyirjahzcn@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > @@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void=
 *arg)
> > > =20
> > >  		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc=
, channel))
> > >  			omap_crtc_error_irq(crtc, irqstatus);
> > > +
> > > +		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc=
, channel))
> > > +			omap_crtc_framedone_irq(crtc, irqstatus);
> > >  	}
> > > =20
> > >  	omap_irq_ocp_error_handler(dev, irqstatus);
> >=20
> > Will the mgr_get_framedone_irq(priv->dispc, channel) change from
> > interrupt to interrupt? Would it make sense to cache result as a
> > micro-organization?
>=20
> Maybe. But this is the same for the the omap_crtc_error_* and the
> driver is currently being restructured by Laurent. I think this can
> wait for later.

Definitely can wait. Thanks!
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvyqMcACgkQMOfwapXb+vLKEQCguFqQy6jtv4eZceDfUNekH+qR
aH8AoIX7+XSfUcSfq2/GTH5MAosrnf8z
=2qsH
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
