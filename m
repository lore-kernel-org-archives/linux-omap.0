From: Pavel Machek <pavel@ucw.cz>
Subject: 4.19-rc1 on droid 4: screen not updating
Date: Mon, 27 Aug 2018 12:51:21 +0200
Message-ID: <20180827105121.GA8283@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1409878413=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============1409878413==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

With Sebastian's patches, display works on Droid 4 in v4.18.

I had to do some manual merging, and I see kernel messages in
v4.19-rc1, but they are frozen -- no updates.

a) does someone have it working?

b) is there some way I can help to get it working in mainline? Droid 4
is not exactly new, and this is painful point that makes it hard to
use.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluD16kACgkQMOfwapXb+vJblACdHXOXvPRQ/+viYV8Sr/th4GJ5
fMwAn1iKDSz8ZX/ZMlW2LtrWWEgkLRwg
=1miq
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============1409878413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1409878413==--
