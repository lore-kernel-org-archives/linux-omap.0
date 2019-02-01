From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4 modem support in kernel & ofono
Date: Fri, 1 Feb 2019 21:36:16 +0100
Message-ID: <20190201203616.GA2087@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, so I got calls and smses somehow working in kernel&ofono ... which
is really all I need.

I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
d4... But I had to do some "rather interesting" hacks. D4 modem
expects packets and current kernel drivers rely on write() boundaries
and flush(). .. which is a bit of problem for in ofonod, as it expects
to work with bytestream with no explicit packet boundaries.

However D4 still uses normal AT commands, so... it would be good to be
able to use AT parsing framework in ofono.

I believe easiest solution would be to automatically do the packet
splitting in kernel, it should be as easy as splitting on \r and
^Z. (Currently packets are only generated when \r or ^Z is seen on
write boundary, but that does not work well for ofono).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxUrb8ACgkQMOfwapXb+vL9DQCgr4uvxr+ygZ6U/zYLogeQqdV3
6AIAn0lWzuae8f5IrQQWfPp2WFP3He0p
=CqWQ
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
