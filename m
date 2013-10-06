From: Sebastian Reichel <sre@debian.org>
Subject: [RFCv3 7/7] ARM: dts: N900: Add SSI information
Date: Sun,  6 Oct 2013 22:27:15 +0200
Message-ID: <1381091235-18293-8-git-send-email-sre@debian.org>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381091235-18293-1-git-send-email-sre@debian.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?UTF-8?q?=27Pali=20Roh=C3=A1r=27?= <pali.rohar@gmail.com>, =?UTF-8?q?=27=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2=27?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add SSI device tree data for OMAP3 and Nokia N900.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 12 ++++++++++
 arch/arm/boot/dts/omap3.dtsi     | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 0582356..0fbb77e 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -186,6 +186,18 @@
 	power = <50>;
 };
 
+&ssi_port1 {
+	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+
+	ssi-char {
+		compatible = "ssi-char";
+	};
+};
+
+&ssi_port2 {
+	status = "disabled";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7d95cda..9f60b82 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -532,5 +532,52 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 		};
+
+		ssi: ssi-controller@48058000 {
+			compatible = "ti,omap3-ssi";
+			ti,hwmods = "ssi";
+
+			reg = <0x48058000 0x1000>,
+			      <0x48059000 0x1000>;
+			reg-names = "sys",
+				    "gdd";
+
+			interrupts = <71>;
+			interrupt-names = "gdd_mpu";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			ssi_port1: ssi-port@0 {
+				compatible = "ti,omap3-ssi-port";
+
+				reg = <0x4805a000 0x800>,
+				      <0x4805a800 0x800>;
+				reg-names = "tx",
+					    "rx";
+
+				interrupt-parent = <&intc>;
+				interrupts = <67>,
+					     <68>;
+				interrupt-names = "mpu_irq0",
+						  "mpu_irq1";
+			};
+
+			ssi_port2: ssi-port@1 {
+				compatible = "ti,omap3-ssi-port";
+
+				reg = <0x4805b000 0x800>,
+				      <0x4805b800 0x800>;
+				reg-names = "tx",
+					    "rx";
+
+				interrupt-parent = <&intc>;
+				interrupts = <69>,
+					     <70>;
+				interrupt-names = "mpu_irq0",
+						  "mpu_irq1";
+			};
+		};
 	};
 };
-- 
1.8.4.rc3

