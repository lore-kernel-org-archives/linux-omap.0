From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/7] ARM: dts: dra7-clock: Add "l3init_960m_gfclk" clock gate
Date: Mon, 28 Apr 2014 17:01:21 +0300
Message-ID: <1398693687-13967-2-git-send-email-rogerq@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398693687-13967-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This clock gate description is missing in the older Reference manuals.
It is present on the SoC to provide 960MHz reference clock to the
internal USB PHYs.

Reference: DRA75x_DRA74x_ES1.1_NDA_TRM_vO.pdf, pg. 900,
Table 3-812. CM_COREAON_L3INIT_60M_GFCLK_CLKCTRL

Use l3init_960m_gfclk as parent of usb_otg_ss1_refclk960m and
usb_otg_ss2_refclk960m.

CC: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index cfb8fc7..c767687 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1386,6 +1386,14 @@
 		ti,dividers = <1>, <8>;
 	};
 
+	l3init_960m_gfclk: l3init_960m_gfclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&dpll_usb_clkdcoldo>;
+		ti,bit-shift = <8>;
+		reg = <0x06c0>;
+	};
+
 	dss_32khz_clk: dss_32khz_clk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1533,7 +1541,7 @@
 	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_clkdcoldo>;
+		clocks = <&l3init_960m_gfclk>;
 		ti,bit-shift = <8>;
 		reg = <0x13f0>;
 	};
@@ -1541,7 +1549,7 @@
 	usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_clkdcoldo>;
+		clocks = <&l3init_960m_gfclk>;
 		ti,bit-shift = <8>;
 		reg = <0x1340>;
 	};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
