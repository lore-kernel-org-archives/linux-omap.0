From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv1 07/14] drm/omap: add support for physical size hints
 from display drivers
Date: Wed, 26 Jul 2017 12:41:46 +0200
Message-ID: <20170726104146.GD3598@amd>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170724173311.27170-8-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1658586333=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170724173311.27170-8-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1658586333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-24 19:33:04, Sebastian Reichel wrote:
> While physical size information is automatically parsed for EDID
> based displays, we need to provide it manually for displays providing
> one fixed mode.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll4ceoACgkQMOfwapXb+vKLYACghN5DqbIgGQSwlVbxCrAiqDUV
2zsAn2nsOsYVmS/uQu04kqoFVVZ4iQdn
=Li7t
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--

--===============1658586333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1658586333==--
