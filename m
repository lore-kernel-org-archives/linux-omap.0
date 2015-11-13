From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] video:omapdrm: make omapdrm assume the tv-out cable
 is always connected
Date: Fri, 13 Nov 2015 13:46:01 +0200
Message-ID: <5645CD79.5040107@ti.com>
References: <cover.1447410543.git.hns@goldelico.com>
 <5942ddb7ab4f42f207c6c2b54be31a3d9fe3b912.1447410544.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1422679744=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5942ddb7ab4f42f207c6c2b54be31a3d9fe3b912.1447410544.git.hns@goldelico.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, gta04-owner@goldelico.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: linux-omap@vger.kernel.org

--===============1422679744==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cDe9hCiUgC69x2l7q7tEnpNFnndISqfKu"

--cDe9hCiUgC69x2l7q7tEnpNFnndISqfKu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/11/15 12:29, H. Nikolaus Schaller wrote:
> Include VENC in the set of drivers where it is assimed that the cable
> is always connected. Like DPI, DSI, DBI and SDI do.
>=20
> Otherwise, the VENC will return cable status "unknown" and is not enabl=
ed
> by the X-server. So there is no video output signal.
>=20
> Tested on: BeagleBoard XM, GTA04 and OpenPandora
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_connector.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm=
/omapdrm/omap_connector.c
> index 83f2a91..98ddb5d 100644
> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> @@ -120,6 +120,7 @@ static enum drm_connector_status omap_connector_det=
ect(
>  		else
>  			ret =3D connector_status_disconnected;
>  	} else if (dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DPI ||
> +			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_VENC ||
>  			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DBI ||
>  			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_SDI ||
>  			dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DSI) {
>=20

I have no idea why VENC is not working for you when using
connector_status_unknown, but I just tested DPI with
connector_status_unknown (i.e. changed the above func to return unknown
for DPI), and it works fine with X and X omap driver. And xrandr
confirms that the connection status is unknown:

# xrandr
Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 2048 x 2048
HDMI-1 disconnected (normal left inverted right x axis y axis)
None-1 unknown connection 1920x1200+0+0 (normal left inverted right x
axis y axis) 0mm x 0mm
   1920x1200     60.00*+  60.00 +

Grep also shows that there are many drivers using
connector_status_unknown, so I'm guessing it should work fine...

 Tomi


--cDe9hCiUgC69x2l7q7tEnpNFnndISqfKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWRc15AAoJEPo9qoy8lh7197kP/1aC/WADg1ionjO51OGWh9Vz
2MqYn5x0aBrwN2MSlBJaeGbGy5EVvIv1n9psNOWOMJT0nuSAEzmWnrgfERv1MZ16
euHEKRCplLi+JmwLcTEPyqKnzCqJ2m6xQBzDinOZOk0QDGBe6n0la9ypOiywbPjV
qm8G3UAyJsgJqOO4pDTacBhoQxFMEjbpUeu7RIL+B6h8dCG3Gj+b1y3t4kX5/6LI
6sfbW9kAHopLcvhxoCVESwy4/m4qktCrPfFoPjUik0pOwewD8g21++yNHLAz2tiz
UuJTAhHFqvZHClbBJFUu7CrPukxA6UQS/Jk2iClOxr50W7jd/NGATOetLl6lr0Bo
b6YNBz8NyhFZNiUzBk+u9eBGjBavujpYVoDX6j+baQde1/OpoGHY0sD1Ezfov4X/
Q58mjy/lLa5+XZWMnYHOpsgLWR6U5xk9BJ4X4N+og+5m3PU1+YfJn27tSuYQm7fF
lC9DViEQIw8IobBmUYCE9MShNt8SHgN4UsehxgWJ7ICYLo4Q/x3JevI+4/FewpJ4
Ig9YOwdbCXum9LMh6nVGvfhzsaKQHVltohPwJMr5LpYQTotEVK27LWHZdFbXbP6r
CQTesjG38x6yyTZl1z6D6bXR56TV78/GgPoWBUI/P4Czhx85c+FL67OR3Fb0P79o
Bmaezf8GtoNqsY+fiT7W
=6LNj
-----END PGP SIGNATURE-----

--cDe9hCiUgC69x2l7q7tEnpNFnndISqfKu--

--===============1422679744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1422679744==--
