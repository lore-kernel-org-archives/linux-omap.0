From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 04/23] drm: omapdrm: add DSI mapping
Date: Tue, 10 May 2016 15:08:21 +0300
Message-ID: <5731CF35.2070307@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-5-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457648276=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1457455195-1938-5-git-send-email-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1457648276==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iItC1SNbLL6MUrtPe4X1Rtklmu35oNTHL"

--iItC1SNbLL6MUrtPe4X1Rtklmu35oNTHL
Content-Type: multipart/mixed; boundary="bWUc4itUpFpeVJW9SovWwqcC4OspN8Ddw"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <5731CF35.2070307@ti.com>
Subject: Re: [PATCH 04/23] drm: omapdrm: add DSI mapping
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-5-git-send-email-sre@kernel.org>
In-Reply-To: <1457455195-1938-5-git-send-email-sre@kernel.org>

--bWUc4itUpFpeVJW9SovWwqcC4OspN8Ddw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/16 18:39, Sebastian Reichel wrote:
> This sets proper connector type for DSI connected panels.
>=20
> Signed-off-By: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/omap_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapd=
rm/omap_drv.c
> index dfafdb602ad2..a3ff35f5f6cd 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -215,6 +215,8 @@ static int get_connector_type(struct omap_dss_devic=
e *dssdev)
>  		return DRM_MODE_CONNECTOR_HDMIA;
>  	case OMAP_DISPLAY_TYPE_DVI:
>  		return DRM_MODE_CONNECTOR_DVID;
> +	case OMAP_DISPLAY_TYPE_DSI:
> +		return DRM_MODE_CONNECTOR_DSI;
>  	default:
>  		return DRM_MODE_CONNECTOR_Unknown;
>  	}
>=20

Thanks, I've picked this up for 4.8.

 Tomi


--bWUc4itUpFpeVJW9SovWwqcC4OspN8Ddw--

--iItC1SNbLL6MUrtPe4X1Rtklmu35oNTHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMc81AAoJEPo9qoy8lh71he4P/2da/OgN/oS3SbCkR6xUP2lH
YmjmI/Rp9CTTxUqAdwGq40gwzRBjB5wYdpBoXoYOPHNb02lnhnH2sGCa420WdHlX
EAHJkpUIAjnTkT8yMDsJiy802j4NSjFpETO1KBHcjgWtzG/qOUD8FnbVFP394Wo3
9qZ+g6/AtRHkRaLFf+vTwKpJNulNcD/N/E/RgPIf7V3gdyJ0w7+Vj6wtFUQbc/2J
UMdOU3MiSf1+y3fuPcEpdhBQwEA7Gf3V0sbsdEU+yEc9mYFjAW7DuaKUQh50gjHO
+3c33k97C3BneUpz3H7xIOOnHl2BAJ3gqmquF2iV07DMRGjd40ObL5wBUTDkjDMv
7WTYczL8vbCOm2FozXl5q+SHU5J7+sqKKagOIK1yLUK+THaYn5wVa+LOTYIaddu7
arRc2g04uUpK/8Urtgyq0sLi2gq2DgA5zpbqdoMKCxe6yb67SMJDmWxThShKyuO+
Wg9xRqQ7uY/2EJD7sFwo5jS2kLyTP2ms/TBx/KJwKShllDvUrdK+SJ/i+ZoY+d7V
H/LRfw5KAa1Q7T/8LPs4xr+QpXoHMJM2aM1MX87CpsrnghLKdfIN1TWTYUxGA3I+
8jyA8+iFntfiw31EW3+fSys1Fm+aZ381NylDb0+99W3PEZfvdtVHKyp8chQkhDX8
TDfSt390yObHbHL1F/kk
=2WEt
-----END PGP SIGNATURE-----

--iItC1SNbLL6MUrtPe4X1Rtklmu35oNTHL--

--===============1457648276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1457648276==--
