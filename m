From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/8] ARM: dts: dm81x: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:11 +0300
Message-ID: <1459782973-21201-7-git-send-email-t-kristo@ti.com>
References: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459782973-21201-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Upcoming change to DT compiler is going to complain about nodes
which have a reg property, but have not defined the address in their
name. This patch fixes following type of warnings for DM81x clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dm814x-clocks.dtsi |   10 ++++----
 arch/arm/boot/dts/dm816x-clocks.dtsi |   42 +++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
index e0ea6a9..1e70f73 100644
--- a/arch/arm/boot/dts/dm814x-clocks.dtsi
+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
@@ -5,7 +5,7 @@
  */
 
 &pllss_clocks {
-	timer1_fck: timer1_fck {
+	timer1_fck: timer1_fck@2e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
@@ -14,7 +14,7 @@
 		reg = <0x2e0>;
 	};
 
-	timer2_fck: timer2_fck {
+	timer2_fck: timer2_fck@2e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
@@ -23,7 +23,7 @@
 		reg = <0x2e0>;
 	};
 
-	sysclk18_ck: sysclk18_ck {
+	sysclk18_ck: sysclk18_ck@2f0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&rtcosc_ck>, <&rtcdivider_ck>;
@@ -33,7 +33,7 @@
 };
 
 &scm_clocks {
-	devosc_ck: devosc_ck {
+	devosc_ck: devosc_ck@40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_20000000_ck>, <&virt_19200000_ck>;
@@ -121,7 +121,7 @@
 		clock-div = <1>;
 	};
 
-	mpu_clksrc_ck: mpu_clksrc_ck {
+	mpu_clksrc_ck: mpu_clksrc_ck@40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&devosc_ck>, <&rtcdivider_ck>;
diff --git a/arch/arm/boot/dts/dm816x-clocks.dtsi b/arch/arm/boot/dts/dm816x-clocks.dtsi
index 50d9d33..51865eb 100644
--- a/arch/arm/boot/dts/dm816x-clocks.dtsi
+++ b/arch/arm/boot/dts/dm816x-clocks.dtsi
@@ -86,7 +86,7 @@
 
 /* 0x48180000 */
 &prcm_clocks {
-	clkout_pre_ck: clkout_pre_ck {
+	clkout_pre_ck: clkout_pre_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&main_fapll 5 &ddr_fapll 1 &video_fapll 1
@@ -94,7 +94,7 @@
 		reg = <0x100>;
 	};
 
-	clkout_div_ck: clkout_div_ck {
+	clkout_div_ck: clkout_div_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&clkout_pre_ck>;
@@ -103,7 +103,7 @@
 		reg = <0x100>;
 	};
 
-	clkout_ck: clkout_ck {
+	clkout_ck: clkout_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkout_div_ck>;
@@ -112,7 +112,7 @@
 	};
 
 	/* CM_DPLL clocks p1795 */
-	sysclk1_ck: sysclk1_ck {
+	sysclk1_ck: sysclk1_ck@300 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&main_fapll 1>;
@@ -120,7 +120,7 @@
 		reg = <0x0300>;
 	};
 
-	sysclk2_ck: sysclk2_ck {
+	sysclk2_ck: sysclk2_ck@304 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&main_fapll 2>;
@@ -128,7 +128,7 @@
 		reg = <0x0304>;
 	};
 
-	sysclk3_ck: sysclk3_ck {
+	sysclk3_ck: sysclk3_ck@308 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&main_fapll 3>;
@@ -136,7 +136,7 @@
 		reg = <0x0308>;
 	};
 
-	sysclk4_ck: sysclk4_ck {
+	sysclk4_ck: sysclk4_ck@30c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&main_fapll 4>;
@@ -144,7 +144,7 @@
 		reg = <0x030c>;
 	};
 
-	sysclk5_ck: sysclk5_ck {
+	sysclk5_ck: sysclk5_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sysclk4_ck>;
@@ -152,7 +152,7 @@
 		reg = <0x0310>;
 	};
 
-	sysclk6_ck: sysclk6_ck {
+	sysclk6_ck: sysclk6_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&main_fapll 4>;
@@ -160,7 +160,7 @@
 		reg = <0x0314>;
 	};
 
-	sysclk10_ck: sysclk10_ck {
+	sysclk10_ck: sysclk10_ck@324 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&ddr_fapll 2>;
@@ -168,7 +168,7 @@
 		reg = <0x0324>;
 	};
 
-	sysclk24_ck: sysclk24_ck {
+	sysclk24_ck: sysclk24_ck@3b4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&main_fapll 5>;
@@ -176,7 +176,7 @@
 		reg = <0x03b4>;
 	};
 
-	mpu_ck: mpu_ck {
+	mpu_ck: mpu_ck@15dc {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sysclk2_ck>;
@@ -184,7 +184,7 @@
                 reg = <0x15dc>;
 	};
 
-	audio_pll_a_ck: audio_pll_a_ck {
+	audio_pll_a_ck: audio_pll_a_ck@35c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&audio_fapll 1>;
@@ -192,56 +192,56 @@
 		reg = <0x035c>;
 	};
 
-	sysclk18_ck: sysclk18_ck {
+	sysclk18_ck: sysclk18_ck@378 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_32k_ck>, <&audio_pll_a_ck>;
 		reg = <0x0378>;
 	};
 
-	timer1_fck: timer1_fck {
+	timer1_fck: timer1_fck@390 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
 		reg = <0x0390>;
 	};
 
-	timer2_fck: timer2_fck {
+	timer2_fck: timer2_fck@394 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
 		reg = <0x0394>;
 	};
 
-	timer3_fck: timer3_fck {
+	timer3_fck: timer3_fck@398 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
 		reg = <0x0398>;
 	};
 
-	timer4_fck: timer4_fck {
+	timer4_fck: timer4_fck@39c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
 		reg = <0x039c>;
 	};
 
-	timer5_fck: timer5_fck {
+	timer5_fck: timer5_fck@3a0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
 		reg = <0x03a0>;
 	};
 
-	timer6_fck: timer6_fck {
+	timer6_fck: timer6_fck@3a4 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
 		reg = <0x03a4>;
 	};
 
-	timer7_fck: timer7_fck {
+	timer7_fck: timer7_fck@3a8 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sysclk18_ck>, <&sys_clkin_ck>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
