From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 4/7] ARM: dts: dra7-clock: Add "l3init_960m_gfclk" clock gate
Date: Mon, 5 May 2014 12:54:43 +0300
Message-ID: <1399283686-6127-5-git-send-email-rogerq@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49964 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756010AbaEEJzJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 May 2014 05:55:09 -0400
In-Reply-To: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon@ti.com, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com
Cc: george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>

This clock gate description is missing in the older Reference manuals.
It is present on the SoC to provide 960MHz reference clock to the
internal USB PHYs.

Reference: DRA75x_DRA74x_ES1.1_NDA_TRM_vO.pdf, pg. 900,
Table 3-812. CM_COREAON_L3INIT_60M_GFCLK_CLKCTRL

Use l3init_960m_gfclk as parent of usb_otg_ss1_refclk960m and
usb_otg_ss2_refclk960m.

CC: Beno=C3=AEt Cousson <bcousson@baylibre.com>
CC: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/d=
ra7xx-clocks.dtsi
index cfb8fc7..c767687 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1386,6 +1386,14 @@
 		ti,dividers =3D <1>, <8>;
 	};
=20
+	l3init_960m_gfclk: l3init_960m_gfclk {
+		#clock-cells =3D <0>;
+		compatible =3D "ti,gate-clock";
+		clocks =3D <&dpll_usb_clkdcoldo>;
+		ti,bit-shift =3D <8>;
+		reg =3D <0x06c0>;
+	};
+
 	dss_32khz_clk: dss_32khz_clk {
 		#clock-cells =3D <0>;
 		compatible =3D "ti,gate-clock";
@@ -1533,7 +1541,7 @@
 	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m {
 		#clock-cells =3D <0>;
 		compatible =3D "ti,gate-clock";
-		clocks =3D <&dpll_usb_clkdcoldo>;
+		clocks =3D <&l3init_960m_gfclk>;
 		ti,bit-shift =3D <8>;
 		reg =3D <0x13f0>;
 	};
@@ -1541,7 +1549,7 @@
 	usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m {
 		#clock-cells =3D <0>;
 		compatible =3D "ti,gate-clock";
-		clocks =3D <&dpll_usb_clkdcoldo>;
+		clocks =3D <&l3init_960m_gfclk>;
 		ti,bit-shift =3D <8>;
 		reg =3D <0x1340>;
 	};
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
