From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Wed, 18 Sep 2013 15:41:51 +0300
Message-ID: <52399F8F.8050104@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ppJHmnlNVPkoaXTrQlA6Tc4nrwAF23u4E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33380 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3IRMly (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 08:41:54 -0400
In-Reply-To: <1379502502-8781-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org

--ppJHmnlNVPkoaXTrQlA6Tc4nrwAF23u4E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/09/13 14:08, Archit Taneja wrote:
> Some omapdss panels are connected to outputs/encoders(HDMI/DSI/DPI) tha=
t require
> regulators. The output's connect op tries to get a regulator which may =
not exist
> yet because it might get registered later in the kernel boot.
>=20
> omapdrm currently ignores those panels which return a non zero value wh=
en
> connected. A better approach would be for omapdrm to request for probe
> deferral if a panel's connect op returns -EPROBE_DEFER.
>=20
> The connecting of panels is moved very early in the the drm device's pr=
obe
> before anything else is initialized. When we enter omap_modeset_init(),=
 we have
> a set of panels that have been connected. We now proceed with registeri=
ng only
> those panels which are already connected.
>=20
> Checking whether the panel has a driver or whether it has get_timing/re=
ad_edid
> ops in omap_modeset_init() are redundant with the new display model. Th=
ese can
> be removed since a dssdev device will always have a driver associated w=
ith it,
> and all dssdev drivers have a get_timings op.
>=20
> This fixes boot with omapdrm on an omap4 panda ES board. The regulators=
 used by
> HDMI aren't initialized because I2c isn't initialized, I2C isn't initia=
lized
> as it's pins are not configured because pinctrl is yet to probe.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_crtc.c |  5 ++++
>  drivers/gpu/drm/omapdrm/omap_drv.c  | 51 +++++++++++++++++++++--------=
--------
>  drivers/gpu/drm/omapdrm/omap_drv.h  |  1 +
>  3 files changed, 35 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omap=
drm/omap_crtc.c
> index 0fd2eb1..9c01311 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -623,6 +623,11 @@ void omap_crtc_pre_init(void)
>  	dss_install_mgr_ops(&mgr_ops);
>  }
> =20
> +void omap_crtc_pre_uninit(void)
> +{
> +	dss_uninstall_mgr_ops();
> +}
> +
>  /* initialize crtc */
>  struct drm_crtc *omap_crtc_init(struct drm_device *dev,
>  		struct drm_plane *plane, enum omap_channel channel, int id)
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapd=
rm/omap_drv.c
> index 2603d90..cbe5d8e 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -87,6 +87,24 @@ static bool channel_used(struct drm_device *dev, enu=
m omap_channel channel)
>  	return false;
>  }
> =20
> +static int omap_connect_dssdevs(void)
> +{
> +	int r;
> +	struct omap_dss_device *dssdev =3D NULL;
> +
> +	for_each_dss_dev(dssdev) {
> +		r =3D dssdev->driver->connect(dssdev);
> +		if (r =3D=3D -EPROBE_DEFER) {
> +			return r;
> +		} else if (r) {
> +			dev_warn(dssdev->dev, "could not connect display: %s\n",
> +				dssdev->name);
> +		}
> +	}
> +
> +	return 0;
> +}

There are two issues with this one:

for_each_dss_dev() uses omap_dss_get_next_device(), and that will
increase the ref count of the current dssdev. If you interrupt the loop,
the ref count won't be decreased. I have a hunch that we could have
similar bugs elsewhere too...

Second, in case of error, the dssdevs that were already connected should
be disconnected. Although maybe that's not important, as they'll end up
being connected again when the omapdrm is probed the next time.

I had a quick test with this, and it seemed to fix the probe issue. I'll
do some more testing.

 Tomi



--ppJHmnlNVPkoaXTrQlA6Tc4nrwAF23u4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSOZ+PAAoJEPo9qoy8lh71sywQAKVdoYnKUUH4xr5weWkxI0+A
QxBXdEFhutr9U24/xXiumZyAylwk48/3gsFhi/94MLslp7R2cSK/8H5sHrYpq0Sy
QKiroBMg8METla0BNZH2NhmMalvYx3r0WhQwpkS0NvGugsVEXHUNq4Qfl7ojbikQ
uTU1sg6JNKGyxd5qIt585bHawDL1bpGFrQAJRFAf/39pLBqyss0n2urxcSrSZAZP
RX5o8Blm7+Cqn23kJ32s8JJR7cw4V46VSakOqWXgsPttuSqLNVz4yUZAgsit64TA
vAgmR3Q2YuvPGSNJrxjPyntFToIeukCyFDF711/1KdvdXOQAXUZ8TaI6ilbSdXO5
jaZ0HIQyPpschLEJDgxjpguhBUdWUSTsAbc1tIxNzv9lurJGIra5Wqc1Y3YRvxIu
7JU0dnBBnOZ4OSmzFQyHjoPPfetC6rLIXARNSGFhX35n8Uhtx1pTRGnQfvAbIvA3
od1KnigCphmTzyMMC2ZskOk1jAGn32rBZqm8UN/i2L7bzQk54nfPdnNxAmZXNmiW
a8ioUxQU17zD4XJCxDjLC72U3mNpXi9B9lRT4ccm3bVevjw5BBQzwy8GmkDl6h91
M6xgnnWEcVojXm6pM38ceTYQxHrIPk6V0THC1kUjfMieVlclJ+GmCWPlmDEWOzKp
9KGSv7UgWEzBpfdhw+z3
=k3Al
-----END PGP SIGNATURE-----

--ppJHmnlNVPkoaXTrQlA6Tc4nrwAF23u4E--
