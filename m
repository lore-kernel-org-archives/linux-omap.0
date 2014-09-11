From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] clk: don't use __initconst for non-const arrays
Date: Thu, 11 Sep 2014 23:04:31 +0200
Message-ID: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53397 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbaIKVGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 17:06:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <t.figa@samsung.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, kernel@pengutronix.de

The statement

	static const char *name[];

defines a modifiable array of pointers to constant chars. That is

	*name[0] =3D 'f';

is forbidden, but

	name[0] =3D "f";

is not. So marking an array that is defined as above with __initconst i=
s
wrong. Either an additional const must be added such that the whole
definition reads:

	static const char *const name[] __initconst;

or where this is not possible __initdata must be used.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/hisilicon/clk-hix5hd2.c |  6 ++--
 drivers/clk/mxs/clk-imx23.c         | 12 ++++----
 drivers/clk/mxs/clk-imx28.c         | 18 ++++++------
 drivers/clk/rockchip/clk.h          |  2 +-
 drivers/clk/samsung/clk-s5pv210.c   | 56 ++++++++++++++++++-----------=
--------
 drivers/clk/ti/composite.c          |  2 +-
 6 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilico=
n/clk-hix5hd2.c
index e5fcfb4e32ef..7acae2eeb490 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -44,15 +44,15 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_r=
ate_clks[] __initdata =3D {
 	{ HIX5HD2_FIXED_83M, "83m", NULL, CLK_IS_ROOT, 83333333, },
 };
=20
-static const char *sfc_mux_p[] __initconst =3D {
+static const char *sfc_mux_p[] __initdata =3D {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] =3D {0, 4, 5, 6, 7};
=20
-static const char *sdio1_mux_p[] __initconst =3D {
+static const char *sdio1_mux_p[] __initdata =3D {
 		"75m", "100m", "50m", "15m", };
 static u32 sdio1_mux_table[] =3D {0, 1, 2, 3};
=20
-static const char *fephy_mux_p[] __initconst =3D { "25m", "125m"};
+static const char *fephy_mux_p[] __initdata =3D { "25m", "125m"};
 static u32 fephy_mux_table[] =3D {0, 1};
=20
=20
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 9fc9359f5133..22d136aa699f 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -77,12 +77,12 @@ static void __init clk_misc_init(void)
 	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
 }
=20
-static const char *sel_pll[]  __initconst =3D { "pll", "ref_xtal", };
-static const char *sel_cpu[]  __initconst =3D { "ref_cpu", "ref_xtal",=
 };
-static const char *sel_pix[]  __initconst =3D { "ref_pix", "ref_xtal",=
 };
-static const char *sel_io[]   __initconst =3D { "ref_io", "ref_xtal", =
};
-static const char *cpu_sels[] __initconst =3D { "cpu_pll", "cpu_xtal",=
 };
-static const char *emi_sels[] __initconst =3D { "emi_pll", "emi_xtal",=
 };
+static const char *sel_pll[]  __initdata =3D { "pll", "ref_xtal", };
+static const char *sel_cpu[]  __initdata =3D { "ref_cpu", "ref_xtal", =
};
+static const char *sel_pix[]  __initdata =3D { "ref_pix", "ref_xtal", =
};
+static const char *sel_io[]   __initdata =3D { "ref_io", "ref_xtal", }=
;
+static const char *cpu_sels[] __initdata =3D { "cpu_pll", "cpu_xtal", =
};
+static const char *emi_sels[] __initdata =3D { "emi_pll", "emi_xtal", =
};
=20
 enum imx23_clk {
 	ref_xtal, pll, ref_cpu, ref_emi, ref_pix, ref_io, saif_sel,
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index a6c35010e4e5..b1be3746ce95 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -125,15 +125,15 @@ static void __init clk_misc_init(void)
 	writel_relaxed(val, FRAC0);
 }
=20
-static const char *sel_cpu[]  __initconst =3D { "ref_cpu", "ref_xtal",=
 };
-static const char *sel_io0[]  __initconst =3D { "ref_io0", "ref_xtal",=
 };
-static const char *sel_io1[]  __initconst =3D { "ref_io1", "ref_xtal",=
 };
-static const char *sel_pix[]  __initconst =3D { "ref_pix", "ref_xtal",=
 };
-static const char *sel_gpmi[] __initconst =3D { "ref_gpmi", "ref_xtal"=
, };
-static const char *sel_pll0[] __initconst =3D { "pll0", "ref_xtal", };
-static const char *cpu_sels[] __initconst =3D { "cpu_pll", "cpu_xtal",=
 };
-static const char *emi_sels[] __initconst =3D { "emi_pll", "emi_xtal",=
 };
-static const char *ptp_sels[] __initconst =3D { "ref_xtal", "pll0", };
+static const char *sel_cpu[]  __initdata =3D { "ref_cpu", "ref_xtal", =
};
+static const char *sel_io0[]  __initdata =3D { "ref_io0", "ref_xtal", =
};
+static const char *sel_io1[]  __initdata =3D { "ref_io1", "ref_xtal", =
};
+static const char *sel_pix[]  __initdata =3D { "ref_pix", "ref_xtal", =
};
+static const char *sel_gpmi[] __initdata =3D { "ref_gpmi", "ref_xtal",=
 };
+static const char *sel_pll0[] __initdata =3D { "pll0", "ref_xtal", };
+static const char *cpu_sels[] __initdata =3D { "cpu_pll", "cpu_xtal", =
};
+static const char *emi_sels[] __initdata =3D { "emi_pll", "emi_xtal", =
};
+static const char *ptp_sels[] __initdata =3D { "ref_xtal", "pll0", };
=20
 enum imx28_clk {
 	ref_xtal, pll0, pll1, pll2, ref_cpu, ref_emi, ref_io0, ref_io1,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 887cbdeca2aa..74fbb9c4b6de 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -120,7 +120,7 @@ struct clk *rockchip_clk_register_pll(enum rockchip=
_pll_type pll_type,
 		struct rockchip_pll_rate_table *rate_table,
 		spinlock_t *lock);
=20
-#define PNAME(x) static const char *x[] __initconst
+#define PNAME(x) static const char *x[] __initdata
=20
 enum rockchip_clk_branch_type {
 	branch_composite,
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/cl=
k-s5pv210.c
index d270a2084644..e668e479a697 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -169,44 +169,44 @@ static inline void s5pv210_clk_sleep_init(void) {=
 }
 #endif
=20
 /* Mux parent lists. */
-static const char *fin_pll_p[] __initconst =3D {
+static const char *fin_pll_p[] __initdata =3D {
 	"xxti",
 	"xusbxti"
 };
=20
-static const char *mout_apll_p[] __initconst =3D {
+static const char *mout_apll_p[] __initdata =3D {
 	"fin_pll",
 	"fout_apll"
 };
=20
-static const char *mout_mpll_p[] __initconst =3D {
+static const char *mout_mpll_p[] __initdata =3D {
 	"fin_pll",
 	"fout_mpll"
 };
=20
-static const char *mout_epll_p[] __initconst =3D {
+static const char *mout_epll_p[] __initdata =3D {
 	"fin_pll",
 	"fout_epll"
 };
=20
-static const char *mout_vpllsrc_p[] __initconst =3D {
+static const char *mout_vpllsrc_p[] __initdata =3D {
 	"fin_pll",
 	"sclk_hdmi27m"
 };
=20
-static const char *mout_vpll_p[] __initconst =3D {
+static const char *mout_vpll_p[] __initdata =3D {
 	"mout_vpllsrc",
 	"fout_vpll"
 };
=20
-static const char *mout_group1_p[] __initconst =3D {
+static const char *mout_group1_p[] __initdata =3D {
 	"dout_a2m",
 	"mout_mpll",
 	"mout_epll",
 	"mout_vpll"
 };
=20
-static const char *mout_group2_p[] __initconst =3D {
+static const char *mout_group2_p[] __initdata =3D {
 	"xxti",
 	"xusbxti",
 	"sclk_hdmi27m",
@@ -218,7 +218,7 @@ static const char *mout_group2_p[] __initconst =3D =
{
 	"mout_vpll",
 };
=20
-static const char *mout_audio0_p[] __initconst =3D {
+static const char *mout_audio0_p[] __initdata =3D {
 	"xxti",
 	"pcmcdclk0",
 	"sclk_hdmi27m",
@@ -230,7 +230,7 @@ static const char *mout_audio0_p[] __initconst =3D =
{
 	"mout_vpll",
 };
=20
-static const char *mout_audio1_p[] __initconst =3D {
+static const char *mout_audio1_p[] __initdata =3D {
 	"i2scdclk1",
 	"pcmcdclk1",
 	"sclk_hdmi27m",
@@ -242,7 +242,7 @@ static const char *mout_audio1_p[] __initconst =3D =
{
 	"mout_vpll",
 };
=20
-static const char *mout_audio2_p[] __initconst =3D {
+static const char *mout_audio2_p[] __initdata =3D {
 	"i2scdclk2",
 	"pcmcdclk2",
 	"sclk_hdmi27m",
@@ -254,63 +254,63 @@ static const char *mout_audio2_p[] __initconst =3D=
 {
 	"mout_vpll",
 };
=20
-static const char *mout_spdif_p[] __initconst =3D {
+static const char *mout_spdif_p[] __initdata =3D {
 	"dout_audio0",
 	"dout_audio1",
 	"dout_audio3",
 };
=20
-static const char *mout_group3_p[] __initconst =3D {
+static const char *mout_group3_p[] __initdata =3D {
 	"mout_apll",
 	"mout_mpll"
 };
=20
-static const char *mout_group4_p[] __initconst =3D {
+static const char *mout_group4_p[] __initdata =3D {
 	"mout_mpll",
 	"dout_a2m"
 };
=20
-static const char *mout_flash_p[] __initconst =3D {
+static const char *mout_flash_p[] __initdata =3D {
 	"dout_hclkd",
 	"dout_hclkp"
 };
=20
-static const char *mout_dac_p[] __initconst =3D {
+static const char *mout_dac_p[] __initdata =3D {
 	"mout_vpll",
 	"sclk_hdmiphy"
 };
=20
-static const char *mout_hdmi_p[] __initconst =3D {
+static const char *mout_hdmi_p[] __initdata =3D {
 	"sclk_hdmiphy",
 	"dout_tblk"
 };
=20
-static const char *mout_mixer_p[] __initconst =3D {
+static const char *mout_mixer_p[] __initdata =3D {
 	"mout_dac",
 	"mout_hdmi"
 };
=20
-static const char *mout_vpll_6442_p[] __initconst =3D {
+static const char *mout_vpll_6442_p[] __initdata =3D {
 	"fin_pll",
 	"fout_vpll"
 };
=20
-static const char *mout_mixer_6442_p[] __initconst =3D {
+static const char *mout_mixer_6442_p[] __initdata =3D {
 	"mout_vpll",
 	"dout_mixer"
 };
=20
-static const char *mout_d0sync_6442_p[] __initconst =3D {
+static const char *mout_d0sync_6442_p[] __initdata =3D {
 	"mout_dsys",
 	"div_apll"
 };
=20
-static const char *mout_d1sync_6442_p[] __initconst =3D {
+static const char *mout_d1sync_6442_p[] __initdata =3D {
 	"mout_psys",
 	"div_apll"
 };
=20
-static const char *mout_group2_6442_p[] __initconst =3D {
+static const char *mout_group2_6442_p[] __initdata =3D {
 	"fin_pll",
 	"none",
 	"none",
@@ -322,7 +322,7 @@ static const char *mout_group2_6442_p[] __initconst=
 =3D {
 	"mout_vpll",
 };
=20
-static const char *mout_audio0_6442_p[] __initconst =3D {
+static const char *mout_audio0_6442_p[] __initdata =3D {
 	"fin_pll",
 	"pcmcdclk0",
 	"none",
@@ -334,7 +334,7 @@ static const char *mout_audio0_6442_p[] __initconst=
 =3D {
 	"mout_vpll",
 };
=20
-static const char *mout_audio1_6442_p[] __initconst =3D {
+static const char *mout_audio1_6442_p[] __initdata =3D {
 	"i2scdclk1",
 	"pcmcdclk1",
 	"none",
@@ -347,7 +347,7 @@ static const char *mout_audio1_6442_p[] __initconst=
 =3D {
 	"fin_pll",
 };
=20
-static const char *mout_clksel_p[] __initconst =3D {
+static const char *mout_clksel_p[] __initdata =3D {
 	"fout_apll_clkout",
 	"fout_mpll_clkout",
 	"fout_epll",
@@ -370,7 +370,7 @@ static const char *mout_clksel_p[] __initconst =3D =
{
 	"div_dclk"
 };
=20
-static const char *mout_clksel_6442_p[] __initconst =3D {
+static const char *mout_clksel_6442_p[] __initdata =3D {
 	"fout_apll_clkout",
 	"fout_mpll_clkout",
 	"fout_epll",
@@ -393,7 +393,7 @@ static const char *mout_clksel_6442_p[] __initconst=
 =3D {
 	"div_dclk"
 };
=20
-static const char *mout_clkout_p[] __initconst =3D {
+static const char *mout_clkout_p[] __initdata =3D {
 	"dout_clkout",
 	"none",
 	"xxti",
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 19d8980ba458..c429c65b5b21 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -67,7 +67,7 @@ struct component_clk {
 	struct list_head link;
 };
=20
-static const char * __initconst component_clk_types[] =3D {
+static const char * const component_clk_types[] __initconst =3D {
 	"gate", "divider", "mux"
 };
=20
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
