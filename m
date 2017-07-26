From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv1 01/14] drm/omap: remove unused function defines
Date: Wed, 26 Jul 2017 12:39:54 +0200
Message-ID: <20170726103953.GA3598@amd>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170724173311.27170-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724173311.27170-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-24 19:32:58, Sebastian Reichel wrote:
> Remove driver (un)register API defines. They do not even exist
> anymore.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
>  drivers/gpu/drm/omapdrm/dss/omapdss.h | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omap=
drm/dss/omapdss.h
> index 85953a0bc7c2..4e619ff360ae 100644
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
> @@ -575,9 +575,6 @@ struct omap_dss_driver {
>  enum omapdss_version omapdss_get_version(void);
>  bool omapdss_is_initialized(void);
> =20
> -int omap_dss_register_driver(struct omap_dss_driver *);
> -void omap_dss_unregister_driver(struct omap_dss_driver *);
> -
>  int omapdss_register_display(struct omap_dss_device *dssdev);
>  void omapdss_unregister_display(struct omap_dss_device *dssdev);
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll4cXkACgkQMOfwapXb+vIBBwCeMOYXJ7wTOspRQ2fCKXS9ogKV
AxUAnjezozEOWfBms7UzjaIiuUqStIjr
=8lm0
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
