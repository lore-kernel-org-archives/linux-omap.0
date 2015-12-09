From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] video:omap2:dss: fix timings for VENC to match what
 omapdrm expects
Date: Wed, 9 Dec 2015 10:18:24 +0200
Message-ID: <5667E3D0.8010600@ti.com>
References: <cover.1447410543.git.hns@goldelico.com>
 <20ebf7491377ccba18c734c22ae9f361d7fdc165.1447410544.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1026028239=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20ebf7491377ccba18c734c22ae9f361d7fdc165.1447410544.git.hns@goldelico.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, gta04-owner@goldelico.com, linux-omap@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: linux-omap@vger.kernel.org

--===============1026028239==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J4USkrRLJBgfQAPV34EcVW4HnN5Dip2tm"

--J4USkrRLJBgfQAPV34EcVW4HnN5Dip2tm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 13/11/15 12:29, H. Nikolaus Schaller wrote:
> Otherwise check_timings fails and we get a "has no modes" message
> from xrandr.
>=20
> This fix makes the venc assume PAL and NTSC timings that match the
> timings synthetized by copy_timings_drm_to_omap() from omapdrm
> mode settings so that check_timings() succeeds.
>=20
> Tested on: BeagleBoard XM, GTA04 and OpenPandora
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/video/fbdev/omap2/dss/venc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

I've picked this up.

With this patch and the one below I can get tv-out working on my very old=

beagleboard, and it seems to work with X also. It doesn't start automatic=
ally
as the connection state is unknown, but doing "xrandr --output None-1 --a=
uto"
was all I needed to enable it.

 Tomi

=46rom a4274600a5a67256b91266b0d2624b9c9028909b Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 8 Dec 2015 18:32:14 +0200
Subject: [PATCH] drm/omap: fix fbdev pix format to support all platforms

omap_fbdev always creates a framebuffer with ARGB8888 pixel format. On
OMAP3 we have VIDEO1 overlay that does not support ARGB8888, and on
OMAP2 none of the overlays support ARGB888.

This patch changes the omap_fbdev's fb to XRGB8888, which is supported
by all platforms.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapd=
rm/omap_fbdev.c
index b8e4cdec28c3..24f92bea39c7 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -112,11 +112,8 @@ static int omap_fbdev_create(struct drm_fb_helper *h=
elper,
 	dma_addr_t paddr;
 	int ret;
=20
-	/* only doing ARGB32 since this is what is needed to alpha-blend
-	 * with video overlays:
-	 */
 	sizes->surface_bpp =3D 32;
-	sizes->surface_depth =3D 32;
+	sizes->surface_depth =3D 24;
=20
 	DBG("create fbdev: %dx%d@%d (%dx%d)", sizes->surface_width,
 			sizes->surface_height, sizes->surface_bpp,


--J4USkrRLJBgfQAPV34EcVW4HnN5Dip2tm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZ+PQAAoJEPo9qoy8lh71P+cQAK2ySelo8MKVj744Rq9b6fOL
K454NlLn768yH2hTosgIRzh5Q9WS59OkkSEBfiUlBq6rO09VN+cU7zTN2WfT76+l
KfQ7qemZnIlB4YE6hXgi2iW5aQjLdKoqS8+ejVXDjmhwLnTmlMl2eZ0sObK1rtW2
ct0pgPYU7Y4Kil9qHsdz6+AMEMRqAk3APOswpZCp7DmeSCAQ1hvzuMWPIPcbBJDS
QjO7NCufRIQf8JLqjI5r50ykvKihvgljPrfWdZY45hHX1WPcO7dYbC8UBeoMx9M6
Q6oGcW23XWUsBvd8f5oehKyqjdqUVH6bTTHesnFVOQokPGba48SUSZ727312gol5
yVrKYsMr+pyxe1WcR5kA4mLE/59y13SxI8+Zc6EITvuwIkO1tzJZyMGlEVAZYi+U
va/dLG2XwxxYkfU7ph8EsKU2sziWij+u2PqMQSIJoiKoKL9kPU01ilQVP3luzWou
AcJj0VvP7QWWxxJRiEH6bQV9aCkMeoYkB132RHRGzKVQTdFf7sFLnMo40WEE+dZu
poaz+aMMTMNOL3ARbW+hU2wtjy+mZNvTZAlogi72S/biFUXDAgFxE8gc47BqreQy
t0dAGi6aivoDU+iOh7RYCE+PIpGa3ISE4aGLc+Y2/H18vnBjqIBEJvhk0qc2fWlZ
c3Iyf9io0O1ddhq+1sra
=7IDv
-----END PGP SIGNATURE-----

--J4USkrRLJBgfQAPV34EcVW4HnN5Dip2tm--

--===============1026028239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1026028239==--
