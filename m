From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/15] drm/omap: Add infoframe & dvi/hdmi mode support
Date: Thu, 3 Jul 2014 08:55:29 +0300
Message-ID: <53B4F051.6030304@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com> <1403604240-16738-16-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="siE8eoIeCb4mgNeOMGkSrDoIMXxaGngWo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50122 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbaGCFzh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 01:55:37 -0400
In-Reply-To: <1403604240-16738-16-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
Cc: Archit Taneja <archit@ti.com>, Jyri Sarha <jsarha@ti.com>, Rob Clark <robdclark@gmail.com>

--siE8eoIeCb4mgNeOMGkSrDoIMXxaGngWo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/06/14 13:04, Tomi Valkeinen wrote:
> Make the omapdrm driver use the new HDMI ops when possible.
>=20
> omapdrm will call set_hdmi_mode (when available) to tell the encoder
> driver whether the monitor is a DVI or HDMI monitor, and if it's an HDM=
I
> monitor, omapdrm will call set_hdmi_infoframe to to set the AVI
> infoframe.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_connector.c | 12 ++++++++++++
>  drivers/gpu/drm/omapdrm/omap_drv.h       |  1 +
>  drivers/gpu/drm/omapdrm/omap_encoder.c   | 27 ++++++++++++++++++++++++=
+++
>  3 files changed, 40 insertions(+)

Ah, I forgot to add dri-devel list for this one.

Dave, is it ok if I queue this one via fbdev tree, as it depends on the
previous patches on this series?

 Tomi

>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm=
/omapdrm/omap_connector.c
> index 86f4ead0441d..19492cd31f10 100644
> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> @@ -32,8 +32,16 @@ struct omap_connector {
>  	struct drm_connector base;
>  	struct omap_dss_device *dssdev;
>  	struct drm_encoder *encoder;
> +	bool hdmi_mode;
>  };
> =20
> +bool omap_connector_get_hdmi_mode(struct drm_connector *connector)
> +{
> +	struct omap_connector *omap_connector =3D to_omap_connector(connector=
);
> +
> +	return omap_connector->hdmi_mode;
> +}
> +
>  void copy_timings_omap_to_drm(struct drm_display_mode *mode,
>  		struct omap_video_timings *timings)
>  {
> @@ -162,10 +170,14 @@ static int omap_connector_get_modes(struct drm_co=
nnector *connector)
>  			drm_mode_connector_update_edid_property(
>  					connector, edid);
>  			n =3D drm_add_edid_modes(connector, edid);
> +
> +			omap_connector->hdmi_mode =3D
> +				drm_detect_hdmi_monitor(edid);
>  		} else {
>  			drm_mode_connector_update_edid_property(
>  					connector, NULL);
>  		}
> +
>  		kfree(edid);
>  	} else {
>  		struct drm_display_mode *mode =3D drm_mode_create(dev);
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapd=
rm/omap_drv.h
> index 284b80fc3c54..c204c1e7ce87 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -194,6 +194,7 @@ struct drm_encoder *omap_connector_attached_encoder=
(
>  		struct drm_connector *connector);
>  void omap_connector_flush(struct drm_connector *connector,
>  		int x, int y, int w, int h);
> +bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
> =20
>  void copy_timings_omap_to_drm(struct drm_display_mode *mode,
>  		struct omap_video_timings *timings);
> diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/o=
mapdrm/omap_encoder.c
> index 5290a88c681d..7445fb1491ae 100644
> --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
> +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
> @@ -17,6 +17,8 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> =20
> +#include <drm/drm_edid.h>
> +
>  #include "omap_drv.h"
> =20
>  #include "drm_crtc.h"
> @@ -89,6 +91,31 @@ static void omap_encoder_mode_set(struct drm_encoder=
 *encoder,
>  				struct drm_display_mode *mode,
>  				struct drm_display_mode *adjusted_mode)
>  {
> +	struct drm_device *dev =3D encoder->dev;
> +	struct omap_encoder *omap_encoder =3D to_omap_encoder(encoder);
> +	struct omap_dss_device *dssdev =3D omap_encoder->dssdev;
> +	struct drm_connector *connector;
> +	bool hdmi_mode;
> +	int r;
> +
> +	hdmi_mode =3D false;
> +	list_for_each_entry(connector, &dev->mode_config.connector_list, head=
) {
> +		if (connector->encoder =3D=3D encoder) {
> +			hdmi_mode =3D omap_connector_get_hdmi_mode(connector);
> +			break;
> +		}
> +	}
> +
> +	if (dssdev->driver->set_hdmi_mode)
> +		dssdev->driver->set_hdmi_mode(dssdev, hdmi_mode);
> +
> +	if (hdmi_mode && dssdev->driver->set_hdmi_infoframe) {
> +		struct hdmi_avi_infoframe avi;
> +
> +		r =3D drm_hdmi_avi_infoframe_from_display_mode(&avi, adjusted_mode);=

> +		if (r =3D=3D 0)
> +			dssdev->driver->set_hdmi_infoframe(dssdev, &avi);
> +	}
>  }
> =20
>  static void omap_encoder_prepare(struct drm_encoder *encoder)
>=20



--siE8eoIeCb4mgNeOMGkSrDoIMXxaGngWo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtPBUAAoJEPo9qoy8lh71bFcQAIrv7Ha4+jbOP5Be0pfYvLQF
/aUoTMW/UlF1Hz1TEd7jhZee5fqpgID1W6c/ZZwf8pVY2XwpkvQcszW1K/ufRqYu
anfpqbadmdVUUYnTlcOdToJHq0G7W64rl3O37O1MwZxO/JnkVXmcdqFnv/zxxin/
kyDfbVFTV7u29qBzv/kMQU4/EZIFSMfBw5j13bD8QQXVeaC5I8LIflwZJCCZKmF2
q9DT2szT+bE2Hap+d2dThSQsRceHhfP5fEXWDvv0pP/CAfydGk/6/cdC6YUveQPN
E3AK3JpDXK6Fsh+bwPfbqkfpKv4gm6UL+PDLN8jjeg1n7wjA+3tLS4N20eaf1HF3
IRYDUjfXIccyapNmbxvpZzEHj8W0EJ+rEjQ8l6sxojbV65l41N7vE2NkDeSu/0Fa
mWExvtZUV9pibTE4eH34k3XwfDIdSLjv1GlSq6JkVfRM8QzjbevKHntI7McWKpKo
pBLggPVg/cYD88Wd3FFWpGQMaTzhFVVQ6N2kYemKlJYy2vBd+kg4g1kqnBL9XbSo
AjbCJpWV/FJF4CeZA+dWYuuzwRWmMszbqnT9XmWvhWD97v1KIkfr6IDWhMoKdFxA
mOgsizttzOg3BtpQRzUi7AWtpD3Ln/SQOQcoY4rI32y9U7MHxqbyPibTVglTJI/j
tTcZ3746pqwLlfQBoH5d
=OlsP
-----END PGP SIGNATURE-----

--siE8eoIeCb4mgNeOMGkSrDoIMXxaGngWo--
