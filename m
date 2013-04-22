From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Mon, 22 Apr 2013 14:51:57 +0300
Message-ID: <5175245D.4010403@ti.com>
References: <516BDD35.4000807@ti.com> <1366274225.4085.44.camel@mars> <516FB845.3070505@ti.com> <516FBB19.4090609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig691BA5F5FBF32ED797A48CA4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57694 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab3DVLwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Apr 2013 07:52:02 -0400
In-Reply-To: <516FBB19.4090609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enig691BA5F5FBF32ED797A48CA4
Content-Type: multipart/mixed;
 boundary="------------090309030600010109040208"

This is a multi-part message in MIME format.
--------------090309030600010109040208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On 2013-04-18 12:21, Tomi Valkeinen wrote:
> On 2013-04-18 12:09, Tomi Valkeinen wrote:
>> On 2013-04-18 11:37, Christoph Fritz wrote:
>=20
>>> With linux-next this patch breaks compiling here because DPI now depe=
nds
>>> on DSI - but my omap3 board here doesn't use DSI at all:
>>>
>>> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_calc_pll_cb=E2=
=80=99:
>>> drivers/video/omap2/dss/dpi.c:181: error: implicit declaration of fun=
ction =E2=80=98dsi_hsdiv_calc=E2=80=99
>>> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_dsi_clk_calc=E2=
=80=99:
>>> drivers/video/omap2/dss/dpi.c:201: error: implicit declaration of fun=
ction =E2=80=98dsi_get_pll_clkin=E2=80=99
>>> drivers/video/omap2/dss/dpi.c:212: error: implicit declaration of fun=
ction =E2=80=98dsi_pll_calc=E2=80=99
>>>
>>> Enabling OMAP2_DSS_DSI fixes this. This is my proposed patch. You may=
 be want to merge it?
>>
>> Thanks for reporting this. We shouldn't make DPI depend on DSI. We
>> should make dummy functions for the above when DSI is not enabled so
>> that DPI compiles. I'll make a fix.
>=20
> Patch below. Can you try it out? It works for me on Panda.

Dave, can you queue the patch below (also attached) to the 3.10 drm
changes? It fixes a compilation issue with the omapdss pull request I
sent earlier.

 Tomi

>=20
>  Tomi
>=20
> From d91bf4127056c68e423109e7c9b46bd0f0b1673a Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Thu, 18 Apr 2013 12:16:39 +0300
> Subject: [PATCH] OMAPDSS: DPI: fix compilation if DSI not compiled in
>=20
> Commit 100c826235793345efe06b3558cc9d36166b1e26 (OMAPDSS: DPI: use new
> clock calculation code) breaks dpi.c compilation if DSI is not enabled
> in the kernel configuration.
>=20
> Fix compilation by adding dummy inline functions for the ones that dpi.=
c
> references. The functions will never be called, as dpi.c knows that
> there is no DSI device available.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dss.h |   31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/ds=
s.h
> index faaf358..8475893 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -277,6 +277,12 @@ int sdi_init_platform_driver(void) __init;
>  void sdi_uninit_platform_driver(void) __exit;
> =20
>  /* DSI */
> +
> +typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fi=
nt,
> +		unsigned long pll, void *data);
> +typedef bool (*dsi_hsdiv_calc_func)(int regm_dispc, unsigned long disp=
c,
> +		void *data);
> +
>  #ifdef CONFIG_OMAP2_DSS_DSI
> =20
>  struct dentry;
> @@ -295,10 +301,6 @@ u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_form=
at fmt);
> =20
>  unsigned long dsi_get_pll_clkin(struct platform_device *dsidev);
> =20
> -typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fi=
nt,
> -		unsigned long pll, void *data);
> -typedef bool (*dsi_hsdiv_calc_func)(int regm_dispc, unsigned long disp=
c,
> -		void *data);
>  bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,=

>  		unsigned long out_min, dsi_hsdiv_calc_func func, void *data);
>  bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,=

> @@ -358,6 +360,27 @@ static inline struct platform_device *dsi_get_dsid=
ev_from_id(int module)
>  {
>  	return NULL;
>  }
> +
> +static inline unsigned long dsi_get_pll_clkin(struct platform_device *=
dsidev)
> +{
> +	return 0;
> +}
> +
> +static inline bool dsi_hsdiv_calc(struct platform_device *dsidev,
> +		unsigned long pll, unsigned long out_min,
> +		dsi_hsdiv_calc_func func, void *data)
> +{
> +	return false;
> +}
> +
> +static inline bool dsi_pll_calc(struct platform_device *dsidev,
> +		unsigned long clkin,
> +		unsigned long pll_min, unsigned long pll_max,
> +		dsi_pll_calc_func func, void *data)
> +{
> +	return false;
> +}
> +
>  #endif
> =20
>  /* DPI */
>=20


--------------090309030600010109040208
Content-Type: text/x-patch;
 name="0001-OMAPDSS-DPI-fix-compilation-if-DSI-not-compiled-in.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-OMAPDSS-DPI-fix-compilation-if-DSI-not-compiled-in.patc";
 filename*1="h"

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


--------------090309030600010109040208--

--------------enig691BA5F5FBF32ED797A48CA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRdSRdAAoJEPo9qoy8lh71pxIQAIegz+X6fLMqayua+CCY1Xtz
CYNw7WUXTg3U5aJiXPAtmfkXpaEut9RQai8Q+JTEQjFl11ImEiirD+qeKEfdBSCl
vdPUk62VlKpqrc1Ak8rOQze4AF94fzxK2WzeabdwMhQI2zFLakjz8tMCnPjOUFfY
tjyGQFDwdjbhiaO9SC+NT6hQ1GNDiaX9zq0mB1NG8MjBMiHz6bBneP+SlR+D3A/U
AigHD5ZPuiDl7FEphwV46a5Drr0Hw/o+uzLKhEH+S/JFypiXFV+h///xIGl+UNYH
mhL3EQhpmVd51wjNYrtwB7mAh4F2CJZrhcQc8Oye9fViq52VcMvnKH+42Q1OPD1d
+IVcijlRuviVHpXslO0IfwsIQtLfsCSFQGkUj2U5O9pPNDTKWuemp4pL69/K/yb+
Xg/rqrtCitQFoqRkUKXFv0K6HeZsqnMbWsvctNLGkI7+CfBdU2xifkcgPnwfaQDB
8uLtGG0dVI5/pC+xJb+HvTzEvseZzywK4hv8ANoBuYeRtFsEx3PcCJkQUFj67Tle
j9xPKcpRocoWBvtbe8PTdBQGJWLI3VoGsgmi3uEUJxvQz4m+sUeU8qXGLuf39EIW
DTQaDxIVJW9/hdmlCj1swgTzJoI9JFFd1EUYzmcNYF5jGadgvMoIPRHpC4xxuW8e
HGvihX8g7DBGNO1oKxXW
=TChQ
-----END PGP SIGNATURE-----

--------------enig691BA5F5FBF32ED797A48CA4--
