From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] arm, fbdev, omap2, LLVMLinux: Remove nested function
 from omapfb
Date: Sat, 27 Sep 2014 11:46:46 -0500
Message-ID: <20140927164639.GB7076@saruman>
References: <1411780253-4492-1-git-send-email-behanw@converseincode.com>
 <1411780253-4492-3-git-send-email-behanw@converseincode.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411780253-4492-3-git-send-email-behanw@converseincode.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Behan Webster <behanw@converseincode.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@ffwll.ch, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, robdclark@gmail.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 06:10:53PM -0700, Behan Webster wrote:
> Replace the use of nested functions where a normal function will suffice.
>=20
> Nested functions are not liked by upstream kernel developers in general. =
Their
> use breaks the use of clang as a compiler, and doesn't make the code any
> better.
>=20
> This code now works for both gcc and clang.
>=20
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJun2AAoJEIaOsuA1yqREZOsP/jkvwOXOIAl1Y076UospTf4u
M8DeRHJx8MLor1oPixp0BPxLxLJI+PnLHjn2c0v+shrvgkjbw07UQlJ3F7NSO1q3
Ehhbe0EBKnQDRfvxN5YkA5MJs1a1w/V8MPokKMo/525y9yaaVoD87fgKNNA3uz1c
aUU0bYyLUxeviQ1YSzEzfOeodrDksSNeKqsqgbQIZyl8s1aw2/d2Ek/88u92DTNp
WGM3wAt0c+XYHucUG5YJwBV5kF3C4UVWTN9pjPE5jhEwkWEBnprmg4iFkeABRleo
2qjHJrby2TClpBCCPGfwNxgZjdaHXAkLqoZsVy51PK1ztSWscxcbDsvcjj/Rtp3d
utWsBoS18U9RAtjaYa0nz7SYDRB6XgVeKPJ9EARTosj2Afw10Nc6saVIgXqwgLyP
80+L9pcwCW4n8KVKhpROUf1E/vhNWTtlVI/7KsB5G2XZCPiNmWOfWwm7Bog7XxST
myKIe+W9MtRx3fw2Yk+dEBhwLZAWna1aRbmebs3tjhj763fPnrkDJU1h1cgsvZO/
O265yKDHUmxTWRmIquBvVuglL5iAYNKHNVemjcT5XenX+hz4JuPKR27xehyFlfup
O0p2jpIJTRYnwJmH93PRsw3cu7N9h8pHn96bJxU3+AUoO+N+pSxszz1vvhn4IZS3
C0Ew/UoZe/tPOeRRDGkR
=cC3G
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
