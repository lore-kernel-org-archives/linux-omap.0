From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 26/35] ARM: dts: omap3: merge control module features under scrm node
Date: Wed, 18 Mar 2015 16:44:11 +0200
Message-ID: <1426689860-17537-27-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56530 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175AbbCROpe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:34 -0400
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
 .../devicetree/bindings/arm/omap/prcm.txt          |    1 +
 arch/arm/boot/dts/am3517.dtsi                      |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   75 ++++++++++++--------
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             |   10 +--
 arch/arm/mach-omap2/control.c                      |    2 +-
 5 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index 68f96f8..98ab498 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -18,6 +18,7 @@ Required properties:
 		"ti,omap3-prm"
 		"ti,omap3-cm"
 		"ti,omap3-scrm"
+		"ti,omap3-scrm-wkup"
 		"ti,omap4-cm1"
 		"ti,omap4-prm"
 		"ti,omap4-cm2"
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index c90724b..f164dce 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -31,7 +31,7 @@
 			status = "disabled";
 			reg = <0x5c000000 0x30000>;
 			interrupts = <67 68 69 70>;
-			syscon = <&omap3_scm_general>;
+			syscon = <&scm_conf>;
 			ti,davinci-ctrl-reg-offset = <0x10000>;
 			ti,davinci-ctrl-mod-reg-offset = <0>;
 			ti,davinci-ctrl-ram-offset = <0x20000>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 01b7111..14b2f3f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -122,18 +122,60 @@
 		};
 
 		scrm: scrm@48002000 {
-			compatible = "ti,omap3-scrm";
+			compatible = "ti,omap3-scrm", "simple-bus";
 			reg = <0x48002000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48002000 0xa00>;
 
-			scrm_clocks: clocks {
+			omap3_pmx_core: pinmux@30 {
+				compatible = "ti,omap3-padconf",
+					     "pinctrl-single";
+				reg = <0x30 0x230>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0xff1f>;
+			};
+
+			scm_conf: scm_conf@270 {
+				compatible = "syscon";
+				reg = <0x270 0x330>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				scrm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 			};
 
 			scrm_clockdomains: clockdomains {
 			};
 		};
 
+		scrm_wkup: scrm_wkup@48002a00 {
+			compatible = "ti,omap3-scrm-wkup", "simple-bus";
+			reg = <0x48002a00 0x1600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48002a00 0x1600>;
+
+			omap3_pmx_wkup: pinmux@0 {
+				compatible = "ti,omap3-padconf",
+					     "pinctrl-single";
+				reg = <0x0 0x5c>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0xff1f>;
+			};
+		};
+
 		counter32k: counter@48320000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x48320000 0x20>;
@@ -159,37 +201,10 @@
 			#dma-requests = <96>;
 		};
 
-		omap3_pmx_core: pinmux@48002030 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x0238>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0xff1f>;
-		};
-
-		omap3_pmx_wkup: pinmux@48002a00 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002a00 0x5c>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0xff1f>;
-		};
-
-		omap3_scm_general: tisyscon@48002270 {
-			compatible = "syscon";
-			reg = <0x48002270 0x2f0>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
 			reg = <0x2b0 0x4>;
-			syscon = <&omap3_scm_general>;
+			syscon = <&scm_conf>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
 				regulator-name = "pbias_mmc_omap2430";
 				regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index 5c37500..ecc25ac 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -85,7 +85,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <4>;
-		reg = <0x02d8>;
+		reg = <0x68>;
 	};
 
 	mcbsp5_fck: mcbsp5_fck {
@@ -99,7 +99,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x0274>;
+		reg = <0x04>;
 	};
 
 	mcbsp1_fck: mcbsp1_fck {
@@ -113,7 +113,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <6>;
-		reg = <0x0274>;
+		reg = <0x04>;
 	};
 
 	mcbsp2_fck: mcbsp2_fck {
@@ -126,7 +126,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
-		reg = <0x02d8>;
+		reg = <0x68>;
 	};
 
 	mcbsp3_fck: mcbsp3_fck {
@@ -140,7 +140,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x02d8>;
+		reg = <0x68>;
 	};
 
 	mcbsp4_fck: mcbsp4_fck {
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 5359bc3..f756f21 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -670,7 +670,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scrm", .data = &omap2_ctrl_data },
-	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap3-scrm", .data = &omap2_ctrl_data },
 	{ }
 };
 
-- 
1.7.9.5

