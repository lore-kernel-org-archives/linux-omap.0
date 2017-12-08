From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 17/20] ARM: dts: am33xx: add clkctrl nodes
Date: Fri, 8 Dec 2017 17:17:30 +0200
Message-ID: <1512746251-20123-5-git-send-email-t-kristo@ti.com>
References: <1512746251-20123-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512746251-20123-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for AM33xx SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

This patch also removes any obsolete clock nodes, and reroutes all users
for these to use the new clkctrl clocks instead.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi |   2 +-
 arch/arm/boot/dts/am335x-boneblue.dts     |   2 +-
 arch/arm/boot/dts/am335x-evm.dts          |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        |   2 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi      | 205 ++++++++++++++----------------
 arch/arm/boot/dts/am33xx.dtsi             |   5 +-
 6 files changed, 99 insertions(+), 119 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 48a15fc..e67b4d6 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -409,6 +409,6 @@
 };
 
 &rtc {
-	clocks = <&clk_32768_ck>, <&clkdiv32k_ick>;
+	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index cdc1b2b..d5be9fc 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -446,7 +446,7 @@
 
 &rtc {
 	system-power-controller;
-	clocks = <&clk_32768_ck>, <&clkdiv32k_ick>;
+	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
 
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index ddd8975..fee6b3e 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -790,6 +790,6 @@
 };
 
 &rtc {
-	clocks = <&clk_32768_ck>, <&clkdiv32k_ick>;
+	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 9ba4b18..fa608cd 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -722,6 +722,6 @@
 };
 
 &rtc {
-	clocks = <&clk_32768_ck>, <&clkdiv32k_ick>;
+	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 8d83195..95d5c9d 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -292,14 +292,6 @@
 		clock-div = <4>;
 	};
 
-	cefuse_fck: cefuse_fck@a20 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_clkin_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0a20>;
-	};
-
 	clk_24mhz: clk_24mhz {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -316,14 +308,6 @@
 		clock-div = <732>;
 	};
 
-	clkdiv32k_ick: clkdiv32k_ick@14c {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x014c>;
-	};
-
 	l3_gclk: l3_gclk {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -350,49 +334,49 @@
 	timer1_fck: timer1_fck@528 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>;
+		clocks = <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>;
 		reg = <0x0528>;
 	};
 
 	timer2_fck: timer2_fck@508 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x0508>;
 	};
 
 	timer3_fck: timer3_fck@50c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x050c>;
 	};
 
 	timer4_fck: timer4_fck@510 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x0510>;
 	};
 
 	timer5_fck: timer5_fck@518 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x0518>;
 	};
 
 	timer6_fck: timer6_fck@51c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x051c>;
 	};
 
 	timer7_fck: timer7_fck@504 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x0504>;
 	};
 
@@ -423,7 +407,7 @@
 	wdt1_fck: wdt1_fck@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&clk_rc32k_ck>, <&clkdiv32k_ick>;
+		clocks = <&clk_rc32k_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x0538>;
 	};
 
@@ -493,42 +477,10 @@
 	gpio0_dbclk_mux_ck: gpio0_dbclk_mux_ck@53c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&clk_rc32k_ck>, <&clk_32768_ck>, <&clkdiv32k_ick>;
+		clocks = <&clk_rc32k_ck>, <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 		reg = <0x053c>;
 	};
 
-	gpio0_dbclk: gpio0_dbclk@408 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&gpio0_dbclk_mux_ck>;
-		ti,bit-shift = <18>;
-		reg = <0x0408>;
-	};
-
-	gpio1_dbclk: gpio1_dbclk@ac {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <18>;
-		reg = <0x00ac>;
-	};
-
-	gpio2_dbclk: gpio2_dbclk@b0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <18>;
-		reg = <0x00b0>;
-	};
-
-	gpio3_dbclk: gpio3_dbclk@b4 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&clkdiv32k_ick>;
-		ti,bit-shift = <18>;
-		reg = <0x00b4>;
-	};
-
 	lcd_gclk: lcd_gclk@534 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -577,58 +529,6 @@
 		reg = <0x0700>;
 	};
 
-	dbg_sysclk_ck: dbg_sysclk_ck@414 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_clkin_ck>;
-		ti,bit-shift = <19>;
-		reg = <0x0414>;
-	};
-
-	dbg_clka_ck: dbg_clka_ck@414 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_core_m4_ck>;
-		ti,bit-shift = <30>;
-		reg = <0x0414>;
-	};
-
-	stm_pmd_clock_mux_ck: stm_pmd_clock_mux_ck@414 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dbg_sysclk_ck>, <&dbg_clka_ck>;
-		ti,bit-shift = <22>;
-		reg = <0x0414>;
-	};
-
-	trace_pmd_clk_mux_ck: trace_pmd_clk_mux_ck@414 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dbg_sysclk_ck>, <&dbg_clka_ck>;
-		ti,bit-shift = <20>;
-		reg = <0x0414>;
-	};
-
-	stm_clk_div_ck: stm_clk_div_ck@414 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&stm_pmd_clock_mux_ck>;
-		ti,bit-shift = <27>;
-		ti,max-div = <64>;
-		reg = <0x0414>;
-		ti,index-power-of-two;
-	};
-
-	trace_clk_div_ck: trace_clk_div_ck@414 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&trace_pmd_clk_mux_ck>;
-		ti,bit-shift = <24>;
-		ti,max-div = <64>;
-		reg = <0x0414>;
-		ti,index-power-of-two;
-	};
-
 	clkout2_ck: clkout2_ck@700 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -638,9 +538,88 @@
 	};
 };
 
-&prcm_clockdomains {
-	clk_24mhz_clkdm: clk_24mhz_clkdm {
-		compatible = "ti,clockdomain";
-		clocks = <&clkdiv32k_ick>;
+&prcm {
+	l4_per_cm: l4_per_cm@0 {
+		compatible = "ti,omap4-cm";
+		reg = <0x0 0x200>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x200>;
+
+		l4_per_clkctrl: clk@14 {
+			compatible = "ti,clkctrl";
+			reg = <0x14 0x13c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_wkup_cm: l4_wkup_cm@400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x400 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x400 0x100>;
+
+		l4_wkup_clkctrl: clk@4 {
+			compatible = "ti,clkctrl";
+			reg = <0x4 0xd4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	mpu_cm: mpu_cm@600 {
+		compatible = "ti,omap4-cm";
+		reg = <0x600 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x600 0x100>;
+
+		mpu_clkctrl: clk@4 {
+			compatible = "ti,clkctrl";
+			reg = <0x4 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_rtc_cm: l4_rtc_cm@800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x800 0x100>;
+
+		l4_rtc_clkctrl: clk@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	gfx_l3_cm: gfx_l3_cm@900 {
+		compatible = "ti,omap4-cm";
+		reg = <0x900 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x900 0x100>;
+
+		gfx_l3_clkctrl: clk@4 {
+			compatible = "ti,clkctrl";
+			reg = <0x4 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_cefuse_cm: l4_cefuse_cm@a00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xa00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xa00 0x100>;
+
+		l4_cefuse_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bd10ba7..d1690bc 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/am33xx.h>
+#include <dt-bindings/clock/am3.h>
 
 / {
 	compatible = "ti,am33xx";
@@ -578,7 +579,7 @@
 			interrupts = <75
 				      76>;
 			ti,hwmods = "rtc";
-			clocks = <&clkdiv32k_ick>;
+			clocks = <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 			clock-names = "int-clk";
 		};
 
@@ -1019,4 +1020,4 @@
 	};
 };
 
-/include/ "am33xx-clocks.dtsi"
+#include "am33xx-clocks.dtsi"
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
