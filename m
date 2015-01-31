From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 2/2] ARM: OMAP5: dts: Fix the bypass clock source for dpll_iva and others
Date: Sat, 31 Jan 2015 22:36:45 +0530
Message-ID: <1422724005-9415-3-git-send-email-rk@ti.com>
References: <1422724005-9415-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422724005-9415-1-git-send-email-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>
List-Id: linux-omap@vger.kernel.org

Fixes 85dc74e9 (ARM: dts: omap5 clock data)

On OMAP54xx, For DPLL_IVA, the ref clock(CLKINP) is connected to sys_clk1 and
    the bypass input(CLKINPULOW) is connected to iva_dpll_hs_clk_div clock.
    But the bypass input is not directly routed to bypass clkout instead
    both CLKINP and CLKINPULOW are connected to bypass clkout via a mux.

    This mux is controlled by the bit - CM_CLKSEL_DPLL_IVA[23]:DPLL_BYP_CLKSEL
    and it's POR value is zero which selects the CLKINP as bypass clkout.
    which means iva_dpll_hs_clk_div is not the bypass clock for dpll_iva_ck

    Fix this by adding another mux clock as parent in bypass mode.

    This design is common to most of the PLLs and the rest have only one bypass
    clock. Below is a list of the DPLLs that need this fix:

    DPLL_IVA,
    DPLL_PER,
    DPLL_USB and DPLL_CORE

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi |   41 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 58c2746..83b425f 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -167,10 +167,18 @@
 		ti,index-starts-at-one;
 	};
 
+	dpll_core_byp_mux: dpll_core_byp_mux {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clkin>, <&dpll_abe_m3x2_ck>;
+		ti,bit-shift = <23>;
+		reg = <0x012c>;
+	};
+
 	dpll_core_ck: dpll_core_ck {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-core-clock";
-		clocks = <&sys_clkin>, <&dpll_abe_m3x2_ck>;
+		clocks = <&sys_clkin>, <&dpll_core_byp_mux>;
 		reg = <0x0120>, <0x0124>, <0x012c>, <0x0128>;
 	};
 
@@ -294,10 +302,18 @@
 		clock-div = <1>;
 	};
 
+	dpll_iva_byp_mux: dpll_iva_byp_mux {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clkin>, <&iva_dpll_hs_clk_div>;
+		ti,bit-shift = <23>;
+		reg = <0x01ac>;
+	};
+
 	dpll_iva_ck: dpll_iva_ck {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
-		clocks = <&sys_clkin>, <&iva_dpll_hs_clk_div>;
+		clocks = <&sys_clkin>, <&dpll_iva_byp_mux>;
 		reg = <0x01a0>, <0x01a4>, <0x01ac>, <0x01a8>;
 	};
 
@@ -599,10 +615,19 @@
 	};
 };
 &cm_core_clocks {
+
+	dpll_per_byp_mux: dpll_per_byp_mux {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clkin>, <&per_dpll_hs_clk_div>;
+		ti,bit-shift = <23>;
+		reg = <0x014c>;
+	};
+
 	dpll_per_ck: dpll_per_ck {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
-		clocks = <&sys_clkin>, <&per_dpll_hs_clk_div>;
+		clocks = <&sys_clkin>, <&dpll_per_byp_mux>;
 		reg = <0x0140>, <0x0144>, <0x014c>, <0x0148>;
 	};
 
@@ -714,10 +739,18 @@
 		ti,index-starts-at-one;
 	};
 
+	dpll_usb_byp_mux: dpll_usb_byp_mux {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clkin>, <&usb_dpll_hs_clk_div>;
+		ti,bit-shift = <23>;
+		reg = <0x018c>;
+	};
+
 	dpll_usb_ck: dpll_usb_ck {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-j-type-clock";
-		clocks = <&sys_clkin>, <&usb_dpll_hs_clk_div>;
+		clocks = <&sys_clkin>, <&dpll_usb_byp_mux>;
 		reg = <0x0180>, <0x0184>, <0x018c>, <0x0188>;
 	};
 
-- 
1.7.9.5
