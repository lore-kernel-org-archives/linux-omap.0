From: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 1/1] ARM: dts: am335x: Fix UARTs length
Date: Wed, 24 Jul 2019 14:23:29 +0200
Message-ID: <20190724122329.21231-2-manu@freebsd.org>
References: <20190724122329.21231-1-manu@freebsd.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724122329.21231-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
List-Id: linux-omap@vger.kernel.org

As seen on the AM335x TRM all the UARTs controller only are 0x1000 in size.
Fix this in the DTS.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index ced1a19d5f89..a20b04b72be4 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -185,7 +185,7 @@
 			uart0: serial@0 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				clock-frequency = <48000000>;
-				reg = <0x0 0x2000>;
+				reg = <0x0 0x1000>;
 				interrupts = <72>;
 				status = "disabled";
 				dmas = <&edma 26 0>, <&edma 27 0>;
@@ -934,7 +934,7 @@
 			uart1: serial@0 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				clock-frequency = <48000000>;
-				reg = <0x0 0x2000>;
+				reg = <0x0 0x1000>;
 				interrupts = <73>;
 				status = "disabled";
 				dmas = <&edma 28 0>, <&edma 29 0>;
@@ -966,7 +966,7 @@
 			uart2: serial@0 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				clock-frequency = <48000000>;
-				reg = <0x0 0x2000>;
+				reg = <0x0 0x1000>;
 				interrupts = <74>;
 				status = "disabled";
 				dmas = <&edma 30 0>, <&edma 31 0>;
@@ -1614,7 +1614,7 @@
 			uart3: serial@0 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				clock-frequency = <48000000>;
-				reg = <0x0 0x2000>;
+				reg = <0x0 0x1000>;
 				interrupts = <44>;
 				status = "disabled";
 			};
@@ -1644,7 +1644,7 @@
 			uart4: serial@0 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				clock-frequency = <48000000>;
-				reg = <0x0 0x2000>;
+				reg = <0x0 0x1000>;
 				interrupts = <45>;
 				status = "disabled";
 			};
@@ -1674,7 +1674,7 @@
 			uart5: serial@0 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				clock-frequency = <48000000>;
-				reg = <0x0 0x2000>;
+				reg = <0x0 0x1000>;
 				interrupts = <46>;
 				status = "disabled";
 			};
-- 
2.22.0
