From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 12/14] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Sat, 29 Mar 2014 01:31:48 +0100
Message-ID: <1396053110-21639-13-git-send-email-sre@kernel.org>
References: <1396053110-21639-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396053110-21639-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sre@debian.org>

update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
to make them consistent for omap34xx and omap36xx. This makes it
possible to reference the clocks from generic omap3 dts files.

Signed-off-by: Sebastian Reichel <sre@debian.org>
Acked-by: Tero Kristo <t-kristo@ti.com>
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
1.9.0
