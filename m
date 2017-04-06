From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 failure in next-20170321
Date: Thu, 6 Apr 2017 20:13:18 +0200
Message-ID: <20170406181318.GE10363@amd>
References: <20170321135708.GA22358@amd>
 <20170321153851.GA10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321153851.GA10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-03-21 08:38:52, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [170321 06:59]:
> > Hi!
> >=20
> > Tony asked me to test linux-next from time to time. I did... today I
> > moved from next-20170309 to next-20170321. Kernel boots and seems to
> > work fine (including audio and X startup), but if I leave it sitting
> > for a while RGB LED reverts from "system alive" to charging indication
> > that was disabled before and system does not react to any input.
> >=20
> > Any ideas?
>=20
> Not much there I could see affecting this.. Try reverting commit
> 179125085bd4 ("ARM: OMAP3: Fix smartreflex platform data regression")?
>=20
> Maybe smartreflex now attempts to do something but we're missing
> or have wrong dts configuration for n900?

I tried today's next, and it did not hang for a few hours. So I guess
problem is gone now.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljmhT4ACgkQMOfwapXb+vJhBQCgpd7p/exdE+fGsTKcrLmD6x+I
xw8An1O5M9tMg4IhMiVOoubp4VNS9mTK
=DsTG
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
