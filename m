From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
Date: Fri, 2 Nov 2012 10:49:33 +0200
Message-ID: <5093891D.6070302@ti.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local> <20121101224828.2103.82950.stgit@muffinssi.local> <50936A6E.3020202@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3CEF54D9E0AB2B264A74B2F3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35507 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932399Ab2KBItn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 04:49:43 -0400
In-Reply-To: <50936A6E.3020202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enig3CEF54D9E0AB2B264A74B2F3
Content-Type: multipart/mixed;
 boundary="------------080601080800080704040607"

This is a multi-part message in MIME format.
--------------080601080800080704040607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-02 08:38, Santosh Shilimkar wrote:
> Tony,
>=20
> On Friday 02 November 2012 04:18 AM, Tony Lindgren wrote:
>> This file has only omap_init_consistent_dma_size()
>> left that can be moved to plat-omap/dma.c.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>   arch/arm/plat-omap/Makefile |    2 +-
>>   arch/arm/plat-omap/common.c |   26 --------------------------
>>   arch/arm/plat-omap/dma.c    |    8 ++++++++
>>   3 files changed, 9 insertions(+), 27 deletions(-)
>>   delete mode 100644 arch/arm/plat-omap/common.c
>>
>=20
> [..]
>=20
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index c288b76..00a3a53 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -2146,6 +2146,14 @@ static struct platform_driver
>> omap_system_dma_driver =3D {
>>       },
>>   };
>>
>> +/* This must be called from init_early() */
>> +void __init omap_init_consistent_dma_size(void)
>> +{
>> +#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
>> +    init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20=
);
>> +#endif
>> +}
>> +
> Lets not move this in DMA code since the above is really related
> to frame buffer. It reserves more DMA area for dma_alloc_coherent()
> etc than default 2 MB. Infact, we should no longer need this with
> CMA and memblock in place.
>=20
> Tomi,
> Can we not get rid of the above memory reservation ?

Yes, I think so. This one is only used for the old omapfb, i.e. omap1,
and I have no means to test it out, though. But below is a patch to
remove it. I also attached the patch, as it looks like thunderbird wants
to reformat the pasted patch... I'll remove the
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE from the omapfb driver's Kconfig file
in my tree later.



=46rom 65c22c93928fbaaae846dd7df53343050bbcfc64 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 2 Nov 2012 10:36:13 +0200
Subject: [PATCH] ARM: OMAP: Remove omap_init_consistent_dma_size()

The only thing omap_init_consistent_dma_size() does is increase the
consistent DMA size if CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE is defined.
Increasing the consistent DMA size should no longer be needed with CMA
in place.

This patch removes omap_init_consistent_dma_size() and also
arch/arm/mach-omap2/io.c:omap_common_init_early() which becomes an empty
function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap1/io.c              |    1 -
 arch/arm/mach-omap2/io.c              |   12 ------------
 arch/arm/plat-omap/common.c           |    7 -------
 arch/arm/plat-omap/include/plat/dma.h |    1 -
 4 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6a5baab..b3d0fb3 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -134,7 +134,6 @@ void __init omap1_init_early(void)
 	 */
 	omap1_clk_init();
 	omap1_mux_init();
-	omap_init_consistent_dma_size();
 }

 void __init omap1_init_late(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..2597846 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -354,11 +354,6 @@ static int _set_hwmod_postsetup_state(struct
omap_hwmod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }

-static void __init omap_common_init_early(void)
-{
-	omap_init_consistent_dma_size();
-}
-
 static void __init omap_hwmod_init_postsetup(void)
 {
 	u8 postsetup_state;
@@ -379,7 +374,6 @@ void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
 	omap2xxx_check_revision();
-	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
 	omap242x_clockdomains_init();
@@ -401,7 +395,6 @@ void __init omap2430_init_early(void)
 {
 	omap2_set_globals_243x();
 	omap2xxx_check_revision();
-	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
 	omap243x_clockdomains_init();
@@ -428,7 +421,6 @@ void __init omap3_init_early(void)
 	omap2_set_globals_3xxx();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -462,7 +454,6 @@ void __init ti81xx_init_early(void)
 	omap2_set_globals_ti81xx();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -520,7 +511,6 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_am33xx();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	omap_common_init_early();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
@@ -536,7 +526,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_443x();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
-	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
 	omap44xx_clockdomains_init();
@@ -558,7 +547,6 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_5xxx();
 	omap5xxx_check_revision();
-	omap_common_init_early();
 }
 #endif

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..ab44d34 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -31,13 +31,6 @@ void __init omap_reserve(void)
 	omap_barrier_reserve_memblock();
 }

-void __init omap_init_consistent_dma_size(void)
-{
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
-#endif
-}
-
 /*
  * Stub function for OMAP2 so that common files
  * continue to build when custom builds are used
diff --git a/arch/arm/plat-omap/include/plat/dma.h
b/arch/arm/plat-omap/include/plat/dma.h
index 0a87b05..f1b2ad3 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -449,7 +449,6 @@ struct omap_system_dma_plat_info {
 	u32 (*dma_read)(int reg, int lch);
 };

-extern void __init omap_init_consistent_dma_size(void);
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
--=20
1.7.10.4





--------------080601080800080704040607
Content-Type: text/x-patch;
 name="0001-ARM-OMAP-Remove-omap_init_consistent_dma_size.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-ARM-OMAP-Remove-omap_init_consistent_dma_size.patch"

=46rom 65c22c93928fbaaae846dd7df53343050bbcfc64 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 2 Nov 2012 10:36:13 +0200
Subject: [PATCH] ARM: OMAP: Remove omap_init_consistent_dma_size()

The only thing omap_init_consistent_dma_size() does is increase the
consistent DMA size if CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE is defined.
Increasing the consistent DMA size should no longer be needed with CMA
in place.

This patch removes omap_init_consistent_dma_size() and also
arch/arm/mach-omap2/io.c:omap_common_init_early() which becomes an empty
function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap1/io.c              |    1 -
 arch/arm/mach-omap2/io.c              |   12 ------------
 arch/arm/plat-omap/common.c           |    7 -------
 arch/arm/plat-omap/include/plat/dma.h |    1 -
 4 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6a5baab..b3d0fb3 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -134,7 +134,6 @@ void __init omap1_init_early(void)
 	 */
 	omap1_clk_init();
 	omap1_mux_init();
-	omap_init_consistent_dma_size();
 }
=20
 void __init omap1_init_late(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..2597846 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -354,11 +354,6 @@ static int _set_hwmod_postsetup_state(struct omap_hw=
mod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }
=20
-static void __init omap_common_init_early(void)
-{
-	omap_init_consistent_dma_size();
-}
-
 static void __init omap_hwmod_init_postsetup(void)
 {
 	u8 postsetup_state;
@@ -379,7 +374,6 @@ void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
 	omap2xxx_check_revision();
-	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
 	omap242x_clockdomains_init();
@@ -401,7 +395,6 @@ void __init omap2430_init_early(void)
 {
 	omap2_set_globals_243x();
 	omap2xxx_check_revision();
-	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
 	omap243x_clockdomains_init();
@@ -428,7 +421,6 @@ void __init omap3_init_early(void)
 	omap2_set_globals_3xxx();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -462,7 +454,6 @@ void __init ti81xx_init_early(void)
 	omap2_set_globals_ti81xx();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -520,7 +511,6 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_am33xx();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	omap_common_init_early();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
@@ -536,7 +526,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_443x();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
-	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
 	omap44xx_clockdomains_init();
@@ -558,7 +547,6 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_5xxx();
 	omap5xxx_check_revision();
-	omap_common_init_early();
 }
 #endif
=20
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..ab44d34 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -31,13 +31,6 @@ void __init omap_reserve(void)
 	omap_barrier_reserve_memblock();
 }
=20
-void __init omap_init_consistent_dma_size(void)
-{
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
-#endif
-}
-
 /*
  * Stub function for OMAP2 so that common files
  * continue to build when custom builds are used
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/i=
nclude/plat/dma.h
index 0a87b05..f1b2ad3 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -449,7 +449,6 @@ struct omap_system_dma_plat_info {
 	u32 (*dma_read)(int reg, int lch);
 };
=20
-extern void __init omap_init_consistent_dma_size(void);
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
--=20
1.7.10.4


--------------080601080800080704040607--

--------------enig3CEF54D9E0AB2B264A74B2F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQk4khAAoJEPo9qoy8lh71a+MP/RWrN5S8YxIlth9sFyQ/TOUo
4f0WWHQlHomSKZH+/27kHuFLlJvsntK8fETbVECsHztXJAx8W6H1vgHTmlbt5j+T
MxDYJVZP4fkRtatLueuZs7ZLLj9PFqz/azbX4WBYFNQkkAJz9LYUxvgSxfZZGP3z
g9m95xf2U9dGAB3rZT60ArbzSydDzmOe6zWx2myiIVzokoYMp4HzYMOJwX+Wum+X
U5tiR71M/h1/9ohnSQQAFPxGcN7B3e9FCBJ53fjgJYEHunWdg4R7u4ZMMt0js5/E
wCew5oXfjnEBQnsGrqIx8b9JCpJamX6kkXmKdn2Vt8sJzk4OV5P2PMFpv7xl/ZAU
cROWrMNgtNJWsFp7bojMj/fE2oR/CE0oonkKlTkqIcdC82qKc2tdHJ/OoVEs0nsG
SkUGGV+NAcddk6Ay4qqwDS8QG4p6XAjn6ZB75W3IRY8IBxlecFVR8PqYZsOxR5/r
SVYd1/mTRoaFwRk0+WqGVcDKhpqERPNWysf8wIuHhiiR8NzStI/pPLpP8wRccHhm
y+CNK8DiQzU2V1AjYL7Zmk0KPMF81xFnOhLcirUFTN3i/LP7wqLTTQirjw9yqwXw
ZjG9BqXDS//R07lRAO9xy7iYKN1MRB0ojexbOBIsGoheVTRiJO4mOVmbtftozAaW
xEL5T6Y4spNUWpPps2EU
=LqmZ
-----END PGP SIGNATURE-----

--------------enig3CEF54D9E0AB2B264A74B2F3--
