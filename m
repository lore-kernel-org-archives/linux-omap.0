From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Tue, 21 Jan 2014 15:37:41 +0100
Message-ID: <1390315061-14441-1-git-send-email-sre@debian.org>
References: <52DE24DA.8050104@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44027 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbaAUOhr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 09:37:47 -0500
In-Reply-To: <52DE24DA.8050104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
to make them consistent for omap34xx and omap36xx. This makes it
possible to reference the clocks from generic omap3 dts files.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3430es1-clocks.dtsi              | 10 +++++-----
 arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap3430es1-clocks.dtsi b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
index 02f6c7f..6f31954 100644
--- a/arch/arm/boot/dts/omap3430es1-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
@@ -82,16 +82,16 @@
 		ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
 	};
 
-	ssi_ssr_fck_3430es1: ssi_ssr_fck_3430es1 {
+	ssi_ssr_fck: ssi_ssr_fck_3430es1 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-clock";
 		clocks = <&ssi_ssr_gate_fck_3430es1>, <&ssi_ssr_div_fck_3430es1>;
 	};
 
-	ssi_sst_fck_3430es1: ssi_sst_fck_3430es1 {
+	ssi_sst_fck: ssi_sst_fck_3430es1 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
-		clocks = <&ssi_ssr_fck_3430es1>;
+		clocks = <&ssi_ssr_fck>;
 		clock-mult = <1>;
 		clock-div = <2>;
 	};
@@ -120,7 +120,7 @@
 		clock-div = <1>;
 	};
 
-	ssi_ick_3430es1: ssi_ick_3430es1 {
+	ssi_ick: ssi_ick_3430es1 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&ssi_l4_ick>;
@@ -203,6 +203,6 @@
 			 <&i2c1_ick>, <&uart2_ick>, <&uart1_ick>, <&gpt11_ick>,
 			 <&gpt10_ick>, <&mcbsp5_ick>, <&mcbsp1_ick>,
 			 <&omapctrl_ick>, <&aes2_ick>, <&sha12_ick>,
-			 <&fshostusb_fck>, <&fac_ick>, <&ssi_ick_3430es1>;
+			 <&fshostusb_fck>, <&fac_ick>, <&ssi_ick>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
index 8ed475d..877318c 100644
--- a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
@@ -25,16 +25,16 @@
 		ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
 	};
 
-	ssi_ssr_fck_3430es2: ssi_ssr_fck_3430es2 {
+	ssi_ssr_fck: ssi_ssr_fck_3430es2 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-clock";
 		clocks = <&ssi_ssr_gate_fck_3430es2>, <&ssi_ssr_div_fck_3430es2>;
 	};
 
-	ssi_sst_fck_3430es2: ssi_sst_fck_3430es2 {
+	ssi_sst_fck: ssi_sst_fck_3430es2 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
-		clocks = <&ssi_ssr_fck_3430es2>;
+		clocks = <&ssi_ssr_fck>;
 		clock-mult = <1>;
 		clock-div = <2>;
 	};
@@ -55,7 +55,7 @@
 		clock-div = <1>;
 	};
 
-	ssi_ick_3430es2: ssi_ick_3430es2 {
+	ssi_ick: ssi_ick_3430es2 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-ssi-interface-clock";
 		clocks = <&ssi_l4_ick>;
@@ -193,6 +193,6 @@
 			 <&i2c1_ick>, <&uart2_ick>, <&uart1_ick>, <&gpt11_ick>,
 			 <&gpt10_ick>, <&mcbsp5_ick>, <&mcbsp1_ick>,
 			 <&omapctrl_ick>, <&aes2_ick>, <&sha12_ick>,
-			 <&ssi_ick_3430es2>;
+			 <&ssi_ick>;
 	};
 };
-- 
1.8.5.2

