From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 6/6] drm/omap: add support for manually updated displays
Date: Sat, 17 Nov 2018 22:16:54 +0100
Message-ID: <20181117211654.GF22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-7-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115230645.15748-7-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-16 00:06:45, Sebastian Reichel wrote:
> This adds the required infrastructure for manually updated displays,
> such as DSI command mode panels. While those panels often support
> partial updates we currently always do a full refresh.
>=20
> The display will be refreshed when something calls the dirty callback,
> such as libdrm's drmModeDirtyFB(). This is currently being done at least
> by the kernel console and Xorg (with modesetting driver) in their
> default configuration. Weston does not implement this and the fbdev
> backend does not work (display will not update). Weston's DRM backend
> uses double buffering and the page flip will trigger a display refresh
> and seems to work as expected.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -708,6 +802,18 @@ struct drm_crtc *omap_crtc_init(struct drm_device *d=
ev,
>  	omap_crtc->channel =3D channel;
>  	omap_crtc->name =3D channel_names[channel];
> =20
> +	/* We want to refresh manually updated displays from dirty callback,

Nit: Comment style does not match coding style.

/*
 *
=20
 --- a/drivers/gpu/drm/omapdrm/omap_fb.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
> @@ -66,8 +66,49 @@ struct omap_framebuffer {
>  	struct mutex lock;
>  };
> =20
> +/* iterate thru all the crts, returning ones that are attached to the sa=
me fb */

Start with big letter -- "Iterate"?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwhUYACgkQMOfwapXb+vIwmACgmQSHKnhiC3jfU26uR+CQd5Xt
g68An2QryM9tFC2f7GFUwfqNXfOx5qv/
=/SeM
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
