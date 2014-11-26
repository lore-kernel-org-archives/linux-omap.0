From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH 3/3] ARM: dts: am33xx: Add emif node
Date: Wed, 26 Nov 2014 15:39:07 -0600
Message-ID: <b325ea14ca863feb2b835996b08fed2c2c808b57.1417029919.git.d-gerlach@ti.com>
References: <cover.1417029919.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1417029919.git.d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add node for Texas Instruments AM335x EMIF to make use of the
ti-emif-sram driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index b86d8c0..b432499 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -153,6 +153,12 @@
 			#dma-cells = <1>;
 		};
 
+		emif: emif@4c000000 {
+			compatible = "ti,am3352-emif";
+			reg =	<0x4C000000 0x1000>;
+			sram = <&ocmcram>;
+		};
+
 		gpio0: gpio@44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
-- 
2.1.0
