From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP4: PM: fix PM regression introduced by recent clock
 cleanup
Date: Tue, 12 Feb 2013 20:28:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-869192503-1360700892=:29149"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42153 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3BLU2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 15:28:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-869192503-1360700892=:29149
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb ("ARM: OMAP4:
clock/hwmod data: start to remove some IP block control "clocks"")
introduced a regression preventing the L3INIT clockdomain of OMAP4
systems from entering idle.  This in turn prevented these systems from
entering full chip clock-stop.

The regression was caused by the incorrect removal of a so-called
"optional functional clock" from the OMAP4 clock data.  This wasn't
caught for two reasons.  First, I missed the retention entry failure
in the branch test logs:

http://www.pwsan.com/omap/testlogs/cleanup_a_3.9/20130126014242/pm/4460pand=
aes/4460pandaes_log.txt

Second, the integration data for the OCP2SCP PHY IP block, added by
commit 0c6688753f9912c6a7013549ec31c8844020bbc1 ("ARM: OMAP4: hwmod
data: add remaining USB-related IP blocks"), should have associated this
clock with the IP block, but did not.

Fix by adding back the so-called "optional" functional clock to the
clock data, and by linking that clock to the OCP2SCP PHY IP block
integration hwmod data.

The problem patch was discovered by J, Keerthy <j-keerthy@ti.com>.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

It'd be nice, but certainly not necessary, to get this in for the v3.9=20
merge window.  Otherwise, will send it for -rc1.

 arch/arm/mach-omap2/cclock44xx_data.c      |    5 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cc=
lock44xx_data.c
index cebe2b3..54ebb89 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1000,6 +1000,10 @@ DEFINE_CLK_OMAP_MUX(hsmmc2_fclk, "l3_init_clkdm", hs=
mmc1_fclk_sel,
 =09=09    OMAP4430_CM_L3INIT_MMC2_CLKCTRL, OMAP4430_CLKSEL_MASK,
 =09=09    hsmmc1_fclk_parents, func_dmic_abe_gfclk_ops);
=20
+DEFINE_CLK_GATE(ocp2scp_usb_phy_phy_48m, "func_48m_fclk", &func_48m_fclk, =
0x0,
+=09=09OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+=09=09OMAP4430_OPTFCLKEN_PHY_48M_SHIFT, 0x0, NULL);
+
 DEFINE_CLK_GATE(sha2md5_fck, "l3_div_ck", &l3_div_ck, 0x0,
 =09=09OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 =09=09OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
@@ -1527,6 +1531,7 @@ static struct omap_clk omap44xx_clks[] =3D {
 =09CLK(NULL,=09"per_mcbsp4_gfclk",=09=09=09&per_mcbsp4_gfclk,=09CK_443X),
 =09CLK(NULL,=09"hsmmc1_fclk",=09=09=09&hsmmc1_fclk,=09CK_443X),
 =09CLK(NULL,=09"hsmmc2_fclk",=09=09=09&hsmmc2_fclk,=09CK_443X),
+=09CLK(NULL,=09"ocp2scp_usb_phy_phy_48m",=09&ocp2scp_usb_phy_phy_48m,=09CK=
_443X),
 =09CLK(NULL,=09"sha2md5_fck",=09=09=09&sha2md5_fck,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_1",=09=09&slimbus1_fclk_1,=09CK_443X),
 =09CLK(NULL,=09"slimbus1_fclk_0",=09=09&slimbus1_fclk_0,=09CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index a1849a8..d55c769 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2720,6 +2720,10 @@ static struct omap_ocp2scp_dev ocp2scp_dev_attr[] =
=3D {
 =09{ }
 };
=20
+static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] =3D {
+=09{ .role =3D "48mhz", .clk =3D "ocp2scp_usb_phy_phy_48m" },
+};
+
 /* ocp2scp_usb_phy */
 static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod =3D {
 =09.name=09=09=3D "ocp2scp_usb_phy",
@@ -2734,6 +2738,8 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwm=
od =3D {
 =09=09},
 =09},
 =09.dev_attr=09=3D ocp2scp_dev_attr,
+=09.opt_clks=09=3D ocp2scp_usb_phy_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
 };
=20
 /*
--=20
1.7.10.4

--843723315-869192503-1360700892=:29149--
