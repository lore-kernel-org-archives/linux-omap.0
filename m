From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 3/4] drm/omap: Make fixed resolution panels work
Date: Tue, 12 Mar 2013 16:06:16 +0200
Message-ID: <513F3658.3000300@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1363093583-28285-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C3C4C96A82AB5AB88680B2E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46674 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156Ab3CLOGT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 10:06:19 -0400
In-Reply-To: <1363093583-28285-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

--------------enig8C3C4C96A82AB5AB88680B2E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-12 15:06, Archit Taneja wrote:
> The omapdrm driver requires omapdss panel drivers to expose ops like de=
tect,
> set_timings and check_timings. These can be NULL for fixed panel DPI, D=
BI, DSI
> and SDI drivers. At some places, there are no checks to see if the pane=
l driver
> has these ops or not, and that leads to a crash.
>=20
> The following things are done to make fixed panels work:
>=20
> - The omap_connector's detect function is modified such that it conside=
rs panel
>   types which are generally fixed panels as always connected(provided t=
he panel
>   driver doesn't have a detect op). Hence, the connector corresponding =
to these
>   panels is always in a 'connected' state.
>=20
> - If a panel driver doesn't have a check_timings op, assume that it sup=
ports the
>   mode passed to omap_connector_mode_valid(the 'mode_valid' drm helper =
function)
>=20
> - The function omap_encoder_update shouldn't really do anything for fix=
ed
>   resolution panels, make sure that it calls set_timings only if the pa=
nel
>   driver has one.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> Note: In v2, we make sure that the mode passed on to omapdrm matches th=
e timings
> of the fixed resolution panel.
>=20
>  drivers/gpu/drm/omapdrm/omap_connector.c |   27 ++++++++++++++++++++++=
+++--
>  drivers/gpu/drm/omapdrm/omap_encoder.c   |   17 +++++++++++++++--
>  2 files changed, 40 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm=
/omapdrm/omap_connector.c
> index c451c41..a72fedd 100644
> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> @@ -110,6 +110,11 @@ static enum drm_connector_status omap_connector_de=
tect(
>  			ret =3D connector_status_connected;
>  		else
>  			ret =3D connector_status_disconnected;
> +	} else if (dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DPI ||
> +			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DBI ||
> +			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_SDI ||
> +			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DSI) {
> +		ret =3D connector_status_connected;

I have to say I don't like this. We shouldn't care about the type here.
I think it's better just to default to connected if there's no detect
function (or unknown? I'm not sure what is the practical difference).

If it works fine without using dssdev->type, we have one less place to
worry when doing dss dev model changes =3D).

>  	} else {
>  		ret =3D connector_status_unknown;
>  	}
> @@ -189,12 +194,30 @@ static int omap_connector_mode_valid(struct drm_c=
onnector *connector,
>  	struct omap_video_timings timings =3D {0};
>  	struct drm_device *dev =3D connector->dev;
>  	struct drm_display_mode *new_mode;
> -	int ret =3D MODE_BAD;
> +	int r, ret =3D MODE_BAD;
> =20
>  	copy_timings_drm_to_omap(&timings, mode);
>  	mode->vrefresh =3D drm_mode_vrefresh(mode);
> =20
> -	if (!dssdrv->check_timings(dssdev, &timings)) {
> +	/*
> +	 * if the panel driver doesn't have a check_timings, it's most likely=

> +	 * a fixed resolution panel, check if the timings match with the
> +	 * panel's timings
> +	 */
> +	if (dssdrv->check_timings) {
> +		r =3D dssdrv->check_timings(dssdev, &timings);
> +	} else {
> +		struct omap_video_timings t;
> +
> +		dssdrv->get_timings(dssdev, &t);
> +
> +		if (memcmp(&timings, &t, sizeof(struct omap_video_timings)))
> +			r =3D -EINVAL;
> +		else
> +			r =3D 0;

memcmp on two structs is often not a good idea. There could be padding
bytes there, with uninitialized data. I'm not sure if that's the case
here, though, but it could well change any time (perhaps even depending
on compiler version).

I'm still pondering whether it'd just be simpler to require all the
dssdrv ops to be filled, probably using a helper macro in the panel
drivers... Did you consider that approach? I'm not saying to go for it,
I'm saying I can't make my mind which would be better =3D).

 Tomi



--------------enig8C3C4C96A82AB5AB88680B2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPzZYAAoJEPo9qoy8lh71wTsP+wYp0NdxIT7LcpbU+DKidTyi
5jjKlYJMtn00gdl+A9cJnNDJLBG1K6Rq2oytPJLIX2NXYyzZJLfbOxvqCBQktsEV
GytFisr15yEb56HAXqPsNcIOlByWHwec0ueQtLgW4D8Ydem5lOj5iIGJU5HhB4sy
mkHZJBhqpkQJnS7ThISogqz3j8rICwA1CNydP+/ohGUhm64UL4VefswmO4pteA8i
lL6osncwlJrCj7lnGFehiMN16pmWU0os529Y1TShjCCE/aHvPpgUOWQlA3c0LIMg
8UMI+KSe6ojRUjM4LHKyZQbMjItnWJGFbgi5TwWLDP25nN+OY5OHSijjlRrChTVL
tDtBKr4jjNPUlm3FVTpKaaQv9sWufyxO1cE9j1URreBnp8GTwMqlBcN0Bk0LEGyc
+4xfjG/9+p4hUIIlY0Vo2oeqmXltNTKcZjhbXGcIcEhQDu2fh1FxI2MPbgxR7YU9
4S5KQo7nOO3QV0Z4ejzC9wRkIlI6af4NocfYS3iqK7ipjGeNT8ikUV4hlfTJSHJv
V2bKMqLCiowHlZ3Uj34TTkfBRyLRDjbBowjtH+JtuSMpX6goBPxEmS8cbvwWFrPo
EvhU9pXcSOHgTCxhvVzV4NpHRRq/BXvePA6oxi11TXrcUFYGjQILlhkEOyjJOCLD
/9yAGszyMzo/Fyfmk5nv
=8oXd
-----END PGP SIGNATURE-----

--------------enig8C3C4C96A82AB5AB88680B2E--
