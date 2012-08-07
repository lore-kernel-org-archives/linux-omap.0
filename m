From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in
 driver data
Date: Tue, 07 Aug 2012 17:07:42 +0300
Message-ID: <1344348462.7216.77.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	 <1343817088-29645-9-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-AGrwCg3rbo+ArQ9yDnh6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:59648 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752380Ab2HGOHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 10:07:48 -0400
Received: by lage4 with SMTP id e4so196572lag.25
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 07:07:46 -0700 (PDT)
In-Reply-To: <1343817088-29645-9-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-AGrwCg3rbo+ArQ9yDnh6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
> The DSI driver currently relies on the timings in omap_dss_device struct =
to
> configure the DISPC and DSI blocks accordingly. This makes the DSI interf=
ace
> driver dependent on the omap_dss_device struct.
>=20
> Make the DPI driver data maintain it's own timings field. The panel drive=
r is
          ^^^
DSI

> expected to call omapdss_dsi_set_timings() to set these timings before th=
e panel
> is enabled.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>d
> ---
>  drivers/video/omap2/displays/panel-taal.c |    2 ++
>  drivers/video/omap2/dss/dsi.c             |   27 ++++++++++++++++++++++-=
----
>  include/video/omapdss.h                   |    2 ++
>  3 files changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/om=
ap2/displays/panel-taal.c
> index 3f5acc7..4775580 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -1060,6 +1060,8 @@ static int taal_power_on(struct omap_dss_device *ds=
sdev)
>  		goto err0;
>  	};
> =20
> +	omapdss_dsi_set_timings(dssdev, &td->panel_config->timings);
> +
>  	r =3D omapdss_dsi_display_enable(dssdev);
>  	if (r) {
>  		dev_err(&dssdev->dev, "failed to enable DSI\n");

Video timings for command mode panel are meaningless. If we need to pass
the resolution of the panel, perhaps we should have a separate function
for that.

However, with a quick glance at dsi.c, we don't even use the
dssdev->panel.timings for cmd mode panel. But we do use
dssdev->get_resolution() in a few places. Those calls could be replaced
by storing the panel size in dsi.c, given with omapdss_dsi_set_size() or
such. We could use the timings field in dsi.c to store them, though.

 Tomi


--=-AGrwCg3rbo+ArQ9yDnh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQISEuAAoJEPo9qoy8lh71G+oQAKs0cpux4U1yKTBHHXyrE6wQ
/LKrCBBE3Rap06WqKIjfy3rNBm8s8ffO5Lnv+vlsU8aVLXA/r4amiZederzIbNxL
N39nXhHXH9Ho+Cd8snkS69RM7KzM25gBt0eCbzkp5ffAz3KK0QO2eZq4diRWXGcT
wCNGFjfOANxjOBgzbiNLvL1lmPtjXY9BlNUKjKvE+uQicRaAQbdm/oF2xH9BOC5B
3Q5XHDGOXgt2j3RdEDu0fwt7fKWiPpzQ4qLBBo2oTvgJ96QnBbJCRBubuhDEKlpg
iYZZQwI+WrDULvggJrKnVyOmX0/vMo4qkroxnumwm9lRTeipjn2FMsZHWWQ2JiMt
ACSI5RNDNDTyb3BP2u/v5+a7rqEa8XTrMZmuhMdeV0DGmiItZISV4S5ECY5xXian
Y4T1BHIyKNUd+FmZ2oInIYzVGdKrng7EkuKuTblyYUl3H6Xzma+2EwUmUVhK5ciC
33ognBYeoZ7QHkciWGqTMQHVPHD75MzbYQXNnwIPBBrK2xuzKZ9F5Wh9sfwEmD7k
UJwUEPu7Ot+LMfhmfwrYCqWbAe7tJEB1PWnB8nP9WjPwkkYNVz3UiSWfb7rKO3HE
S0sO19/CrV94z+X/bhTW+8AXX3mEWzgxl+wV4BDzoYknpvLrddbgE1wDiFz+6u0h
QJAPyU6YhsVlrM9BfSkE
=3cv0
-----END PGP SIGNATURE-----

--=-AGrwCg3rbo+ArQ9yDnh6--

