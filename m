From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] ARM: OMAP2: Clock: Combine 34xx l3_icks and l4_icks
Date: Tue, 19 Aug 2008 11:40:01 +0300
Message-ID: <1219135201-10282-11-git-send-email-tony@atomide.com>
References: <20080818163429.GF16455@flint.arm.linux.org.uk>
 <1219135201-10282-1-git-send-email-tony@atomide.com>
 <1219135201-10282-2-git-send-email-tony@atomide.com>
 <1219135201-10282-3-git-send-email-tony@atomide.com>
 <1219135201-10282-4-git-send-email-tony@atomide.com>
 <1219135201-10282-5-git-send-email-tony@atomide.com>
 <1219135201-10282-6-git-send-email-tony@atomide.com>
 <1219135201-10282-7-git-send-email-tony@atomide.com>
 <1219135201-10282-8-git-send-email-tony@atomide.com>
 <1219135201-10282-9-git-send-email-tony@atomide.com>
 <1219135201-10282-10-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63850 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbYHSIki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 04:40:38 -0400
In-Reply-To: <1219135201-10282-10-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, =?utf-8?q?H=C3=B6gander=20Jouni?= <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>

=46rom: H=C3=B6gander Jouni <jouni.hogander@nokia.com>

E.g dss_l3_ick and dss_l4_ick have same gating control. Having own
clock for both of them causes race condition between enable / disable.

This patch combines this kind of clocks and names new clock as <module>=
_ick.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index bb01e20..c38a8a0 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1189,27 +1189,34 @@ static const struct clksel gfx_l3_clksel[] =3D =
{
 	{ .parent =3D NULL }
 };
=20
-static struct clk gfx_l3_fck =3D {
-	.name		=3D "gfx_l3_fck",
+/* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
+static struct clk gfx_l3_ck =3D {
+	.name		=3D "gfx_l3_ck",
 	.parent		=3D &l3_ick,
 	.init		=3D &omap2_init_clksel_parent,
 	.enable_reg	=3D OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP_EN_GFX_SHIFT,
+	.flags		=3D CLOCK_IN_OMAP3430ES1,
+	.recalc		=3D &followparent_recalc,
+};
+
+static struct clk gfx_l3_fck =3D {
+	.name		=3D "gfx_l3_fck",
+	.parent		=3D &gfx_l3_ck,
+	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	=3D OMAP_CLKSEL_GFX_MASK,
 	.clksel		=3D gfx_l3_clksel,
-	.flags		=3D CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
+	.flags		=3D CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.clkdm_name	=3D "gfx_3430es1_clkdm",
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20
 static struct clk gfx_l3_ick =3D {
 	.name		=3D "gfx_l3_ick",
-	.parent		=3D &l3_ick,
-	.init		=3D &omap2_init_clk_clkdm,
-	.enable_reg	=3D OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
-	.enable_bit	=3D OMAP_EN_GFX_SHIFT,
-	.flags		=3D CLOCK_IN_OMAP3430ES1,
+	.parent		=3D &gfx_l3_ck,
+	.flags		=3D CLOCK_IN_OMAP3430ES1 | PARENT_CONTROLS_CLOCK,
 	.clkdm_name	=3D "gfx_3430es1_clkdm",
 	.recalc		=3D &followparent_recalc,
 };
@@ -2153,19 +2160,9 @@ static struct clk cam_mclk =3D {
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20
-static struct clk cam_l3_ick =3D {
-	.name		=3D "cam_l3_ick",
-	.parent		=3D &l3_ick,
-	.init		=3D &omap2_init_clk_clkdm,
-	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
-	.enable_bit	=3D OMAP3430_EN_CAM_SHIFT,
-	.flags		=3D CLOCK_IN_OMAP343X,
-	.clkdm_name	=3D "cam_clkdm",
-	.recalc		=3D &followparent_recalc,
-};
-
-static struct clk cam_l4_ick =3D {
-	.name		=3D "cam_l4_ick",
+static struct clk cam_ick =3D {
+	/* Handles both L3 and L4 clocks */
+	.name		=3D "cam_ick",
 	.parent		=3D &l4_ick,
 	.init		=3D &omap2_init_clk_clkdm,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
@@ -2199,19 +2196,9 @@ static struct clk usbhost_48m_fck =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
-static struct clk usbhost_l3_ick =3D {
-	.name		=3D "usbhost_l3_ick",
-	.parent		=3D &l3_ick,
-	.init		=3D &omap2_init_clk_clkdm,
-	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
-	.enable_bit	=3D OMAP3430ES2_EN_USBHOST_SHIFT,
-	.flags		=3D CLOCK_IN_OMAP3430ES2,
-	.clkdm_name	=3D "usbhost_clkdm",
-	.recalc		=3D &followparent_recalc,
-};
-
-static struct clk usbhost_l4_ick =3D {
-	.name		=3D "usbhost_l4_ick",
+static struct clk usbhost_ick =3D {
+	/* Handles both L3 and L4 clocks */
+	.name		=3D "usbhost_ick",
 	.parent		=3D &l4_ick,
 	.init		=3D &omap2_init_clk_clkdm,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
@@ -3093,6 +3080,7 @@ static struct clk *onchip_34xx_clks[] __initdata =
=3D {
 	&l3_ick,
 	&l4_ick,
 	&rm_ick,
+	&gfx_l3_ck,
 	&gfx_l3_fck,
 	&gfx_l3_ick,
 	&gfx_cg1_ck,
@@ -3174,12 +3162,10 @@ static struct clk *onchip_34xx_clks[] __initdat=
a =3D {
 	&dss2_alwon_fck,
 	&dss_ick,
 	&cam_mclk,
-	&cam_l3_ick,
-	&cam_l4_ick,
+	&cam_ick,
 	&usbhost_120m_fck,
 	&usbhost_48m_fck,
-	&usbhost_l3_ick,
-	&usbhost_l4_ick,
+	&usbhost_ick,
 	&usbhost_sar_fck,
 	&usim_fck,
 	&gpt1_fck,
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
