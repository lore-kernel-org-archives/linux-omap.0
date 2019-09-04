From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 12/94] ARM: dts: am335x: Fix UARTs length
Date: Wed,  4 Sep 2019 11:56:17 -0400
Message-ID: <20190904155739.2816-12-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Emmanuel Vadot <manu@freebsd.org>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Emmanuel Vadot <manu@freebsd.org>

[ Upstream commit 8613e2ca4fff764f23785eadfa54a08631ee682a ]

As seen on the AM335x TRM all the UARTs controller only are 0x1000 in size.
Fix this in the DTS.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 4bd22c1edf963..46849d6ecb3e2 100644
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
2.20.1
