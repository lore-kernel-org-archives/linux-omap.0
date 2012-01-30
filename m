From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] ARM: OMAP4: hwmod data: remove pseudo-hwmods associated
 with hardreset lines
Date: Mon, 30 Jan 2012 03:18:15 -0700
Message-ID: <20120130101813.10450.9839.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42193 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab2A3KSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 05:18:44 -0500
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Remove the pseudo-hwmods associated with hardreset lines from the
OMAP4 data file.  Future patches will convert this data to register
hwmods by interfaces, rather than registering hwmods directly; and
these pseudo-hwmods aren't associated with any interfaces.

The hwmod code now resets processor IPs at the hwmod level, rather
than individually.  So, for example, if the IVA device driver code
wishes to place one of the sequencer cores into reset, while leaving
the other active, it must do so itself by calling the appropriate PRM
functions.

This patch will cause a change in the initialization behavior of the
DSP, IVA, and IPU.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  101 +-------------------=
--------
 1 files changed, 3 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index f9f1510..a3efb9e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1105,11 +1105,8 @@ static struct omap_hwmod_irq_info omap44xx_dsp_i=
rqs[] =3D {
 };
=20
 static struct omap_hwmod_rst_info omap44xx_dsp_resets[] =3D {
-	{ .name =3D "mmu_cache", .rst_shift =3D 1 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_dsp_c0_resets[] =3D {
 	{ .name =3D "dsp", .rst_shift =3D 0 },
+	{ .name =3D "mmu_cache", .rst_shift =3D 1 },
 };
=20
 /* dsp -> iva */
@@ -1139,21 +1136,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dsp_sl=
aves[] =3D {
 	&omap44xx_l4_cfg__dsp,
 };
=20
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_dsp_c0_hwmod =3D {
-	.name		=3D "dsp_c0",
-	.class		=3D &omap44xx_dsp_hwmod_class,
-	.clkdm_name	=3D "tesla_clkdm",
-	.flags		=3D HWMOD_INIT_NO_RESET,
-	.rst_lines	=3D omap44xx_dsp_c0_resets,
-	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_dsp_c0_resets),
-	.prcm =3D {
-		.omap4 =3D {
-			.rstctrl_offs =3D OMAP4_RM_TESLA_RSTCTRL_OFFSET,
-		},
-	},
-};
-
 static struct omap_hwmod omap44xx_dsp_hwmod =3D {
 	.name		=3D "dsp",
 	.class		=3D &omap44xx_dsp_hwmod_class,
@@ -2502,15 +2484,9 @@ static struct omap_hwmod_irq_info omap44xx_ipu_i=
rqs[] =3D {
 	{ .irq =3D -1 }
 };
=20
-static struct omap_hwmod_rst_info omap44xx_ipu_c0_resets[] =3D {
+static struct omap_hwmod_rst_info omap44xx_ipu_resets[] =3D {
 	{ .name =3D "cpu0", .rst_shift =3D 0 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_ipu_c1_resets[] =3D {
 	{ .name =3D "cpu1", .rst_shift =3D 1 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_ipu_resets[] =3D {
 	{ .name =3D "mmu_cache", .rst_shift =3D 2 },
 };
=20
@@ -2532,36 +2508,6 @@ static struct omap_hwmod_ocp_if *omap44xx_ipu_sl=
aves[] =3D {
 	&omap44xx_l3_main_2__ipu,
 };
=20
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_ipu_c0_hwmod =3D {
-	.name		=3D "ipu_c0",
-	.class		=3D &omap44xx_ipu_hwmod_class,
-	.clkdm_name	=3D "ducati_clkdm",
-	.flags		=3D HWMOD_INIT_NO_RESET,
-	.rst_lines	=3D omap44xx_ipu_c0_resets,
-	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_ipu_c0_resets),
-	.prcm =3D {
-		.omap4 =3D {
-			.rstctrl_offs =3D OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
-		},
-	},
-};
-
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_ipu_c1_hwmod =3D {
-	.name		=3D "ipu_c1",
-	.class		=3D &omap44xx_ipu_hwmod_class,
-	.clkdm_name	=3D "ducati_clkdm",
-	.flags		=3D HWMOD_INIT_NO_RESET,
-	.rst_lines	=3D omap44xx_ipu_c1_resets,
-	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_ipu_c1_resets),
-	.prcm =3D {
-		.omap4 =3D {
-			.rstctrl_offs =3D OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
-		},
-	},
-};
-
 static struct omap_hwmod omap44xx_ipu_hwmod =3D {
 	.name		=3D "ipu",
 	.class		=3D &omap44xx_ipu_hwmod_class,
@@ -2691,15 +2637,9 @@ static struct omap_hwmod_irq_info omap44xx_iva_i=
rqs[] =3D {
 };
=20
 static struct omap_hwmod_rst_info omap44xx_iva_resets[] =3D {
-	{ .name =3D "logic", .rst_shift =3D 2 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_iva_seq0_resets[] =3D {
 	{ .name =3D "seq0", .rst_shift =3D 0 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_iva_seq1_resets[] =3D {
 	{ .name =3D "seq1", .rst_shift =3D 1 },
+	{ .name =3D "logic", .rst_shift =3D 2 },
 };
=20
 /* iva master ports */
@@ -2732,36 +2672,6 @@ static struct omap_hwmod_ocp_if *omap44xx_iva_sl=
aves[] =3D {
 	&omap44xx_l3_main_2__iva,
 };
=20
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_iva_seq0_hwmod =3D {
-	.name		=3D "iva_seq0",
-	.class		=3D &omap44xx_iva_hwmod_class,
-	.clkdm_name	=3D "ivahd_clkdm",
-	.flags		=3D HWMOD_INIT_NO_RESET,
-	.rst_lines	=3D omap44xx_iva_seq0_resets,
-	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_iva_seq0_resets),
-	.prcm =3D {
-		.omap4 =3D {
-			.rstctrl_offs =3D OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
-		},
-	},
-};
-
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_iva_seq1_hwmod =3D {
-	.name		=3D "iva_seq1",
-	.class		=3D &omap44xx_iva_hwmod_class,
-	.clkdm_name	=3D "ivahd_clkdm",
-	.flags		=3D HWMOD_INIT_NO_RESET,
-	.rst_lines	=3D omap44xx_iva_seq1_resets,
-	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_iva_seq1_resets),
-	.prcm =3D {
-		.omap4 =3D {
-			.rstctrl_offs =3D OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
-		},
-	},
-};
-
 static struct omap_hwmod omap44xx_iva_hwmod =3D {
 	.name		=3D "iva",
 	.class		=3D &omap44xx_iva_hwmod_class,
@@ -5520,7 +5430,6 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
=20
 	/* dsp class */
 	&omap44xx_dsp_hwmod,
-	&omap44xx_dsp_c0_hwmod,
=20
 	/* dss class */
 	&omap44xx_dss_hwmod,
@@ -5550,16 +5459,12 @@ static __initdata struct omap_hwmod *omap44xx_h=
wmods[] =3D {
=20
 	/* ipu class */
 	&omap44xx_ipu_hwmod,
-	&omap44xx_ipu_c0_hwmod,
-	&omap44xx_ipu_c1_hwmod,
=20
 	/* iss class */
 /*	&omap44xx_iss_hwmod, */
=20
 	/* iva class */
 	&omap44xx_iva_hwmod,
-	&omap44xx_iva_seq0_hwmod,
-	&omap44xx_iva_seq1_hwmod,
=20
 	/* kbd class */
 	&omap44xx_kbd_hwmod,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
