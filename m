From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Sat, 10 Mar 2012 00:08:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203092355280.27395@utopia.booyaka.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com> <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com> <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com> <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1122969132-1331362595=:27395"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab2CJHIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Mar 2012 02:08:41 -0500
In-Reply-To: <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
Content-ID: <alpine.DEB.2.00.1203100005410.27395@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1122969132-1331362595=:27395
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1203100005411.27395@utopia.booyaka.com>


Hello P=E9ter

could you please try this patch instead of the clkdev change?

It is based on my 'hwmod_enable_remaining_hwmods_devel_3.4' branch, but=20
the basic idea should work on v3.3-rc6 as well.

If it works for you, please let us know and we can queue this up along=20
with the hwmod data changes.  Probably we should replace the changelog=20
also with the one from your patch, it might be a little more useful? =20
Suggestions welcome.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 9 Mar 2012 23:28:28 -0700
Subject: [PATCH] ARM: OMAP4: hwmod data: add McBSP parent clock aliases

Add optional parent clocks for the OMAP4 McBSP modules so the driver
can switch between parent clocks.

Based on a patch from P=E9ter Ujfalusi <peter.ujfalusi@ti.com>.
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++++++++++++=
++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index e029992..b4a061d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1921,6 +1921,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp1_sd=
ma_reqs[] =3D {
 =09{ .dma_req =3D -1 }
 };
=20
+static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] =3D {
+=09{ .role =3D "pad_fck", .clk =3D "pad_clks_ck" },
+=09{ .role =3D "prcm_clk", .clk =3D "mcbsp1_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp1_hwmod =3D {
 =09.name=09=09=3D "mcbsp1",
 =09.class=09=09=3D &omap44xx_mcbsp_hwmod_class,
@@ -1935,6 +1940,8 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod =3D {
 =09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
 =09=09},
 =09},
+=09.opt_clks=09=3D mcbsp1_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcbsp1_opt_clks),
 };
=20
 /* mcbsp2 */
@@ -1949,6 +1956,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp2_sd=
ma_reqs[] =3D {
 =09{ .dma_req =3D -1 }
 };
=20
+static struct omap_hwmod_opt_clk mcbsp2_opt_clks[] =3D {
+=09{ .role =3D "pad_fck", .clk =3D "pad_clks_ck" },
+=09{ .role =3D "prcm_clk", .clk =3D "mcbsp2_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp2_hwmod =3D {
 =09.name=09=09=3D "mcbsp2",
 =09.class=09=09=3D &omap44xx_mcbsp_hwmod_class,
@@ -1963,6 +1975,8 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod =3D {
 =09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
 =09=09},
 =09},
+=09.opt_clks=09=3D mcbsp2_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcbsp2_opt_clks),
 };
=20
 /* mcbsp3 */
@@ -1977,6 +1991,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp3_sd=
ma_reqs[] =3D {
 =09{ .dma_req =3D -1 }
 };
=20
+static struct omap_hwmod_opt_clk mcbsp3_opt_clks[] =3D {
+=09{ .role =3D "pad_fck", .clk =3D "pad_clks_ck" },
+=09{ .role =3D "prcm_clk", .clk =3D "mcbsp3_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp3_hwmod =3D {
 =09.name=09=09=3D "mcbsp3",
 =09.class=09=09=3D &omap44xx_mcbsp_hwmod_class,
@@ -1991,6 +2010,8 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod =3D {
 =09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
 =09=09},
 =09},
+=09.opt_clks=09=3D mcbsp3_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcbsp3_opt_clks),
 };
=20
 /* mcbsp4 */
@@ -2005,6 +2026,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp4_sd=
ma_reqs[] =3D {
 =09{ .dma_req =3D -1 }
 };
=20
+static struct omap_hwmod_opt_clk mcbsp4_opt_clks[] =3D {
+=09{ .role =3D "pad_fck", .clk =3D "pad_clks_ck" },
+=09{ .role =3D "prcm_clk", .clk =3D "mcbsp4_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp4_hwmod =3D {
 =09.name=09=09=3D "mcbsp4",
 =09.class=09=09=3D &omap44xx_mcbsp_hwmod_class,
@@ -2019,6 +2045,8 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod =3D {
 =09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
 =09=09},
 =09},
+=09.opt_clks=09=3D mcbsp4_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcbsp4_opt_clks),
 };
=20
 /*
--=20
1.7.9.1

--155748971-1122969132-1331362595=:27395--
