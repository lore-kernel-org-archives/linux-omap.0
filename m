From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 4/5] arm: dts: omap3: Add definition for devconf1 register
Date: Wed, 12 Nov 2014 23:10:46 +0100
Message-ID: <1415830247-31633-5-git-send-email-marek@goldelico.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415830247-31633-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, grant.likely@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, hns@goldelico.com, gta04-owner@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch expose DEVCONF1 register via pincrtl-single. Because reserved bits
are different for omap34xx and omap36xx functional-mask is defined in omap3
variant dtsi files. Bit MPUFORCEWRNP is leaved out.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3.dtsi    | 13 +++++++++++++
 arch/arm/boot/dts/omap34xx.dtsi |  4 ++++
 arch/arm/boot/dts/omap36xx.dtsi |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d0e884d..75aaab3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -181,6 +181,19 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 
+		control_devconf1: pinmux@480022d8 {
+			compatible = "pinctrl-single";
+			reg = <0x480022d8 4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,bit-per-mux;
+			pinctrl-single,register-width = <32>;
+			/*
+			 * reserved bits differs for omap34xx and omap36xx
+			 * so function-mask is defined in appropriate dtsi files
+			 */
+		};
+
 		omap3_scm_general: tisyscon@48002270 {
 			compatible = "syscon";
 			reg = <0x48002270 0x2f0>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 3819c1e..18299b0 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -51,6 +51,10 @@
 		      "ssi_ick";
 };
 
+&control_devconf1 {
+	pinctrl-single,function-mask = <0xfc79d5>;
+};
+
 /include/ "omap34xx-omap36xx-clocks.dtsi"
 /include/ "omap36xx-omap3430es2plus-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 541704a..736d35d 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -89,6 +89,10 @@
 		      "ssi_ick";
 };
 
+&control_devconf1 {
+	pinctrl-single,function-mask = <0xfc09d5>;
+};
+
 /include/ "omap34xx-omap36xx-clocks.dtsi"
 /include/ "omap36xx-omap3430es2plus-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
-- 
1.9.1
