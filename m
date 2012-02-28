From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/9] ARM: OMAP4: hwmod data: remove bandgap hwmod
Date: Tue, 28 Feb 2012 04:10:55 -0700
Message-ID: <20120228111054.808.24406.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35180 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965183Ab2B1LLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:35 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Commit 407a6888f7362cb3dabe69ea6d9dcf3c750dc56a ("OMAP4: hwmod data:
Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU") adds a
hwmod for the bandgap die temperature sensor IP block.  This IP block
has no interconnect port or firewall region, nor does it have an
independent register space or OCP control registers.  Its registers
are embedded in the System Control Module (SCM) IP block.  So it
appears that the bandgap device should be created by the SCM driver.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   30 --------------------=
--------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 264c988..8dfed19 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -824,33 +824,6 @@ static struct omap_hwmod omap44xx_aess_hwmod =3D {
 };
=20
 /*
- * 'bandgap' class
- * bangap reference for ldo regulators
- */
-
-static struct omap_hwmod_class omap44xx_bandgap_hwmod_class =3D {
-	.name	=3D "bandgap",
-};
-
-/* bandgap */
-static struct omap_hwmod_opt_clk bandgap_opt_clks[] =3D {
-	{ .role =3D "fclk", .clk =3D "bandgap_fclk" },
-};
-
-static struct omap_hwmod omap44xx_bandgap_hwmod =3D {
-	.name		=3D "bandgap",
-	.class		=3D &omap44xx_bandgap_hwmod_class,
-	.clkdm_name	=3D "l4_wkup_clkdm",
-	.prcm =3D {
-		.omap4 =3D {
-			.clkctrl_offs =3D OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
-		},
-	},
-	.opt_clks	=3D bandgap_opt_clks,
-	.opt_clks_cnt	=3D ARRAY_SIZE(bandgap_opt_clks),
-};
-
-/*
  * 'counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz =
clock
  */
@@ -5436,9 +5409,6 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
 	/* aess class */
 /*	&omap44xx_aess_hwmod, */
=20
-	/* bandgap class */
-	&omap44xx_bandgap_hwmod,
-
 	/* counter class */
 /*	&omap44xx_counter_32k_hwmod, */
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
