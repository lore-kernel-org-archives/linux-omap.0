From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Fri, 20 Sep 2013 11:09:44 +0300
Message-ID: <523C02C8.30207@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KqvHn8G1Kquf6J9BebkjUG42I2qLdDGv8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49498 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab3ITIJs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 04:09:48 -0400
In-Reply-To: <1379502502-8781-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org

--KqvHn8G1Kquf6J9BebkjUG42I2qLdDGv8
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

Beagle-xm with DT boot doesn't work with this. There are no displays at
omapdrm probe time, so omapdrm doesn't find any displays. I added the
changes below, which made it work.

 Tomi

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm=
/omap_drv.c
index cbe5d8e..e315413 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -91,6 +91,7 @@ static int omap_connect_dssdevs(void)
 {
        int r;
        struct omap_dss_device *dssdev =3D NULL;
+       bool no_displays =3D true;
=20
        for_each_dss_dev(dssdev) {
                r =3D dssdev->driver->connect(dssdev);
@@ -99,9 +100,14 @@ static int omap_connect_dssdevs(void)
                } else if (r) {
                        dev_warn(dssdev->dev, "could not connect display:=
 %s\n",
                                dssdev->name);
+               } else {
+                       no_displays =3D false;
                }
        }
=20
+       if (no_displays)
+               return -EPROBE_DEFER;
+
        return 0;
 }



--KqvHn8G1Kquf6J9BebkjUG42I2qLdDGv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSPALIAAoJEPo9qoy8lh71UIEP/RYiI5cblIVnsZra7YcBe7/f
eEEFHcj12vURy9+gZbVTw8LriqzOg3cOA49wr3jWwTtGL5cE0q0EXC70QcwdQf4b
wNW8hwqE7jOALwvt0zIeLl4Dr0MTLx0eBVX/s26bKQR3jz7Hw90hhEtUVaUAv/MJ
qSiTl0GvkD/RES1cpAIeCpt3bX9E1E4OUqOGL+b0r0nmLWaMWrqOYVlYir6hO6zR
72G5nHWQ9J+TIXCSHDqsjIDqDlduK4GFBhrJ3HZKLts9ekIrq5lAQKBZEodfTWha
IM1ErGUQmFElXSXZwQjPRL39/J0WGaBEoJDmLVWUJA9rZMxkmhw5UT9cVWElV7ps
SyucZ+VRHsJ4MBcxDGCTmFopt822b/+cyLEgJheA4QOFiiE4jHUpOd2kvme3xyMy
ixaQ4mqcgWYZ3Gv4pZD17eDVaPQBrY5LZfvYgNigY8n7ynoRYobYTMtIXSkNb5fV
/47CyPsd2dSeHn21hYe/QnB0hDQZExi12AKqGI6ZlflDThUNRVKk2OdgYrvvTGzM
V5JdVG9FNdHtGTqwOKtzc7K27AjGRljhgiTTCRuqA1emqtC4ru7HCzOe6Utgy7xj
DDEMBg2BUBIju0DK8+qUMUKNxSZzSxtPrDt3JI2ynGHbxO79vodW21in4/0QEzv3
p2rYQFz2RilS4BTruegG
=R9Mc
-----END PGP SIGNATURE-----

--KqvHn8G1Kquf6J9BebkjUG42I2qLdDGv8--
