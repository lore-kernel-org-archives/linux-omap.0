From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp
Date: Mon, 2 Jul 2012 14:25:37 +0530
Message-ID: <1341219337-25815-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Made *ocp2scp_usb_phy_phy_48m* as the main_clk for ocp2scp.
Since this ocp2scp module does not have any fck but does have a
single opt_clock, it is added as the main_clk for ocp2scp. Also
removed phy_48m as the optional clock since it is now made as the
main clock.

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from [RFC PATCH 1/5] arm: omap: hwmod: make *phy_48m* as the ma=
in_clk
of ocp2scp:
* Removed *ocp2scp_usb_phy_phy_48m* as the optional functional clock

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index f30e861..17cf933 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2504,14 +2504,11 @@ static struct omap_hwmod_class omap44xx_ocp2scp=
_hwmod_class =3D {
 };
=20
 /* ocp2scp_usb_phy */
-static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] =3D {
-	{ .role =3D "phy_48m", .clk =3D "ocp2scp_usb_phy_phy_48m" },
-};
-
 static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod =3D {
 	.name		=3D "ocp2scp_usb_phy",
 	.class		=3D &omap44xx_ocp2scp_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
+	.main_clk	=3D "ocp2scp_usb_phy_phy_48m",
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -2519,8 +2516,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy=
_hwmod =3D {
 			.modulemode   =3D MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	=3D ocp2scp_usb_phy_opt_clks,
-	.opt_clks_cnt	=3D ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
 };
=20
 /*
--=20
1.7.5.4
