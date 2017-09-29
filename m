From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Fri, 29 Sep 2017 15:26:49 +0200
Message-ID: <20170929132649.63dy7mzjgknaevoa@earth>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zakfdqd34v2mc5zq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org


--zakfdqd34v2mc5zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi & Laurent,

ping?

-- Sebastian

On Mon, Jul 24, 2017 at 07:32:57PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> This adds support for command mode DSI panels to
> omapdrm. I tested the patches on Nokia N950 (omap3)
> and Motorola Droid 4 (omap4). This is basically
> PATCHv3 of my series adding N950 display support,
> but I started from scratch without reverting the
> removal of manual display update support.
>=20
> Tested:
>  * Framebuffer Console
>  * Display blanking
>  * kmstest
>  * Xorg with omap and modesetting driver
>  * No updates send when nothing needs to be sent
>=20
> Known issues:
>  * Proper display rotation support
>  * N950 (and N9) has first and last few lines
>    covered by plastic, so we should expose a
>    smaller screen
>=20
> I plan to look into these issues once basic support
> has been merged.
>=20
> -- Sebastian
>=20
> Sebastian Reichel (13):
>   drm/omap: remove unused function defines
>   drm/omap: drop incorrect comment
>   drm/omap: plane: update fifo size on ovl setup
>   drm/omap: add framedone interrupt support
>   drm/omap: add manual update detection helper
>   drm/omap: add support for manually updated displays
>   drm/omap: add support for physical size hints from display drivers
>   drm/omap: panel-dsi-cm: add regulator support
>   drm/omap: panel-dsi-cm: add physical size support
>   drm/omap: panel-dsi-cm: add external backlight support
>   drm/omap: panel-dsi-cm: switch to gpiod
>   ARM: dts: omap4-droid4: improve LCD description
>   ARM: dts: n950: add display support
>=20
> Tony Lindgren (1):
>   drm/omap: panel-dsi-cm: fix driver
>=20
>  arch/arm/boot/dts/omap3-n950.dts                |  88 ++++++++
>  arch/arm/boot/dts/omap4-droid4-xt894.dts        |   6 +-
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 289 +++++++++++++++++-=
------
>  drivers/gpu/drm/omapdrm/dss/dispc.c             |  16 ++
>  drivers/gpu/drm/omapdrm/dss/omapdss.h           |   5 +-
>  drivers/gpu/drm/omapdrm/omap_connector.c        |  14 ++
>  drivers/gpu/drm/omapdrm/omap_crtc.c             | 158 ++++++++++++-
>  drivers/gpu/drm/omapdrm/omap_drv.h              |   4 +
>  drivers/gpu/drm/omapdrm/omap_fb.c               |  20 ++
>  drivers/gpu/drm/omapdrm/omap_fbdev.c            |   3 -
>  drivers/gpu/drm/omapdrm/omap_irq.c              |  24 ++
>  11 files changed, 529 insertions(+), 98 deletions(-)
>=20
> --=20
> 2.13.2
>=20

--zakfdqd34v2mc5zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnOShQACgkQ2O7X88g7
+prU9hAAlTXkjoJIWogqfnRIQsRrFeHDAeKsZZQFsaHe9MiWl3Pos6mNpzXYyzqE
G5GD6PAxokSDT7of/NoKmCBhEV7RpadSg/j1LxwRRDTSJHn4qR6EgV+dldZ4pQ5m
XIwfWiv7d+Leu0jN7vCIj0sRm6Kby6+W2las4J6fYlFjxqUmjyAvImhw8hE2Uvw8
VKEY2YLyHL5N9B0L6N9QsI4QzJOsXlbT/EBrmxupw76YK3N78XlM1rlk3V1VmENW
IbFdzjtQfHRQsAzf65QOOFeXOHwCuv4FY22zpjGoyRoBSSbLMrvcityCKJTD7+UX
GxXb7+9db9s33XrEcl0h5ySN7mG58tVwDd2EJzCwCHDECB6wzf4f4gg6nnNnPjuA
cEa6WbmmyM7EcYALw1HEls9zxqRmkJXXMEPmwk12wTygaPGkY1QYasCdaCWZJbfZ
XXwNKjSz0bDTQakWBpjT/Xz2YHCb4G8PcSktq6/rljOSa66Y2w2ln0SWCrr97A32
MWoBkWF+E3z/oSXx6WCXI5l0or4LaPFEL0Mczh/ZYT0V5JPjNvkV1lJQBQkht6Ca
p1znq5f4pGEV9PADgvUYE1FO2CvecS2gwJbUYzBoHZ+zVk8Mxo1Q+0/kdw/2F6Gb
RRBl7ttbS80RLSIzAkIhyieJqnZpp04vLnBuiSTqDaE23LXNLhk=
=h8N9
-----END PGP SIGNATURE-----

--zakfdqd34v2mc5zq--
