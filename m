From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 25/35] ARM: dts: omap24xx: merge control module features under scrm node
Date: Wed, 18 Mar 2015 16:44:10 +0200
Message-ID: <1426689860-17537-26-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56519 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169AbbCROp2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:28 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch moves all the control module related features under scrm node.
scm_conf area is changed to use syscon, and also the clocks are moved
under scm_conf area.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi        |   33 +++++++++++++++++---------
 arch/arm/boot/dts/omap2430-clocks.dtsi |    6 ++---
 arch/arm/boot/dts/omap2430.dtsi        |   40 ++++++++++++++++++--------------
 arch/arm/boot/dts/omap24xx-clocks.dtsi |    4 ++--
 arch/arm/mach-omap2/control.c          |    7 +++++-
 5 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index e2b2e93..49bc2ee 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -28,12 +28,32 @@
 		};
 
 		scrm: scrm@48000000 {
-			compatible = "ti,omap2-scrm";
+			compatible = "ti,omap2-scrm", "simple-bus";
 			reg = <0x48000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48000000 0x1000>;
 
-			scrm_clocks: clocks {
+			omap2420_pmx: pinmux@30 {
+				compatible = "ti,omap2420-padconf",
+					     "pinctrl-single";
+				reg = <0x30 0x0113>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-single,register-width = <8>;
+				pinctrl-single,function-mask = <0x3f>;
+			};
+
+			scm_conf: scm_conf@270 {
+				compatible = "syscon";
+				reg = <0x270 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				scrm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 			};
 
 			scrm_clockdomains: clockdomains {
@@ -46,15 +66,6 @@
 			ti,hwmods = "counter_32k";
 		};
 
-		omap2420_pmx: pinmux@48000030 {
-			compatible = "ti,omap2420-padconf", "pinctrl-single";
-			reg = <0x48000030 0x0113>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-single,register-width = <8>;
-			pinctrl-single,function-mask = <0x3f>;
-		};
-
 		gpio1: gpio@48018000 {
 			compatible = "ti,omap2-gpio";
 			reg = <0x48018000 0x200>;
diff --git a/arch/arm/boot/dts/omap2430-clocks.dtsi b/arch/arm/boot/dts/omap2430-clocks.dtsi
index 805f75d..cb4b229 100644
--- a/arch/arm/boot/dts/omap2430-clocks.dtsi
+++ b/arch/arm/boot/dts/omap2430-clocks.dtsi
@@ -13,7 +13,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
-		reg = <0x02e8>;
+		reg = <0x78>;
 	};
 
 	mcbsp3_fck: mcbsp3_fck {
@@ -27,7 +27,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x02e8>;
+		reg = <0x78>;
 	};
 
 	mcbsp4_fck: mcbsp4_fck {
@@ -41,7 +41,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <4>;
-		reg = <0x02e8>;
+		reg = <0x78>;
 	};
 
 	mcbsp5_fck: mcbsp5_fck {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 0dc8de2..e06d7eb 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -28,12 +28,32 @@
 		};
 
 		scrm: scrm@49002000 {
-			compatible = "ti,omap2-scrm";
+			compatible = "ti,omap2-scrm", "simple-bus";
 			reg = <0x49002000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x49000000 0x1000>;
 
-			scrm_clocks: clocks {
+			omap2430_pmx: pinmux@30 {
+				compatible = "ti,omap2430-padconf",
+					     "pinctrl-single";
+				reg = <0x30 0x0154>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-single,register-width = <8>;
+				pinctrl-single,function-mask = <0x3f>;
+			};
+
+			scm_conf: scm_conf@270 {
+				compatible = "syscon";
+				reg = <0x270 0x240>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				scrm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 			};
 
 			scrm_clockdomains: clockdomains {
@@ -46,24 +66,10 @@
 			ti,hwmods = "counter_32k";
 		};
 
-		omap2430_pmx: pinmux@49002030 {
-			compatible = "ti,omap2430-padconf", "pinctrl-single";
-			reg = <0x49002030 0x0154>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-single,register-width = <8>;
-			pinctrl-single,function-mask = <0x3f>;
-		};
-
-		omap2_scm_general: tisyscon@49002270 {
-			compatible = "syscon";
-			reg = <0x49002270 0x240>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
 			reg = <0x230 0x4>;
-			syscon = <&omap2_scm_general>;
+			syscon = <&scm_conf>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
 				regulator-name = "pbias_mmc_omap2430";
 				regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/omap24xx-clocks.dtsi b/arch/arm/boot/dts/omap24xx-clocks.dtsi
index a1365ca..a078b55 100644
--- a/arch/arm/boot/dts/omap24xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap24xx-clocks.dtsi
@@ -13,7 +13,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x0274>;
+		reg = <0x4>;
 	};
 
 	mcbsp1_fck: mcbsp1_fck {
@@ -27,7 +27,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <6>;
-		reg = <0x0274>;
+		reg = <0x4>;
 	};
 
 	mcbsp2_fck: mcbsp2_fck {
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index edc0f26..5359bc3 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -661,10 +661,15 @@ static struct control_init_data ctrl_data = {
 	.index = TI_CLKM_CTRL,
 };
 
+static const struct control_init_data omap2_ctrl_data = {
+	.index = TI_CLKM_CTRL,
+	.offset = -OMAP2_CONTROL_GENERAL,
+};
+
 static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
-	{ .compatible = "ti,omap2-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap2-scrm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
 	{ }
 };
-- 
1.7.9.5

