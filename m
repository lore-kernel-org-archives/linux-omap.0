From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 12/33] Add tsc2005 touchscreen driver
Date: Mon, 1 Sep 2008 10:34:37 +0300
Message-ID: <20080901073437.GB12775@intune.research.nokia.com>
References: <1220116593-862-5-git-send-email-me@felipebalbi.com> <1220116593-862-6-git-send-email-me@felipebalbi.com> <1220116593-862-7-git-send-email-me@felipebalbi.com> <1220116593-862-8-git-send-email-me@felipebalbi.com> <1220116593-862-9-git-send-email-me@felipebalbi.com> <1220116593-862-10-git-send-email-me@felipebalbi.com> <1220116593-862-11-git-send-email-me@felipebalbi.com> <1220116593-862-12-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com> <fb249edb0808311801n45a798dbkbfb37927335d00ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48340 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbYIAHdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:33:17 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0808311801n45a798dbkbfb37927335d00ab@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext andrzej zaborowski <balrogg@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2008 at 03:01:43AM +0200, ext andrzej zaborowski wrote:
> 2008/8/30 Felipe Balbi <me@felipebalbi.com>:
> > [roughly 470 irrelevant lines discarded]
> > +       /* discard the event if it still is within the previous rect - =
unless
> > +        * if the pressure is harder, but then use previous x,y positio=
n */
> > +       inside_rect =3D (ts->sample_sent &&
> > +               x > (int)ts->x - TS_RECT_SIZE &&
> > +               x < (int)ts->x + TS_RECT_SIZE &&
> > +               y > (int)ts->y - TS_RECT_SIZE &&
> > +               y < (int)ts->y + TS_RECT_SIZE);
> > +       if (inside_rect)
> > +               x =3D ts->x, y =3D ts->y;
> > +
> > +       if (!inside_rect || pressure < ts->p) {
> > +               tsc2005_ts_update_pen_state(ts, x, y, pressure);
> > +               ts->sample_sent =3D 1;
> > +               ts->x =3D x;
> > +               ts->y =3D y;
> > +               ts->p =3D pressure;
> > +       }
>=20
> Minor nit: will this not break ts_calibrate from tslib? ts_calibrate
> tries to read 5 samples for every touch, so the user will need to be
> moving the pen. I hit this in emulators where noise needs to be added
> artifically because userspace (tslib) relies on it.
> Also curious why report if pressure becomes harder but not when softer.

Works fine for us, but of course that depends on your tslib
configuration.  We decided to remove the filtering and whathaveyou from
tslib and in a novel move, actually receive useful and correct events
=66rom evdev, instead of something that needs to be subjected to further
arbitrary filtering to be usable.

Cheers,
Daniel

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki7mw0ACgkQ68xJuWtYYdUYQgCgtmzNuUOSvH60rElX2ncu9CxU
Mw8AnjAF+4LL6efeqaMVFvjJF1ia7HD7
=WvV6
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
