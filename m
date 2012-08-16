From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 2/2] Expose the OMAP Z-Order property through DRM
Date: Thu, 16 Aug 2012 16:00:53 +0300
Message-ID: <20120816130053.GA4421@intel.com>
References: <1345061882-9743-1-git-send-email-rob.clark@linaro.org>
 <1345061882-9743-3-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab2HPNA6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 09:00:58 -0400
Content-Disposition: inline
In-Reply-To: <1345061882-9743-3-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Rob Clark <rob@ti.com>

On Wed, Aug 15, 2012 at 03:18:02PM -0500, Rob Clark wrote:
> From: Andre Renaud <andre@bluewatersys.com>
>=20
> Added support for zorder changes through DRM plane properties
>=20
> Signed-off-by: Andre Renaud <andre@bluewatersys.com>
> Signed-off-by: Rob Clark <rob@ti.com>
> ---
>  drivers/staging/omapdrm/omap_drv.h   |    1 +
>  drivers/staging/omapdrm/omap_plane.c |   19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/oma=
pdrm/omap_drv.h
> index b103d28..9dc72d1 100644
> --- a/drivers/staging/omapdrm/omap_drv.h
> +++ b/drivers/staging/omapdrm/omap_drv.h
> @@ -62,6 +62,7 @@ struct omap_drm_private {
> =20
>  	/* properties: */
>  	struct drm_property *rotation_prop;
> +	struct drm_property *zorder_prop;
>  };
> =20
>  /* this should probably be in drm-core to standardize amongst driver=
s */
> diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/o=
mapdrm/omap_plane.c
> index 6931d06..4bde639 100644
> --- a/drivers/staging/omapdrm/omap_plane.c
> +++ b/drivers/staging/omapdrm/omap_plane.c
> @@ -433,6 +433,15 @@ void omap_plane_install_properties(struct drm_pl=
ane *plane,
>  		priv->rotation_prop =3D prop;
>  	}
>  	drm_object_attach_property(obj, prop, 0);
> +
> +        prop =3D priv->zorder_prop;
> +        if (!prop) {
> +		prop =3D drm_property_create_range(dev, 0, "zorder", 0, 3);
> +		if (prop =3D=3D NULL)
> +			return;
> +		priv->zorder_prop =3D prop;
> +	}
> +	drm_object_attach_property(obj, prop, 0);
>  }
> =20
>  int omap_plane_set_property(struct drm_plane *plane,
> @@ -452,6 +461,16 @@ int omap_plane_set_property(struct drm_plane *pl=
ane,
>  			ret =3D omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
>  		else
>  			ret =3D 0;
> +	} else if (property =3D=3D priv->zorder_prop) {
> +		struct omap_overlay *ovl =3D omap_plane->ovl;
> +
> +		DBG("%s: zorder: %d", ovl->name, (uint32_t)val);
> +		omap_plane->info.zorder =3D val;

What would happen when there's a conflicting assignment between two
planes?

I tried to think of a decent way to do this stuff, but some hardware
can have rather complicated stacking order limitations. One idea I
came up with was to have an enum prop on the crtc, where the individual
enum value names would somehow describe the whole stacking order within
the crtc. That way user space couldn't even try to use an unsupported
configuration. The downside is that user space would need to parse
those strings if it wants to do some automagic stacking order changes,
which means the string format would need some though.

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
