From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp
Date: Fri, 7 Sep 2012 14:39:15 +0530
Message-ID: <1347008955-21310-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Made *ocp2scp_usb_phy_phy_48m* as the main_clk for ocp2scp.
Since this ocp2scp module does not have any fck but does have a
single opt_clock, it is added as the main_clk for ocp2scp. Also
removed phy_48m as the optional clock since it is now made as the
main clock. By this the driver need not enable/disable phy_48m clk
separately and runtime_get/runtime_put will take care of that.

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes for v1:
 Amend the comment section with benefit for the driver because of this =
patch.
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 242aee4..e8e5405 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2503,14 +2503,11 @@ static struct omap_hwmod_class omap44xx_ocp2scp=
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
@@ -2518,8 +2515,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy=
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
1.7.9.5
