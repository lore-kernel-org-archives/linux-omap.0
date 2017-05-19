From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] ARM: dts: am335x-sl50: Fix card detect pin for mmc1
Date: Fri, 19 May 2017 18:51:43 +0200
Message-ID: <20170519165144.11508-1-enric.balletbo@collabora.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The second version of the hardware moved the card detect pin from gpio0_6
to gpio1_9, as we won't support the first hardware version fix the pinmux
configuration of this pin.

Fixes: 8584d4fc ("ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index c5d2589..da4f8e3 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -220,7 +220,7 @@
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE7)		/* uart0_rtsn.gpio1_9 */
 		>;
 	};
 
@@ -384,7 +384,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <4>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&vmmcsd_fixed>;
 };
 
-- 
2.9.3
