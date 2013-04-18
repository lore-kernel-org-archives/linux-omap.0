From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Thu, 18 Apr 2013 12:21:29 +0300
Message-ID: <516FBB19.4090609@ti.com>
References: <516BDD35.4000807@ti.com> <1366274225.4085.44.camel@mars> <516FB845.3070505@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC3AAF0118E19969F306FCE76"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53857 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965455Ab3DRJVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 05:21:34 -0400
In-Reply-To: <516FB845.3070505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enigC3AAF0118E19969F306FCE76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-04-18 12:09, Tomi Valkeinen wrote:
> On 2013-04-18 11:37, Christoph Fritz wrote:

>> With linux-next this patch breaks compiling here because DPI now depen=
ds
>> on DSI - but my omap3 board here doesn't use DSI at all:
>>
>> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_calc_pll_cb=E2=
=80=99:
>> drivers/video/omap2/dss/dpi.c:181: error: implicit declaration of func=
tion =E2=80=98dsi_hsdiv_calc=E2=80=99
>> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_dsi_clk_calc=E2=
=80=99:
>> drivers/video/omap2/dss/dpi.c:201: error: implicit declaration of func=
tion =E2=80=98dsi_get_pll_clkin=E2=80=99
>> drivers/video/omap2/dss/dpi.c:212: error: implicit declaration of func=
tion =E2=80=98dsi_pll_calc=E2=80=99
>>
>> Enabling OMAP2_DSS_DSI fixes this. This is my proposed patch. You may =
be want to merge it?
>=20
> Thanks for reporting this. We shouldn't make DPI depend on DSI. We
> should make dummy functions for the above when DSI is not enabled so
> that DPI compiles. I'll make a fix.

Patch below. Can you try it out? It works for me on Panda.

 Tomi

=46rom d91bf4127056c68e423109e7c9b46bd0f0b1673a Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 18 Apr 2013 12:16:39 +0300
Subject: [PATCH] OMAPDSS: DPI: fix compilation if DSI not compiled in

Commit 100c826235793345efe06b3558cc9d36166b1e26 (OMAPDSS: DPI: use new
clock calculation code) breaks dpi.c compilation if DSI is not enabled
in the kernel configuration.

Fix compilation by adding dummy inline functions for the ones that dpi.c
references. The functions will never be called, as dpi.c knows that
there is no DSI device available.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
index faaf358..8475893 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -277,6 +277,12 @@ int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
=20
 /* DSI */
+
+typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fint=
,
+		unsigned long pll, void *data);
+typedef bool (*dsi_hsdiv_calc_func)(int regm_dispc, unsigned long dispc,=

+		void *data);
+
 #ifdef CONFIG_OMAP2_DSS_DSI
=20
 struct dentry;
@@ -295,10 +301,6 @@ u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format=
 fmt);
=20
 unsigned long dsi_get_pll_clkin(struct platform_device *dsidev);
=20
-typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fint=
,
-		unsigned long pll, void *data);
-typedef bool (*dsi_hsdiv_calc_func)(int regm_dispc, unsigned long dispc,=

-		void *data);
 bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,
 		unsigned long out_min, dsi_hsdiv_calc_func func, void *data);
 bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
@@ -358,6 +360,27 @@ static inline struct platform_device *dsi_get_dsidev=
_from_id(int module)
 {
 	return NULL;
 }
+
+static inline unsigned long dsi_get_pll_clkin(struct platform_device *ds=
idev)
+{
+	return 0;
+}
+
+static inline bool dsi_hsdiv_calc(struct platform_device *dsidev,
+		unsigned long pll, unsigned long out_min,
+		dsi_hsdiv_calc_func func, void *data)
+{
+	return false;
+}
+
+static inline bool dsi_pll_calc(struct platform_device *dsidev,
+		unsigned long clkin,
+		unsigned long pll_min, unsigned long pll_max,
+		dsi_pll_calc_func func, void *data)
+{
+	return false;
+}
+
 #endif
=20
 /* DPI */
--=20
1.7.10.4




--------------enigC3AAF0118E19969F306FCE76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRb7saAAoJEPo9qoy8lh71vE0P/2K85Xn8IXqvJTsD7+ME32p4
j8huLdSy1SXLdaQfm/FN9sJzov/pgKoX3mX1fBCOi+szR9MRKOAyueTgrmhDbQor
K9UBAZsaIV1ZlCcXszX2YC9sDbcFFlCAAMbICIU2XoNsaXt1I19LDSGVtqttQ2LM
aihMCEEOmepOUS4VyREJIPasVFPjYFkc0FjoZC9BVnaF+XZSVQUyF6s2WkPOWJJh
b+LTCIhZmthOrwgBFODDgqeeugrtNw8gHVXG6qnaz5mS0gUSej6oxLixjT/5hsJn
HGBGawoaaOGfmSe5E0JR5iLwlltBrBFz76t8W9a6qdO5SOFfiw/em2kpCMWoMnjE
LSbXZ1Sr2iueoCskMuDm79DSys4SO723MlqzJlVhLibWRQSkh4zxG7bOnGgmjKKx
Kmee06HRYTgK6puvQJrLINlX8Luj0MU0r94Yn4E+rzk/Fo9qMUhyE2ouU/z6da42
CnUoaeLkB0+PpXJKEbwUhPv8JuaV2BRLrckaKWBwdR/6eETDXupTkWgoceWQv6Yh
kl1bw9tfn2Z14eGCcDKS6jRVowtk9ncxLMxhHqeULN4CQSk4ro909e9mlu0NesCK
B18GOHsxAguty4jnxeFWnQoeC3FfFzRdNLvFadWcvv2nc0Rp1RMkdUD2mQ1dvAxE
YinsIk/k7rFU6ydctY+5
=zzBn
-----END PGP SIGNATURE-----

--------------enigC3AAF0118E19969F306FCE76--
