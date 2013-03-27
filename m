From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 3/8] drm/omap: Make fixed resolution panels work
Date: Wed, 27 Mar 2013 09:24:50 +0200
Message-ID: <51529EC2.4040403@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com> <1364305525-28496-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC9125FEF3A688DEE8F7B2BE5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59892 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3C0HYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 03:24:54 -0400
In-Reply-To: <1364305525-28496-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enigC9125FEF3A688DEE8F7B2BE5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-26 15:45, Archit Taneja wrote:
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
> v3: clear the timings local variable first before using memcmp
> v2: make sure the timings we try to set for a fixed resolution panel ma=
tch the
>     panel's timings
>=20
>  drivers/gpu/drm/omapdrm/omap_connector.c |   27 ++++++++++++++++++++++=
+++--
>  drivers/gpu/drm/omapdrm/omap_encoder.c   |   17 +++++++++++++++--
>  2 files changed, 40 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm=
/omapdrm/omap_connector.c
> index c451c41..912759d 100644
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
>  	} else {
>  		ret =3D connector_status_unknown;
>  	}

Can we leave this part out? I don't like hardcoding things like that,
and if I'm not mistaken, this only affects VENC.

If the code above would use detect where available, and presume the
panel is connected in other cases, it'll be right for all other displays
but VENC, for which we have no connect information.

Or, there could be a special case for VENC, like above, which sets the
connector status to unknown for that. And connected for all others. It'd
still be hardcoded, but for much less cases.

 Tomi



--------------enigC9125FEF3A688DEE8F7B2BE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUp7CAAoJEPo9qoy8lh71tGIP/17046nFOWXcJIZitHwi5wXV
iAkkNjrwIAppTooJwaFEcVGGegddSgtalZkU2pGTZrnRB0J5NZqbiexGXTrAk8ff
grdZkKW3XLtkfk8kXVepR1XuiB971K6yyKrZE25evjBYuwCOLSGajTL2IL8af5wy
nlQd/N7mnD7ktxdllRK6tM+CzDNXoMNrEyLP6255XEWgpGRW0WGufGHBSpUkdPiC
X+PeNrgdOXT0q2pjvoSmWFgCtmIDb9ZF8oU6eaW/o94rnnP3RMgP9pbaG5Yp2eZ2
y/h421Wi0cuTiEqB520rbdFfWFv5TYQur/9vWJHCLlqTRQSVhqZinYbdg6LPXYYq
9I0N6AfNl6pG/JjHEQpL7xetRFMvWZp4GcXz8oKz/ArDn2iQiUy5T5ctXrE49pRZ
5EsPJz243fOVi5D5s9SSAnixFU/JNWIjHP00qEYi0BpZN9w3+UeAJC228BdW8zTp
navrY7N7IgQijwofn/zAQlLsrjr+lIm+FuLwafqnz4QP1vwri5/Wj/L9KfKh7MxO
ruMIaffBaNKy1meQRHEIStV760i1tLmvWEak4cpDtJ/PD8+gwB410blDu4zYSNaL
CYzdNJOqQK956svUfDCCEtddP07mV7/W8fR8M8Io7AXoEiAOPqJFhPcLFitqZVgf
MrwGgFZcZZw2pGeRj58r
=q6LV
-----END PGP SIGNATURE-----

--------------enigC9125FEF3A688DEE8F7B2BE5--
