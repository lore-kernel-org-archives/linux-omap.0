From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clock: Add optional clock nodes
Date: Wed, 22 Sep 2010 01:29:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220125520.21002@utopia.booyaka.com>
References: <1285103430-5964-1-git-send-email-b-cousson@ti.com> <1285103430-5964-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-280066124-1285140587=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43498 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0IVH3s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:29:48 -0400
In-Reply-To: <1285103430-5964-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-280066124-1285140587=:21002
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Tue, 21 Sep 2010, Benoit Cousson wrote:

> OMAP4 IP optional clocks require explicit enable in module CTRLCLK
> register. In order to allow that we have to create artificial clock
> nodes that represent this clock inputs in the IP.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Due to the merge conflicts mentioned earlier, this patch had to be=20
manually edited.  The updated patch is below - could you and Rajendra=20
doublecheck it (or at least the final clock44xx_data.c, which will be=20
posted in a few minutes) to make sure that I didn't trash anything too=20
badly?

thanks,

- Paul


From=2064d45f071b43fa6c5e3ecd99d0058494a708f8a7 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 21 Sep 2010 23:10:30 +0200
Subject: [PATCH] OMAP4: clock: Add optional clock nodes

OMAP4 IP optional clocks require explicit enable in module CTRLCLK
register. In order to allow that we have to create artificial clock
nodes that represent this clock inputs in the IP.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  477 +++++++++++++++++++++++++++++-=
----
 1 files changed, 417 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clo=
ck44xx_data.c
index 401a6c4..d612e55 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1284,6 +1284,16 @@ static struct clk aess_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk bandgap_fclk =3D {
+=09.name=09=09=3D "bandgap_fclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_BGAP_32K_SHIFT,
+=09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk des3des_fck =3D {
 =09.name=09=09=3D "des3des_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1344,6 +1354,46 @@ static struct clk dsp_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk dss_sys_clk =3D {
+=09.name=09=09=3D "dss_sys_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_DSS_DSS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_dss_clkdm",
+=09.parent=09=09=3D &syc_clk_div_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_tv_clk =3D {
+=09.name=09=09=3D "dss_tv_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_DSS_DSS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_dss_clkdm",
+=09.parent=09=09=3D &extalt_clkin_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_dss_clk =3D {
+=09.name=09=09=3D "dss_dss_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_DSS_DSS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
+=09.clkdm_name=09=3D "l3_dss_clkdm",
+=09.parent=09=09=3D &dpll_per_m5_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_48mhz_clk =3D {
+=09.name=09=09=3D "dss_48mhz_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_DSS_DSS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_dss_clkdm",
+=09.parent=09=09=3D &func_48mc_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk dss_fck =3D {
 =09.name=09=09=3D "dss_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1417,6 +1467,16 @@ static struct clk fpka_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk gpio1_dbclk =3D {
+=09.name=09=09=3D "gpio1_dbclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk gpio1_ick =3D {
 =09.name=09=09=3D "gpio1_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1427,6 +1487,16 @@ static struct clk gpio1_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk gpio2_dbclk =3D {
+=09.name=09=09=3D "gpio2_dbclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk gpio2_ick =3D {
 =09.name=09=09=3D "gpio2_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1437,6 +1507,16 @@ static struct clk gpio2_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk gpio3_dbclk =3D {
+=09.name=09=09=3D "gpio3_dbclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk gpio3_ick =3D {
 =09.name=09=09=3D "gpio3_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1447,6 +1527,16 @@ static struct clk gpio3_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk gpio4_dbclk =3D {
+=09.name=09=09=3D "gpio4_dbclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk gpio4_ick =3D {
 =09.name=09=09=3D "gpio4_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1457,6 +1547,16 @@ static struct clk gpio4_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk gpio5_dbclk =3D {
+=09.name=09=09=3D "gpio5_dbclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk gpio5_ick =3D {
 =09.name=09=09=3D "gpio5_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1467,6 +1567,16 @@ static struct clk gpio5_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk gpio6_dbclk =3D {
+=09.name=09=09=3D "gpio6_dbclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk gpio6_ick =3D {
 =09.name=09=09=3D "gpio6_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1589,6 +1699,16 @@ static struct clk ipu_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk iss_ctrlclk =3D {
+=09.name=09=09=3D "iss_ctrlclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_CAM_ISS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
+=09.clkdm_name=09=3D "iss_clkdm",
+=09.parent=09=09=3D &func_96m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk iss_fck =3D {
 =09.name=09=09=3D "iss_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1913,6 +2033,26 @@ static struct clk mmc5_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk ocp2scp_usb_phy_clk32k =3D {
+=09.name=09=09=3D "ocp2scp_usb_phy_clk32k",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &sys_32k_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk ocp2scp_usb_phy_phy_48m =3D {
+=09.name=09=09=3D "ocp2scp_usb_phy_phy_48m",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &func_48m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk ocp_wp_noc_ick =3D {
 =09.name=09=09=3D "ocp_wp_noc_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1953,6 +2093,46 @@ static struct clk sl2if_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk slimbus1_fclk_1 =3D {
+=09.name=09=09=3D "slimbus1_fclk_1",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_FCLK1_SHIFT,
+=09.clkdm_name=09=3D "abe_clkdm",
+=09.parent=09=09=3D &func_24m_clk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk slimbus1_fclk_0 =3D {
+=09.name=09=09=3D "slimbus1_fclk_0",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_FCLK0_SHIFT,
+=09.clkdm_name=09=3D "abe_clkdm",
+=09.parent=09=09=3D &abe_24m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk slimbus1_fclk_2 =3D {
+=09.name=09=09=3D "slimbus1_fclk_2",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_FCLK2_SHIFT,
+=09.clkdm_name=09=3D "abe_clkdm",
+=09.parent=09=09=3D &pad_clks_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk slimbus1_slimbus_clk =3D {
+=09.name=09=09=3D "slimbus1_slimbus_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIFT,
+=09.clkdm_name=09=3D "abe_clkdm",
+=09.parent=09=09=3D &slimbus_clk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk slimbus1_fck =3D {
 =09.name=09=09=3D "slimbus1_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -1963,6 +2143,36 @@ static struct clk slimbus1_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk slimbus2_fclk_1 =3D {
+=09.name=09=09=3D "slimbus2_fclk_1",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &per_abe_24m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk slimbus2_fclk_0 =3D {
+=09.name=09=09=3D "slimbus2_fclk_0",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &func_24mc_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk slimbus2_slimbus_clk =3D {
+=09.name=09=09=3D "slimbus2_slimbus_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.parent=09=09=3D &pad_slimbus_core_clks_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk slimbus2_fck =3D {
 =09.name=09=09=3D "slimbus2_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2224,6 +2434,120 @@ static struct clk usb_host_fs_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk usb_host_hs_utmi_p3_clk =3D {
+=09.name=09=09=3D "usb_host_hs_utmi_p3_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic60m_p1_clk =3D {
+=09.name=09=09=3D "usb_host_hs_hsic60m_p1_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic60m_p2_clk =3D {
+=09.name=09=09=3D "usb_host_hs_hsic60m_p2_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static const struct clksel utmi_p1_gfclk_sel[] =3D {
+=09{ .parent =3D &init_60m_fclk, .rates =3D div_1_0_rates },
+=09{ .parent =3D &xclk60mhsp1_ck, .rates =3D div_1_1_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk utmi_p1_gfclk =3D {
+=09.name=09=09=3D "utmi_p1_gfclk",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.clksel=09=09=3D utmi_p1_gfclk_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_UTMI_P1_MASK,
+=09.ops=09=09=3D &clkops_null,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk usb_host_hs_utmi_p1_clk =3D {
+=09.name=09=09=3D "usb_host_hs_utmi_p1_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &utmi_p1_gfclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static const struct clksel utmi_p2_gfclk_sel[] =3D {
+=09{ .parent =3D &init_60m_fclk, .rates =3D div_1_0_rates },
+=09{ .parent =3D &xclk60mhsp2_ck, .rates =3D div_1_1_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk utmi_p2_gfclk =3D {
+=09.name=09=09=3D "utmi_p2_gfclk",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.clksel=09=09=3D utmi_p2_gfclk_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_UTMI_P2_MASK,
+=09.ops=09=09=3D &clkops_null,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk usb_host_hs_utmi_p2_clk =3D {
+=09.name=09=09=3D "usb_host_hs_utmi_p2_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &utmi_p2_gfclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic480m_p1_clk =3D {
+=09.name=09=09=3D "usb_host_hs_hsic480m_p1_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &dpll_usb_m2_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_host_hs_hsic480m_p2_clk =3D {
+=09.name=09=09=3D "usb_host_hs_hsic480m_p2_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &dpll_usb_m2_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_host_hs_func48mclk =3D {
+=09.name=09=09=3D "usb_host_hs_func48mclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &func_48mc_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk usb_host_hs_fck =3D {
 =09.name=09=09=3D "usb_host_hs_fck",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2234,6 +2558,33 @@ static struct clk usb_host_hs_fck =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static const struct clksel otg_60m_gfclk_sel[] =3D {
+=09{ .parent =3D &utmi_phy_clkout_ck, .rates =3D div_1_0_rates },
+=09{ .parent =3D &xclk60motg_ck, .rates =3D div_1_1_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk otg_60m_gfclk =3D {
+=09.name=09=09=3D "otg_60m_gfclk",
+=09.parent=09=09=3D &utmi_phy_clkout_ck,
+=09.clksel=09=09=3D otg_60m_gfclk_sel,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+=09.clksel_mask=09=3D OMAP4430_CLKSEL_60M_MASK,
+=09.ops=09=09=3D &clkops_null,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk usb_otg_hs_xclk =3D {
+=09.name=09=09=3D "usb_otg_hs_xclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_XCLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &otg_60m_gfclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk usb_otg_hs_ick =3D {
 =09.name=09=09=3D "usb_otg_hs_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2244,6 +2595,36 @@ static struct clk usb_otg_hs_ick =3D {
 =09.recalc=09=09=3D &followparent_recalc,
 };
=20
+static struct clk usb_tll_hs_usb_ch2_clk =3D {
+=09.name=09=09=3D "usb_tll_hs_usb_ch2_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_tll_hs_usb_ch0_clk =3D {
+=09.name=09=09=3D "usb_tll_hs_usb_ch0_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usb_tll_hs_usb_ch1_clk =3D {
+=09.name=09=09=3D "usb_tll_hs_usb_ch1_clk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+=09.enable_bit=09=3D OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT,
+=09.clkdm_name=09=3D "l3_init_clkdm",
+=09.parent=09=09=3D &init_60m_fclk,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
 static struct clk usb_tll_hs_ick =3D {
 =09.name=09=09=3D "usb_tll_hs_ick",
 =09.ops=09=09=3D &clkops_omap2_dflt,
@@ -2285,23 +2666,6 @@ static struct clk wd_timer3_fck =3D {
 };
=20
 /* Remaining optional clocks */
-static const struct clksel otg_60m_gfclk_sel[] =3D {
-=09{ .parent =3D &utmi_phy_clkout_ck, .rates =3D div_1_0_rates },
-=09{ .parent =3D &xclk60motg_ck, .rates =3D div_1_1_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk otg_60m_gfclk_ck =3D {
-=09.name=09=09=3D "otg_60m_gfclk_ck",
-=09.parent=09=09=3D &utmi_phy_clkout_ck,
-=09.clksel=09=09=3D otg_60m_gfclk_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_60M_MASK,
-=09.ops=09=09=3D &clkops_null,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
 static const struct clksel stm_clk_div_div[] =3D {
 =09{ .parent =3D &pmd_stm_clock_mux_ck, .rates =3D div3_1to4_rates },
 =09{ .parent =3D NULL },
@@ -2359,40 +2723,6 @@ static struct clk usim_fclk =3D {
 =09.set_rate=09=3D &omap2_clksel_set_rate,
 };
=20
-static const struct clksel utmi_p1_gfclk_sel[] =3D {
-=09{ .parent =3D &init_60m_fclk, .rates =3D div_1_0_rates },
-=09{ .parent =3D &xclk60mhsp1_ck, .rates =3D div_1_1_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk utmi_p1_gfclk_ck =3D {
-=09.name=09=09=3D "utmi_p1_gfclk_ck",
-=09.parent=09=09=3D &init_60m_fclk,
-=09.clksel=09=09=3D utmi_p1_gfclk_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_UTMI_P1_MASK,
-=09.ops=09=09=3D &clkops_null,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel utmi_p2_gfclk_sel[] =3D {
-=09{ .parent =3D &init_60m_fclk, .rates =3D div_1_0_rates },
-=09{ .parent =3D &xclk60mhsp2_ck, .rates =3D div_1_1_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk utmi_p2_gfclk_ck =3D {
-=09.name=09=09=3D "utmi_p2_gfclk_ck",
-=09.parent=09=09=3D &init_60m_fclk,
-=09.clksel=09=09=3D utmi_p2_gfclk_sel,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
-=09.clksel_mask=09=3D OMAP4430_CLKSEL_UTMI_P2_MASK,
-=09.ops=09=09=3D &clkops_null,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
 /*
  * clkdev
  */
@@ -2487,21 +2817,32 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"aes1_fck",=09=09=09&aes1_fck,=09CK_443X),
 =09CLK(NULL,=09"aes2_fck",=09=09=09&aes2_fck,=09CK_443X),
 =09CLK(NULL,=09"aess_fck",=09=09=09&aess_fck,=09CK_443X),
+=09CLK(NULL,=09"bandgap_fclk",=09=09=09&bandgap_fclk,=09CK_443X),
 =09CLK(NULL,=09"des3des_fck",=09=09=09&des3des_fck,=09CK_443X),
 =09CLK(NULL,=09"dmic_sync_mux_ck",=09=09&dmic_sync_mux_ck,=09CK_443X),
 =09CLK(NULL,=09"dmic_fck",=09=09=09&dmic_fck,=09CK_443X),
 =09CLK(NULL,=09"dsp_fck",=09=09=09&dsp_fck,=09CK_443X),
+=09CLK(NULL,=09"dss_sys_clk",=09=09=09&dss_sys_clk,=09CK_443X),
+=09CLK(NULL,=09"dss_tv_clk",=09=09=09&dss_tv_clk,=09CK_443X),
+=09CLK(NULL,=09"dss_dss_clk",=09=09=09&dss_dss_clk,=09CK_443X),
+=09CLK(NULL,=09"dss_48mhz_clk",=09=09&dss_48mhz_clk,=09CK_443X),
 =09CLK(NULL,=09"dss_fck",=09=09=09&dss_fck,=09CK_443X),
 =09CLK(NULL,=09"efuse_ctrl_cust_fck",=09=09&efuse_ctrl_cust_fck,=09CK_443X=
),
 =09CLK(NULL,=09"emif1_fck",=09=09=09&emif1_fck,=09CK_443X),
 =09CLK(NULL,=09"emif2_fck",=09=09=09&emif2_fck,=09CK_443X),
 =09CLK(NULL,=09"fdif_fck",=09=09=09&fdif_fck,=09CK_443X),
 =09CLK(NULL,=09"fpka_fck",=09=09=09&fpka_fck,=09CK_443X),
+=09CLK(NULL,=09"gpio1_dbclk",=09=09=09&gpio1_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio1_ick",=09=09=09&gpio1_ick,=09CK_443X),
+=09CLK(NULL,=09"gpio2_dbclk",=09=09=09&gpio2_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio2_ick",=09=09=09&gpio2_ick,=09CK_443X),
+=09CLK(NULL,=09"gpio3_dbclk",=09=09=09&gpio3_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio3_ick",=09=09=09&gpio3_ick,=09CK_443X),
+=09CLK(NULL,=09"gpio4_dbclk",=09=09=09&gpio4_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio4_ick",=09=09=09&gpio4_ick,=09CK_443X),
+=09CLK(NULL,=09"gpio5_dbclk",=09=09=09&gpio5_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio5_ick",=09=09=09&gpio5_ick,=09CK_443X),
+=09CLK(NULL,=09"gpio6_dbclk",=09=09=09&gpio6_dbclk,=09CK_443X),
 =09CLK(NULL,=09"gpio6_ick",=09=09=09&gpio6_ick,=09CK_443X),
 =09CLK(NULL,=09"gpmc_ick",=09=09=09&gpmc_ick,=09CK_443X),
 =09CLK(NULL,=09"gpu_fck",=09=09=09&gpu_fck,=09CK_443X),
@@ -2512,6 +2853,7 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("i2c_omap.3",=09"fck",=09=09=09=09&i2c3_fck,=09CK_443X),
 =09CLK("i2c_omap.4",=09"fck",=09=09=09=09&i2c4_fck,=09CK_443X),
 =09CLK(NULL,=09"ipu_fck",=09=09=09&ipu_fck,=09CK_443X),
+=09CLK(NULL,=09"iss_ctrlclk",=09=09=09&iss_ctrlclk,=09CK_443X),
 =09CLK(NULL,=09"iss_fck",=09=09=09&iss_fck,=09CK_443X),
 =09CLK(NULL,=09"iva_fck",=09=09=09&iva_fck,=09CK_443X),
 =09CLK(NULL,=09"kbd_fck",=09=09=09&kbd_fck,=09CK_443X),
@@ -2537,11 +2879,20 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK("mmci-omap-hs.2",=09"fck",=09=09=09=09&mmc3_fck,=09CK_443X),
 =09CLK("mmci-omap-hs.3",=09"fck",=09=09=09=09&mmc4_fck,=09CK_443X),
 =09CLK("mmci-omap-hs.4",=09"fck",=09=09=09=09&mmc5_fck,=09CK_443X),
+=09CLK(NULL,=09"ocp2scp_usb_phy_clk32k",=09&ocp2scp_usb_phy_clk32k,=09CK_4=
43X),
+=09CLK(NULL,=09"ocp2scp_usb_phy_phy_48m",=09&ocp2scp_usb_phy_phy_48m,=09CK=
_443X),
 =09CLK(NULL,=09"ocp_wp_noc_ick",=09=09&ocp_wp_noc_ick,=09CK_443X),
 =09CLK("omap_rng",=09"ick",=09=09=09=09&rng_ick,=09CK_443X),
 =09CLK(NULL,=09"sha2md5_fck",=09=09=09&sha2md5_fck,=09CK_443X),
 =09CLK(NULL,=09"sl2if_ick",=09=09=09&sl2if_ick,=09CK_443X),
+=09CLK(NULL,=09"slimbus1_fclk_1",=09=09&slimbus1_fclk_1,=09CK_443X),
+=09CLK(NULL,=09"slimbus1_fclk_0",=09=09&slimbus1_fclk_0,=09CK_443X),
+=09CLK(NULL,=09"slimbus1_fclk_2",=09=09&slimbus1_fclk_2,=09CK_443X),
+=09CLK(NULL,=09"slimbus1_slimbus_clk",=09=09&slimbus1_slimbus_clk,=09CK_44=
3X),
 =09CLK(NULL,=09"slimbus1_fck",=09=09=09&slimbus1_fck,=09CK_443X),
+=09CLK(NULL,=09"slimbus2_fclk_1",=09=09&slimbus2_fclk_1,=09CK_443X),
+=09CLK(NULL,=09"slimbus2_fclk_0",=09=09&slimbus2_fclk_0,=09CK_443X),
+=09CLK(NULL,=09"slimbus2_slimbus_clk",=09=09&slimbus2_slimbus_clk,=09CK_44=
3X),
 =09CLK(NULL,=09"slimbus2_fck",=09=09=09&slimbus2_fck,=09CK_443X),
 =09CLK(NULL,=09"smartreflex_core_fck",=09=09&smartreflex_core_fck,=09CK_44=
3X),
 =09CLK(NULL,=09"smartreflex_iva_fck",=09=09&smartreflex_iva_fck,=09CK_443X=
),
@@ -2562,24 +2913,30 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"uart3_fck",=09=09=09&uart3_fck,=09CK_443X),
 =09CLK(NULL,=09"uart4_fck",=09=09=09&uart4_fck,=09CK_443X),
 =09CLK(NULL,=09"usb_host_fs_fck",=09=09&usb_host_fs_fck,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_utmi_p3_clk",=09&usb_host_hs_utmi_p3_clk,=09CK=
_443X),
+=09CLK(NULL,=09"usb_host_hs_hsic60m_p1_clk",=09&usb_host_hs_hsic60m_p1_clk=
,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_hsic60m_p2_clk",=09&usb_host_hs_hsic60m_p2_clk=
,=09CK_443X),
+=09CLK(NULL,=09"utmi_p1_gfclk",=09=09&utmi_p1_gfclk,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_utmi_p1_clk",=09&usb_host_hs_utmi_p1_clk,=09CK=
_443X),
+=09CLK(NULL,=09"utmi_p2_gfclk",=09=09&utmi_p2_gfclk,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_utmi_p2_clk",=09&usb_host_hs_utmi_p2_clk,=09CK=
_443X),
+=09CLK(NULL,=09"usb_host_hs_hsic480m_p1_clk",=09&usb_host_hs_hsic480m_p1_c=
lk,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_hsic480m_p2_clk",=09&usb_host_hs_hsic480m_p2_c=
lk,=09CK_443X),
+=09CLK(NULL,=09"usb_host_hs_func48mclk",=09&usb_host_hs_func48mclk,=09CK_4=
43X),
 =09CLK(NULL,=09"usb_host_hs_fck",=09=09&usb_host_hs_fck,=09CK_443X),
+=09CLK(NULL,=09"otg_60m_gfclk",=09=09&otg_60m_gfclk,=09CK_443X),
+=09CLK(NULL,=09"usb_otg_hs_xclk",=09=09&usb_otg_hs_xclk,=09CK_443X),
 =09CLK("musb_hdrc",=09"ick",=09=09=09=09&usb_otg_hs_ick,=09CK_443X),
+=09CLK(NULL,=09"usb_tll_hs_usb_ch2_clk",=09&usb_tll_hs_usb_ch2_clk,=09CK_4=
43X),
+=09CLK(NULL,=09"usb_tll_hs_usb_ch0_clk",=09&usb_tll_hs_usb_ch0_clk,=09CK_4=
43X),
+=09CLK(NULL,=09"usb_tll_hs_usb_ch1_clk",=09&usb_tll_hs_usb_ch1_clk,=09CK_4=
43X),
 =09CLK(NULL,=09"usb_tll_hs_ick",=09=09&usb_tll_hs_ick,=09CK_443X),
 =09CLK(NULL,=09"usim_fck",=09=09=09&usim_fck,=09CK_443X),
 =09CLK("omap_wdt",=09"fck",=09=09=09=09&wd_timer2_fck,=09CK_443X),
 =09CLK(NULL,=09"wd_timer3_fck",=09=09&wd_timer3_fck,=09CK_443X),
-=09CLK(NULL,=09"otg_60m_gfclk_ck",=09=09&otg_60m_gfclk_ck,=09CK_443X),
 =09CLK(NULL,=09"stm_clk_div_ck",=09=09&stm_clk_div_ck,=09CK_443X),
 =09CLK(NULL,=09"trace_clk_div_ck",=09=09&trace_clk_div_ck,=09CK_443X),
 =09CLK(NULL,=09"usim_fclk",=09=09=09&usim_fclk,=09CK_443X),
-=09CLK(NULL,=09"utmi_p1_gfclk_ck",=09=09&utmi_p1_gfclk_ck,=09CK_443X),
-=09CLK(NULL,=09"utmi_p2_gfclk_ck",=09=09&utmi_p2_gfclk_ck,=09CK_443X),
-=09CLK(NULL,=09"gpio1_dbck",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK(NULL,=09"gpio2_dbck",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK(NULL,=09"gpio3_dbck",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK(NULL,=09"gpio4_dbck",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK(NULL,=09"gpio5_dbck",=09=09=09&dummy_ck,=09CK_443X),
-=09CLK(NULL,=09"gpio6_dbck",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"gpmc_ck",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"gpt1_ick",=09=09=09&dummy_ck,=09CK_443X),
 =09CLK(NULL,=09"gpt2_ick",=09=09=09&dummy_ck,=09CK_443X),
--=20
1.7.1

--155748971-280066124-1285140587=:21002--
