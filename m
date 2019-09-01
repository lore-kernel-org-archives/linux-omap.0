From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 4/6] ARM: dts: am33xx: Add nodes for eQEP
Date: Sun,  1 Sep 2019 17:58:25 -0500
Message-ID: <20190901225827.12301-5-david@lechnology.com>
References: <20190901225827.12301-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds new nodes for the Texas Instruments Enhanced Quadrature
Encoder Pulse (eQEP) module in the PWM subsystem on AM33XX.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:
- rename eqep@ to counter@
v2 changes:
- clocks renamed to "sysclkout"


 arch/arm/boot/dts/am33xx-l4.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 3b1fb2ba4dff..8dd5fd9eb862 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1908,6 +1908,15 @@
 					status = "disabled";
 				};
 
+				eqep0: counter@180 {
+					compatible = "ti,am3352-eqep";
+					reg = <0x180 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "sysclkout";
+					interrupts = <79>;
+					status = "disabled";
+				};
+
 				ehrpwm0: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
@@ -1961,6 +1970,15 @@
 					status = "disabled";
 				};
 
+				eqep1: counter@180 {
+					compatible = "ti,am3352-eqep";
+					reg = <0x180 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "sysclkout";
+					interrupts = <88>;
+					status = "disabled";
+				};
+
 				ehrpwm1: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
@@ -2014,6 +2032,15 @@
 					status = "disabled";
 				};
 
+				eqep2: counter@180 {
+					compatible = "ti,am3352-eqep";
+					reg = <0x180 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "sysclkout";
+					interrupts = <89>;
+					status = "disabled";
+				};
+
 				ehrpwm2: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
-- 
2.17.1
