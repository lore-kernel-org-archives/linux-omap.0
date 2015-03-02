From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 1/6] drm/tilcdc: Fix module unloading
Date: Mon, 2 Mar 2015 15:10:01 +0200
Message-ID: <54F46129.1000703@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <9ef213208e27b6f45b74a77b1c7902fa3910bf46.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7K4e207lRo8DdjfP9ELSmjOTOnv1fEFJo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32884 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbCBNKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 08:10:24 -0500
In-Reply-To: <9ef213208e27b6f45b74a77b1c7902fa3910bf46.1424961754.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc: airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk

--7K4e207lRo8DdjfP9ELSmjOTOnv1fEFJo
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/02/15 16:55, Jyri Sarha wrote:
> Force crtc dpms off before destroying the crtc instead of just
> checking the dpms state. This fixes warning message and frozen picture
> after tilcdc module unloading.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/til=
cdc/tilcdc_crtc.c
> index c735884..c2d5980 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -135,11 +135,12 @@ static void stop(struct drm_crtc *crtc)
>  	tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
>  }
> =20
> +static void tilcdc_crtc_dpms(struct drm_crtc *crtc, int mode);
>  static void tilcdc_crtc_destroy(struct drm_crtc *crtc)
>  {
>  	struct tilcdc_crtc *tilcdc_crtc =3D to_tilcdc_crtc(crtc);
> =20
> -	WARN_ON(tilcdc_crtc->dpms =3D=3D DRM_MODE_DPMS_ON);
> +	tilcdc_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
> =20
>  	drm_crtc_cleanup(crtc);
>  	drm_flip_work_cleanup(&tilcdc_crtc->unref_work);
>=20

Looks fine to me, but makes me wonder what is the proper way to handle
this. I would presume that every DRM driver needs to shut down the
display HW when it's being unloaded.

And the current WARN_ON suggests that something is supposed to turn the
crtc off before it is destroyed. So either the tilcdc module unload has
never worked, or something has changed in the drm framework (or maybe
tilcdc).

 Tomi



--7K4e207lRo8DdjfP9ELSmjOTOnv1fEFJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9GEpAAoJEPo9qoy8lh715uoQAK3q5nbBJ2F3LUcBA5pTmftB
WmAIChHLjsfH8EB2vCN33P36KoyxPfSw03/u97mHEn6nWAoXtZW+GnAHOxJ4zsa9
EWmliF5FECqRNK3pCbFf/SBGlm+1HwVvLkwwuBaVr0R5emtK6sRwD7qjo3pOpI5V
CJW6SmA0MGrfdI2yqLizZmIzxL1SbuI3vAO4VJSAuFK0M8opinl98Aqbv9yrXvMH
JFw6UOewFA8yhNquJAJyecx9xpzT5j1ywdyAbcaSZar8Mt1T0l8hWAR/25HlPjHU
NE3FbV+Vug4oPhmytPQPbZFH8ReOgOa1BhwMIVZ0krWGVEgeZDKVwfE7mcqfof37
YfELVUYBnXMQHusev+RQFwcSxYdIMNKUeH8l1TIZcWembW99IxlEXYANMj5Na4ha
8OlVxS3khmTwrEbeThsflExQqdVv30ChrsoJ3gcTnRo9T5GQJJeTddwdYA7UdRGG
defKY712+wdSKAjhyoTeqoAUMIA9rRYZWU5G1HJHAKSHui+EKIzJKyVevf7bVmau
Ys7kWmmQiw6DfpI6j+NuK3nOyzaEINeKTAsp8AnMZY82SeHaERmnAiOSXt0NtPfM
1SFUE3J90tJO3j/TLEQcOw6rwDxVrgvE0klytx4+QAvcY8txslnTcQy1/7yF35f9
hpsKAzk+8hMhJrEotBNH
=r84+
-----END PGP SIGNATURE-----

--7K4e207lRo8DdjfP9ELSmjOTOnv1fEFJo--
