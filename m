From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 3/6] drm/tilcdc: Add support for external compontised
 DRM encoder
Date: Mon, 2 Mar 2015 14:44:29 +0200
Message-ID: <54F45B2D.8060907@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="L4AEX6WVi4vue3dwkInmREOI8tqEGXiim"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60463 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157AbbCBMox (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 07:44:53 -0500
In-Reply-To: <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk, Philipp Zabel <p.zabel@pengutronix.de>

--L4AEX6WVi4vue3dwkInmREOI8tqEGXiim
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/02/15 16:55, Jyri Sarha wrote:
> Add support for an external compontised DRM encoder. The external
> encoder can be connected to tilcdc trough device tree graph binding.
> The binding document for tilcdc has been updated. The support has only
> been tested with tda998x encoder, but other encoders should work too
> with a little tweaking.
>=20
> I got the idea and some lines of code from Jean-Francois Moine's
> "drm/tilcdc: Change the interface with the tda998x driver"-patch.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---

<snip>

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm=
/tilcdc/tilcdc_external.c
> new file mode 100644
> index 0000000..7254151
> --- /dev/null
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> @@ -0,0 +1,105 @@
> +/*
> + * Copyright (C) 2015 Texas Instruments
> + * Author: Jyri Sarha <jsarha@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License version 2 as publ=
ished by
> + * the Free Software Foundation.
> + *
> + */
> +#define DEBUG 1

You probably didn't mean to include this.

> +
> +#include <linux/component.h>
> +#include <linux/of_graph.h>
> +
> +#include "tilcdc_drv.h"
> +#include "tilcdc_external.h"
> +
> +static const struct tilcdc_panel_info panel_info_defaults =3D {
> +		.ac_bias                =3D 255,
> +		.ac_bias_intrpt         =3D 0,
> +		.dma_burst_sz           =3D 16,
> +		.bpp                    =3D 16,
> +		.fdd                    =3D 0x80,
> +		.tft_alt_mode           =3D 0,
> +		.invert_pxl_clk		=3D 1,
> +		.sync_edge              =3D 1,
> +		.sync_ctrl              =3D 1,
> +		.raster_order           =3D 0,
> +};
> +
> +static int tilcdc_add_external_encoder(struct drm_device *dev, int *bp=
p,
> +				       struct drm_connector *connector)
> +{
> +	struct tilcdc_drm_private *priv =3D dev->dev_private;
> +
> +	priv->connectors[priv->num_connectors++] =3D connector;
> +	priv->encoders[priv->num_encoders++] =3D connector->encoder;
> +
> +	tilcdc_crtc_set_simulate_vesa_sync(priv->crtc, true);
> +	tilcdc_crtc_set_panel_info(priv->crtc, &panel_info_defaults);

Setting of the simulate vesa sync and the panel info here look a bit
like a hack to me. Both of them are for tda998x, not "defaults".

So... I don't know. You could state that at the moment tilcdc only
supports tda998x as an external encoder. Then the above would be ok, but
still it would be good to clearly state this in the desc, comments and
variable names.

Doing this properly may be more difficult. Some parameters should be
defined in the .dts, some should probably come from tda998x driver, and
some should be deduced by tilcdc driver internally.

> +	*bpp =3D panel_info_defaults.bpp;
> +
> +	dev_info(dev->dev, "External encoder '%s' connected\n",
> +		 connector->encoder->name);

This and the other dev_info in this patch look more like dev_dbg to me.

> +
> +	return 0;
> +}
> +
> +
> +int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp)
> +{
> +	struct tilcdc_drm_private *priv =3D dev->dev_private;
> +	struct drm_connector *connector;
> +	int num_internal_connectors =3D priv->num_connectors;
> +
> +	list_for_each_entry(connector, &dev->mode_config.connector_list, head=
) {
> +		bool found =3D false;
> +		int i, ret;
> +
> +		for (i =3D 0; i < num_internal_connectors; i++)
> +			if (connector =3D=3D priv->connectors[i])
> +				found =3D true;
> +		if (!found) {
> +			ret =3D tilcdc_add_external_encoder(dev, bpp, connector);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	if (priv->num_connectors - num_internal_connectors > 1) {
> +		dev_err(dev->dev, "Only one external encoder is supported.");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> +	return dev->of_node =3D=3D data;
> +}
> +
> +int tilcdc_add_external_components(struct device *master,
> +				   struct master *m)
> +{
> +	struct device_node *ep =3D NULL;
> +
> +	while ((ep =3D of_graph_get_next_endpoint(master->of_node, ep))) {
> +		struct device_node *node;
> +		int ret;
> +
> +		node =3D of_graph_get_remote_port_parent(ep);
> +		of_node_put(ep);

Note that there's an unmerged series "Add of-graph helpers to loop over
endpoints and find ports by id" from Philipp which changes the behavior
of of_graph_get_next_endpoint.

> +		if (!node || !of_device_is_available(node))
> +			continue;

Should you of_node_put(node) if node !=3D NULL above?

> +
> +		dev_info(master, "Subdevice node '%s' found\n", node->name);
> +		ret =3D component_master_add_child(m, of_dev_node_match, node);
> +		of_node_put(node);
> +		if (ret) {
> +			dev_err(master, "Adding component failed: %d\n", ret);
> +			of_node_put(ep);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}

I don't know if it matters, but as tilcdc only supports a single
endpoint, and I think this is the earliest place where it can be
detected, you could fail above if there are more than one endpoint.

 Tomi



--L4AEX6WVi4vue3dwkInmREOI8tqEGXiim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9FstAAoJEPo9qoy8lh71vaQP/iuK+gUxyArd9vow1ljGSWzJ
i14qL25jxf3L6yyv05HDhrABDxJ4tLoETwnT+v1TP5J+izXVglW6r/zR2hQhmpXV
zI5VhbiKISnVrtpz0OiRDPD+LLL+QOiCKMAauXsf7tOsAd0FEGJzCx5qSiyO5ybs
l3x6YPWCFGgcqyNagv/druZ+iAL95LuuVKY/Yl5gPt5tTml4Oe1itxnr6pRtohMd
30/CUPWvOMgAl53pgbz+1uaXd5j3mlvjo4Q77s6ncDheD+ABrjX0MwdwjYDGzCMj
cd2Z+ojgjENirxrKAz0B7DSOSPGLW2ougzxbGRQ7aDEVxZSnKPanOUR3VNH+W/RS
BJ/EiRbGRfZl3T9ccFWmnfg0Tq34znSYlFNj5PmJoutRz9z4+8VfzRQzdsBsy8+d
b0mVymSUcUL5zL1bOJDYXCmZEEn/KxMnhbagBo7IArk5FWu+KC8hxBRyJrrXVyOn
4KKkgH5Qjqo7OibdcL/YlbO5uIDjKkVmx5sObxy9shZHXPd878PCQe6t/6hDtOWB
8gklOArPL2Ex7Rj3zxgjS4VV8dP+B/7O39sjEka9TccnQIsm0FFid/sPxLtVHdDa
kamf6qXeIgv//nkxBfiO6RsmSMSVwixR9+bF3uaL1B5feMOTUDo8cRYnSc2gUtNt
L3aaws4N7jyKwWEaXQjK
=bcrs
-----END PGP SIGNATURE-----

--L4AEX6WVi4vue3dwkInmREOI8tqEGXiim--
