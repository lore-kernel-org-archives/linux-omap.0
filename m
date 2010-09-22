From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clocks: Fix ES2 clock issues
Date: Wed, 22 Sep 2010 09:50:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220948450.21002@utopia.booyaka.com>
References: <1285170005-2157-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-797535571-1285170607=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35556 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab0IVPuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 11:50:08 -0400
In-Reply-To: <1285170005-2157-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-797535571-1285170607=:21002
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Sep 2010, Benoit Cousson wrote:

> - usim optional clock are its parent had the same name, rename the parent
> usim_fclk -> usim_ck
>=20
> - OPTFCLKEN_CLK32K is not handled anymore by the USBPHYOCP2SCP module in =
ES2
> Create a new clock that belongs to CM_ALWON_USBPHY_CLKCTRL register
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks for the fast update, Beno=EEt; queued for 2.6.37 with some updates t=
o=20
the patch description (below)


- Paul

From=20db1cad403e005c7eda09f7eac45b7c20c8c4500f Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Wed, 22 Sep 2010 17:40:05 +0200
Subject: [PATCH] OMAP4: clocks: Fix ES2 clock issues

Fix a few OMAP4430 clock tree problems after the recent manual merge of the
various ES2 clock patches:

- usim optional clock and its parent had the same name, rename the parent
usim_fclk -> usim_ck

- OPTFCLKEN_CLK32K is not handled anymore by the USBPHYOCP2SCP module in ES=
2
Create a new clock that belongs to CM_ALWON_USBPHY_CLKCTRL register

This patch depends on some of the PRCM macro updates from Rajendra.


Signed-off-by: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: tweaked patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   88 +++++++++++++++++++++---------=
----
 1 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clo=
ck44xx_data.c
index d612e55..edf2c28 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2033,23 +2033,23 @@ static struct clk mmc5_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk ocp2scp_usb_phy_clk32k =3D {
-=09.name=09=09=3D "ocp2scp_usb_phy_clk32k",
+static struct clk ocp2scp_usb_phy_phy_48m =3D {
+=09.name=09=09=3D "ocp2scp_usb_phy_phy_48m",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
 =09.clkdm_name=09=3D "l3_init_clkdm",
-=09.parent=09=09=3D &sys_32k_ck,
+=09.parent=09=09=3D &func_48m_fclk,
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
-static struct clk ocp2scp_usb_phy_phy_48m =3D {
-=09.name=09=09=3D "ocp2scp_usb_phy_phy_48m",
+static struct clk ocp2scp_usb_phy_ick =3D {
+=09.name=09=09=3D "ocp2scp_usb_phy_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
 =09.enable_reg=09=3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
+=09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
 =09.clkdm_name=09=3D "l3_init_clkdm",
-=09.parent=09=09=3D &func_48m_fclk,
+=09.parent=09=09=3D &l4_div_ck,
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
@@ -2595,6 +2595,16 @@ static struct clk usb_otg_hs_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk usb_phy_cm_clk32k =3D {
+=09.name=09=09=3D "usb_phy_cm_clk32k",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_ALWON_USBPHY_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+=09.clkdm_name=09=3D "l4_ao_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk usb_tll_hs_usb_ch2_clk =3D {
 =09.name=09=09=3D "usb_tll_hs_usb_ch2_clk",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2635,6 +2645,39 @@ static struct clk usb_tll_hs_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static const struct clksel_rate div2_14to18_rates[] =3D {
+=09{ .div =3D 14, .val =3D 0, .flags =3D RATE_IN_4430 },
+=09{ .div =3D 18, .val =3D 1, .flags =3D RATE_IN_4430 },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel usim_fclk_div[] =3D {
+=09{ .parent =3D &dpll_per_m4_ck, .rates =3D div2_14to18_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk usim_ck =3D {
+=09.name=09=09=3D "usim_ck",
+=09.parent=09=09=3D &dpll_per_m4_ck,
+=09.clksel=09=09=3D usim_fclk_div,
+=09.clksel_reg=09=3D OMAP4430_CM_WKUP_USIM_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_DIV_MASK,
+=09.ops=09=09=3D &clkops_null,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.round_rate=09=3D &omap2_clksel_round_rate,
+=09.set_rate=09=3D &omap2_clksel_set_rate,
+};
+
+static struct clk usim_fclk =3D {
+=09.name=09=09=3D "usim_fclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_WKUP_USIM_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_FCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.parent=09=09=3D &usim_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk usim_fck =3D {
 =09.name=09=09=3D "usim_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2700,29 +2743,6 @@ static struct clk trace_clk_div_ck =3D {
 =09.set_rate=09=3D &omap2_clksel_set_rate,
 };
=20
-static const struct clksel_rate div2_14to18_rates[] =3D {
-=09{ .div =3D 14, .val =3D 0, .flags =3D RATE_IN_4430 },
-=09{ .div =3D 18, .val =3D 1, .flags =3D RATE_IN_4430 },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel usim_fclk_div[] =3D {
-=09{ .parent =3D &dpll_per_m4_ck, .rates =3D div2_14to18_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk usim_fclk =3D {
-=09.name=09=09=3D "usim_fclk",
-=09.parent=09=09=3D &dpll_per_m4_ck,
-=09.clksel=09=09=3D usim_fclk_div,
-=09.clksel_reg=09=3D OMAP4430_CM_WKUP_USIM_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_DIV_MASK,
-=09.ops=09=09=3D &clkops_null,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.round_rate=09=3D &omap2_clksel_round_rate,
-=09.set_rate=09=3D &omap2_clksel_set_rate,
-};
-
 /*
  * clkdev
  */
@@ -2879,8 +2899,8 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("mmci-omap-hs.2",=09"fck",=09=09=09=09&mmc3_fck,=09CK_443X),
 =09CLK("mmci-omap-hs.3",=09"fck",=09=09=09=09&mmc4_fck,=09CK_443X),
 =09CLK("mmci-omap-hs.4",=09"fck",=09=09=09=09&mmc5_fck,=09CK_443X),
-=09CLK(NULL,=09"ocp2scp_usb_phy_clk32k",=09&ocp2scp_usb_phy_clk32k,=09CK_4=
43X),
 =09CLK(NULL,=09"ocp2scp_usb_phy_phy_48m",=09&ocp2scp_usb_phy_phy_48m,=09CK=
_443X),
+=09CLK(NULL,=09"ocp2scp_usb_phy_ick",=09=09&ocp2scp_usb_phy_ick,=09CK_443X=
),
 =09CLK(NULL,=09"ocp_wp_noc_ick",=09=09&ocp_wp_noc_ick,=09CK_443X),
 =09CLK("omap_rng",=09"ick",=09=09=09=09&rng_ick,=09CK_443X),
 =09CLK(NULL,=09"sha2md5_fck",=09=09=09&sha2md5_fck,=09CK_443X),
@@ -2927,16 +2947,18 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"otg_60m_gfclk",=09=09&otg_60m_gfclk,=09CK_443X),
 =09CLK(NULL,=09"usb_otg_hs_xclk",=09=09&usb_otg_hs_xclk,=09CK_443X),
 =09CLK("musb_hdrc",=09"ick",=09=09=09=09&usb_otg_hs_ick,=09CK_443X),
+=09CLK(NULL,=09"usb_phy_cm_clk32k",=09=09&usb_phy_cm_clk32k,=09CK_443X),
 =09CLK(NULL,=09"usb_tll_hs_usb_ch2_clk",=09&usb_tll_hs_usb_ch2_clk,=09CK_4=
43X),
 =09CLK(NULL,=09"usb_tll_hs_usb_ch0_clk",=09&usb_tll_hs_usb_ch0_clk,=09CK_4=
43X),
 =09CLK(NULL,=09"usb_tll_hs_usb_ch1_clk",=09&usb_tll_hs_usb_ch1_clk,=09CK_4=
43X),
 =09CLK(NULL,=09"usb_tll_hs_ick",=09=09&usb_tll_hs_ick,=09CK_443X),
+=09CLK(NULL,=09"usim_ck",=09=09=09&usim_ck,=09CK_443X),
+=09CLK(NULL,=09"usim_fclk",=09=09=09&usim_fclk,=09CK_443X),
 =09CLK(NULL,=09"usim_fck",=09=09=09&usim_fck,=09CK_443X),
 =09CLK("omap_wdt",=09"fck",=09=09=09=09&wd_timer2_fck,=09CK_443X),
 =09CLK(NULL,=09"wd_timer3_fck",=09=09&wd_timer3_fck,=09CK_443X),
 =09CLK(NULL,=09"stm_clk_div_ck",=09=09&stm_clk_div_ck,=09CK_443X),
 =09CLK(NULL,=09"trace_clk_div_ck",=09=09&trace_clk_div_ck,=09CK_443X),
-=09CLK(NULL,=09"usim_fclk",=09=09=09&usim_fclk,=09CK_443X),
 =09CLK(NULL,=09"gpmc_ck",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"gpt1_ick",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"gpt2_ick",=09=09=09&dummy_ck,=09CK_443X),
--=20
1.7.1

--155748971-797535571-1285170607=:21002--
