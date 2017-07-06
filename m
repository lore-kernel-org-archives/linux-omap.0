From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.13-rc0 on nokia n900: spinlock bad magic
Date: Thu, 6 Jul 2017 21:39:23 +0200
Message-ID: <20170706193922.GA31830@amd>
References: <20170706180337.GA26875@amd>
 <201707062015.54343@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201707062015.54343@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Thursday 06 July 2017 20:03:37 Pavel Machek wrote:
> > Hi!
> >=20
> > I don't think this is new in v4.13, but perhaps someone knows how to
> > debug it?
> >=20
> > [ 5611.801147] g_ether gadget: packet filter 0e
> > [ 5611.801177] g_ether gadget: ecm req21.43 v000e i0000 l0
> > [ 5668.771453] BUG: spinlock bad magic on CPU#0, kworker/u2:3/9745
> > [ 5668.771850]  lock: 0xce63ef20, .magic: 00000000, .owner:
> > <none>/-1, .owner_cpu: 0
> > [ 5668.772277] CPU: 0 PID: 9745 Comm: kworker/u2:3 Tainted: G      =20
> > W 4.12.0-03002-gec979a4-dirty #40
> > [ 5668.772796] Hardware name: Nokia RX-51 board
> > [ 5668.773071] Workqueue: phy1 wl1251_irq_work
>=20
> I do not remember that I saw this problem.

I guess I have some debug options enabled... do you want a .config to
play with?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllekeoACgkQMOfwapXb+vK5XwCdExzMPRaMdYya/aeOjUI+r0IZ
OGYAoJFRJdhcddRdK+aylvPWvRXiYpeM
=J00E
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
