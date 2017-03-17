From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 01/10] drm: omapdrm: panel-dsi-cm: Fix probe for device
 tree
Date: Fri, 17 Mar 2017 16:26:31 +0100
Message-ID: <20170317152631.GG8723@amd>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1510902059=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1510902059==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-03-05 01:43:00, Sebastian Reichel wrote:
> From: Tony Lindgren <tony@atomide.com>
>=20
> Things are a bit whacked right now for panel-dsi-cm:
>=20
> 1. We're missing call to of_get_display_timing() and
>    videomode_from_timing()
>=20
> 2. We need to call dsicm_probe_of() after we initialize the
>    default values to not overwrite device tree configured
>    values
>=20
> 3. We need to implement minimal get_timings() and check_timings()
>    for the panel to work
>=20
> With these changes we get panel-dsi-cm to probe with device tree
> configuraion. Note that the dsicm_check_timings adapted from an

Typo: configuraion.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljMACcACgkQMOfwapXb+vKNCgCgqeEYa/TrQgEHOajd8RxOztTS
cVoAoKj8YjBg3HVdahp9U6Ylm/JREyL3
=qsWE
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--

--===============1510902059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1510902059==--
