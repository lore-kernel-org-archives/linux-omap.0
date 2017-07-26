From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv1 02/14] drm/omap: drop incorrect comment
Date: Wed, 26 Jul 2017 12:40:00 +0200
Message-ID: <20170726104000.GB3598@amd>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170724173311.27170-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0318132000=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170724173311.27170-3-sebastian.reichel@collabora.co.uk>
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


--===============0318132000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-24 19:32:59, Sebastian Reichel wrote:
> The wrappers have been removed in commit 5a35876e2830
> (drm: omapdrm: Remove manual update display support)
> and will not be reintroduced, since the normal sys
> functions properly call the dirty callback.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/gpu/drm/omapdrm/omap_fbdev.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapd=
rm/omap_fbdev.c
> index daf81a0a2899..929a3ef0fba0 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> @@ -84,9 +84,6 @@ static struct fb_ops omap_fb_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	DRM_FB_HELPER_DEFAULT_OPS,
> =20
> -	/* Note: to properly handle manual update displays, we wrap the
> -	 * basic fbdev ops which write to the framebuffer
> -	 */
>  	.fb_read =3D drm_fb_helper_sys_read,
>  	.fb_write =3D drm_fb_helper_sys_write,
>  	.fb_fillrect =3D drm_fb_helper_sys_fillrect,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll4cYAACgkQMOfwapXb+vKXUQCgsPMQ55MURJ69/t0shRZy2aM0
Fg0Anj2Grq9tSlaVAepYwTW78y6N8Vhm
=xyXx
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============0318132000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0318132000==--
