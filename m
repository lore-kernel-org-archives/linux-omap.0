From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DSI: Maintain copy of operation mode in
 driver data
Date: Thu, 16 Aug 2012 14:19:24 +0300
Message-ID: <1345115964.15132.2.camel@lappyti>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	 <1345102594-6222-1-git-send-email-archit@ti.com>
	 <1345102594-6222-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cieiQTBS5cD+SRdakvWs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:38256 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307Ab2HPLTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 07:19:34 -0400
Received: by lagp5 with SMTP id p5so1637588lag.23
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 04:19:31 -0700 (PDT)
In-Reply-To: <1345102594-6222-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-cieiQTBS5cD+SRdakvWs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
> The DSI driver currently relies on the omap_dss_device struct to know the=
 mode
> of operation of the DSI protocol(command or video mode). This makes the D=
SI
> interface driver dependent on the omap_dss_device struct.
>=20
> Make the DSI driver data maintain it's own operation mode field. The pane=
l
> driver is expected to call omapdss_dsi_set_operation_mode() before the in=
terface
> is enabled.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/displays/panel-taal.c |    1 +
>  drivers/video/omap2/dss/dsi.c             |   42 +++++++++++++++++++++--=
------
>  include/video/omapdss.h                   |    2 ++
>  3 files changed, 34 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/om=
ap2/displays/panel-taal.c
> index d220f19..649247f 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -1063,6 +1063,7 @@ static int taal_power_on(struct omap_dss_device *ds=
sdev)
>  	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
>  		dssdev->panel.timings.y_res);
>  	omapdss_dsi_set_pixel_format(dssdev, dssdev->panel.dsi_pix_fmt);
> +	omapdss_dsi_set_operation_mode(dssdev, dssdev->panel.dsi_mode);

Taal is always in cmd mode. Shouldn't we just use a hardcoded value
here?

Actually I think the same goes for the pix_fmt above. It's always the
same for Taal.

 Tomi


--=-cieiQTBS5cD+SRdakvWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLNc8AAoJEPo9qoy8lh71v6wP/1JPDxFIppK6+z7O50eFEYiv
5wt4Lgv+dTqNAx+9m4Sh6kAfwGYmY/jUDh80H1wNDNfSIcflNCMk8ttyCjPr1GBt
NZ98VhSR6MiYIhFnBr5zciGHe4N4kjY1wCIO9/bOXKWtPCj8pnF87039eaKUOmnb
lxEHbr44uDNBw6qkibtAChdv6D6Xr4WvmUk09sxVdTNan6arIADSHfV/ZH0qbey3
HoJG6eoVh7QWp5IIj5or2eSk4XccbEtRCK2YkQG8JPy89A7BXqAZ33L1mOawoMtp
aDQ6lbiVnnFKtMFwvVP+OxsqYYCs7CFHqhD+Ht7J3EE5MhLRgk+TcTur1bMpvb+y
wBCv2pK+xvibX2JGpL/7yPXtimOKnoNJ/xHXcmB5ZxsTBDsnm9ekROjNcC/tqjmE
yH9ncaL2kO0OVPt/tjlbAwv3rgpiOmGeEaXuL1Htt6hjIR/Zz9OXkBesaijJwJcf
Q0isoGMVLcTF9GNio31ZseB9xWYXGuUK13hhCd6TXWNUzqvj73ua8BVnZ5HiMgRm
uQQo7B64oGWYDSunGbLXCuQRtOnK3bL/gQGBZ4OfWvdxHYE+5rXAj/BltDdQxai7
PfW6MYK4Ng5tEjJG7dgLS2PEX/mhQ3LI7zpuxWB0fvXLKu7w5wbhHsu6hCWo4JwV
264RxhuF1DJ/xdUe2u1m
=VLwL
-----END PGP SIGNATURE-----

--=-cieiQTBS5cD+SRdakvWs--

