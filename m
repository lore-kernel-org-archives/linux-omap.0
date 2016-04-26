From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH 1/3] DRA7: Fix clock data for gmac_gmii_ref_clk_div
Date: Tue, 26 Apr 2016 12:54:27 -0500
Message-ID: <1461693269-19436-2-git-send-email-Linux.HWI@garmin.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

This commit fixes the clock data inside the DRA7xx clocks device tree
structure for the gmac_gmii_ref_clk_div clock. This clock is actually
the GMAC_MAIN_CLK and has nothing to do with the register at address
0x4a0093d0. If CLKSEL_REF bit 24 inside of CM_GMAC_GMAC_CLKCTRL, is
set to 1 in order to use the GMAC_RMII_CLK instead of the
GMAC_RMII_HS_CLK, the kernel generates a clock divider warning:
    WARNING: CPU: 0 PID: 0 at drivers/clk/clk-divider.c:129 clk_divider_recalc_rate+0xa8/0xe0()
    gmac_gmii_ref_clk_div: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set

By properly configuring the gmac_gmii_ref_clk_div (GMAC_MAIN_CLK) to
have the parent of dpll_gmac_m2_ck always divided by 2 the warning is
resolved and the clock tree is fixed up.

Additionally, a new clock called rmii_50mhz_clk_mux is defined that
does utilize CM_GMAC_GMAC_CLKCTRL[24] CLKSEL_REF to configure the
source clock for the RMII_50MHZ_CLK.

Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Reviewed-by: Trenton Andres <trenton.andres@garmin.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d0bae06..9d1a583 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1710,13 +1710,20 @@
 		reg = <0x0c00>;
 	};
 
-	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div {
+	rmii_50mhz_clk_mux: rmii_50mhz_clk_mux {
 		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&dpll_gmac_m2_ck>;
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_gmac_h11x2_ck>, <&rmii_clk_ck>;
 		ti,bit-shift = <24>;
 		reg = <0x13d0>;
-		ti,dividers = <2>;
+	};
+
+	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_gmac_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <2>;
 	};
 
 	gmac_rft_clk_mux: gmac_rft_clk_mux {
-- 
1.9.1
