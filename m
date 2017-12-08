From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 18/20] ARM: dts: am43xx: add clkctrl nodes
Date: Fri, 8 Dec 2017 17:17:31 +0200
Message-ID: <1512746251-20123-6-git-send-email-t-kristo@ti.com>
References: <1512746251-20123-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512746251-20123-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for AM43xx SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

This patch also removes any obsolete clock nodes, and reroutes all users
for these to use the new clkctrl clocks instead.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi        |   7 +-
 arch/arm/boot/dts/am43x-epos-evm.dts |   2 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi | 230 +++++++++++------------------------
 3 files changed, 75 insertions(+), 164 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index bf4e58e..39a5bd7 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/am4.h>
 
 / {
 	compatible = "ti,am4372", "ti,am43";
@@ -998,7 +999,7 @@
 				reg = <0x483a8000 0x8000>;
 				syscon-phy-power = <&scm_conf 0x620>;
 				clocks = <&usb_phy0_always_on_clk32k>,
-					 <&usb_otg_ss0_refclk960m>;
+					 <&l4_per_clkctrl AM4_USB_OTG_SS0_CLKCTRL 8>;
 				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
 				status = "disabled";
@@ -1017,7 +1018,7 @@
 				reg = <0x483e8000 0x8000>;
 				syscon-phy-power = <&scm_conf 0x628>;
 				clocks = <&usb_phy1_always_on_clk32k>,
-					 <&usb_otg_ss1_refclk960m>;
+					 <&l4_per_clkctrl AM4_USB_OTG_SS1_CLKCTRL 8>;
 				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
 				status = "disabled";
@@ -1180,4 +1181,4 @@
 	};
 };
 
-/include/ "am43xx-clocks.dtsi"
+#include "am43xx-clocks.dtsi"
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a04d79e..d3363fb 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -985,7 +985,7 @@
 	rx-num-evt = <32>;
 };
 
-&synctimer_32kclk {
+&mux_synctimer32k_ck {
 	assigned-clocks = <&mux_synctimer32k_ck>;
 	assigned-clock-parents = <&clkdiv32k_ick>;
 };
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 430be58..a7037a4 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -524,54 +524,6 @@
 		reg = <0x4240>;
 	};
 
-	gpio0_dbclk: gpio0_dbclk@2b68 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&gpio0_dbclk_mux_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x2b68>;
-	};
-
-	gpio1_dbclk: gpio1_dbclk@8c78 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <8>;
-		reg = <0x8c78>;
-	};
-
-	gpio2_dbclk: gpio2_dbclk@8c80 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <8>;
-		reg = <0x8c80>;
-	};
-
-	gpio3_dbclk: gpio3_dbclk@8c88 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <8>;
-		reg = <0x8c88>;
-	};
-
-	gpio4_dbclk: gpio4_dbclk@8c90 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <8>;
-		reg = <0x8c90>;
-	};
-
-	gpio5_dbclk: gpio5_dbclk@8c98 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <8>;
-		reg = <0x8c98>;
-	};
-
 	mmc_clk: mmc_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -629,14 +581,6 @@
 		reg = <0x4230>;
 	};
 
-	synctimer_32kclk: synctimer_32kclk@2a30 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&mux_synctimer32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x2a30>;
-	};
-
 	timer8_fck: timer8_fck@421c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -763,110 +707,76 @@
 		ti,bit-shift = <8>;
 		reg = <0x2a48>;
 	};
+};
 
-	usb_otg_ss0_refclk960m: usb_otg_ss0_refclk960m@8a60 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_clkdcoldo>;
-		ti,bit-shift = <8>;
-		reg = <0x8a60>;
-	};
-
-	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@8a68 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_clkdcoldo>;
-		ti,bit-shift = <8>;
-		reg = <0x8a68>;
-	};
-
-	clkout1_osc_div_ck: clkout1_osc_div_ck {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&sys_clkin_ck>;
-		ti,bit-shift = <20>;
-		ti,max-div = <4>;
-		reg = <0x4100>;
-	};
-
-	clkout1_src2_mux_ck: clkout1_src2_mux_ck {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&clk_rc32k_ck>, <&sysclk_div>, <&dpll_ddr_m2_ck>,
-			 <&dpll_per_m2_ck>, <&dpll_disp_m2_ck>,
-			 <&dpll_mpu_m2_ck>;
-		reg = <0x4100>;
-	};
-
-	clkout1_src2_pre_div_ck: clkout1_src2_pre_div_ck {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&clkout1_src2_mux_ck>;
-		ti,bit-shift = <4>;
-		ti,max-div = <8>;
-		reg = <0x4100>;
-	};
-
-	clkout1_src2_post_div_ck: clkout1_src2_post_div_ck {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&clkout1_src2_pre_div_ck>;
-		ti,bit-shift = <8>;
-		ti,max-div = <32>;
-		ti,index-power-of-two;
-		reg = <0x4100>;
-	};
-
-	clkout1_mux_ck: clkout1_mux_ck {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&clkout1_osc_div_ck>, <&clk_rc32k_ck>,
-			 <&clkout1_src2_post_div_ck>, <&dpll_extdev_m2_ck>;
-		ti,bit-shift = <16>;
-		reg = <0x4100>;
-	};
-
-	clkout1_ck: clkout1_ck {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkout1_mux_ck>;
-		ti,bit-shift = <23>;
-		reg = <0x4100>;
-	};
-
-	clkout2_src_mux_ck: clkout2_src_mux_ck {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&clk_rc32k_ck>, <&sysclk_div>, <&dpll_ddr_m2_ck>,
-			 <&dpll_per_m2_ck>, <&dpll_disp_m2_ck>,
-			 <&dpll_mpu_m2_ck>, <&dpll_extdev_ck>;
-		reg = <0x4108>;
-	};
-
-	clkout2_pre_div_ck: clkout2_pre_div_ck {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&clkout2_src_mux_ck>;
-		ti,bit-shift = <4>;
-		ti,max-div = <8>;
-		reg = <0x4108>;
-	};
-
-	clkout2_post_div_ck: clkout2_post_div_ck {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&clkout2_pre_div_ck>;
-		ti,bit-shift = <8>;
-		ti,max-div = <32>;
-		ti,index-power-of-two;
-		reg = <0x4108>;
-	};
-
-	clkout2_ck: clkout2_ck {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkout2_post_div_ck>;
-		ti,bit-shift = <16>;
-		reg = <0x4108>;
+&prcm {
+	l4_wkup_cm: l4_wkup_cm@2800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x2800 0x400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x2800 0x400>;
+
+		l4_wkup_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x34c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	mpu_cm: mpu_cm@8300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x8300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x8300 0x100>;
+
+		mpu_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	gfx_l3_cm: gfx_l3_cm@8400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x8400 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x8400 0x100>;
+
+		gfx_l3_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_rtc_cm: l4_rtc_cm@8500 {
+		compatible = "ti,omap4-cm";
+		reg = <0x8500 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x8500 0x100>;
+
+		l4_rtc_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_per_cm: l4_per_cm@8800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x8800 0xc00>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x8800 0xc00>;
+
+		l4_per_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xb04>;
+			#clock-cells = <2>;
+		};
 	};
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
