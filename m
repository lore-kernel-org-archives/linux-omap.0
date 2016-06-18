From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 00/19] Runtime PM fixes for omap-ssi
Date: Sat, 18 Jun 2016 22:21:00 +0200
Message-ID: <20160618202059.GA5510@earth>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
 <20160618185438.GA8866@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160618185438.GA8866@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 18, 2016 at 08:54:38PM +0200, Pavel Machek wrote:
> > This series fixes runtime PM for omap-ssi, so that
> > the OMAP SoC can idle correctly. After applying the
> > series, the SSI module correctly goes into idle if
> > phonet0 interface is not configured or if it's
> > used by ofono (*). Apart from me Pavel Machek did
> > some testing of my devel branch [0] and reported,
> > that he was able to get the phone into full idle.
> >=20
> > Note: I did my testing with kernel flashing over USB, so
> > idle is broken. But I found the bit in cm_idlest1_core,
> > that stands for SSI blocking status: 0x00800000 (documented
> > as "reserved" in the public TRM).
> >=20
> > (*) "ifconfig phonet0 up" will result in blocking ssi module
> >     until modem setup has finished (data communication via
> > 	phonet0 device), since it enables ssi wakelines.
> >=20
> > [0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/=
?h=3Druntime-pm-fixes
>=20
> I tried applying it over v4.7-rc, but [...]
> What tree should I try it against?

The patchset is based on hsi's for-next branch available here:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=3Dfor=
-next

You can try to apply it directly on 4.7 by changing "hsi_core.c" to
"hsi.c" or by applying this additional patch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
for-next&id=3De01957abd4cb3816a1eaaf191b16de182ebb333e

-- Sebastian

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZa0oAAoJENju1/PIO/qayzcP/RtKVYPHXTyXw+VIZ7AHAtgk
KJJ6PKBrgT49qUj0mfAyW3SAGHpZYgPvcBq+fKjz6uM85DWdOpkzQHe6z3si71BQ
9iZqQuj9u5tsq7YQoHU8VVkYWHzo1YMgGfGUieIFyIkW3Rx/td+hpmSp67dyO2RK
jaU1tn732km2nIO0JsIvM4+Rs9Mywn/8zR8IYWJi70fGk2pPcJv2eIg7zEbk2baD
0dfle8vRUvYykRJ/CLHpvnpVZ9k0A/QYuUMkh5tj7XS7xQZ0sp0fWfLl8CTaPHPH
zFavBFXFoDzn8Zqi5BiDvoXk27LHiiCuDPWX4et3wIqcwjJsj6tsdY5vzHJWGX4/
Valenu+Cxj3ly5fBBf9dOxx7F+BYJHdAIbIGDCbtelgvxFJtj2h7rv7I4sagOgzk
EUMT7XbAgMcVCyokr674OFh63N3EE9yhN3EYlDqKTZBW4zp3Y//yKDvrr15xtMQ0
xoVBsQab62Oyn3grZyqEg7L7mO+Q38oWOBNhaZYWJbKZE27NQVFnoybmpW+jeyh5
gs5DeYU4PKXep9fepg1b3LZJdzrLg5qcf2gXqzSpchDmJijHX6JASWi0pviR5Uky
LNr3xgitC9pc/vwq7at5QTuYI7SxYipEV+oIgrDpkPpyePhzqrOn08VrMn6PfjpN
AJbpTZPf4j3M1/NzcKiy
=tyV4
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
