From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: dts: Fix gpio interrupts for dm816x
Date: Tue, 17 Mar 2015 17:19:18 -0700
Message-ID: <1426637961-4197-2-git-send-email-tony@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i570.relay.mailchannels.net ([46.232.183.124]:45366
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753211AbbCRAYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 20:24:31 -0400
In-Reply-To: <1426637961-4197-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>

Commit 7800064ba507 ("ARM: dts: Add basic dm816x device tree
configuration") added basic devices for dm816x, but I was not able
to test the GPIO interrupts earlier until I found some suitable pins
to test with. We can mux the MMC card detect and write protect pins
from SD_SDCD and SD_SDWP mode to use a normal GPIO interrupts that
are also suitable for the MMC subsystem.

This turned out several issues that need to be fixed:

- I set the GPIO type wrong to be compatible with omap3 instead
  of omap4. The GPIO controller on dm816x has EOI interrupt
  register like omap4 and am335x.

- I got the GPIO interrupt numbers wrong as each bank has two
  and we only use one. They need to be set up the same way as
  on am335x.

- The gpio banks are missing interrupt controller related
  properties.

With these changes the GPIO interrupts can be used with the
MMC card detect pin, so let's wire that up. Let's also mux all
the MMC lines for completeness while at it.

For the first GPIO bank I tested using GPMC lines temporarily
muxed to GPIOs on the dip switch 10.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 19 +++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi    | 18 ++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index d3a29c1..afe678f 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -36,6 +36,20 @@
 		>;
 	};
 
+	mmc_pins: pinmux_mmc_pins {
+		pinctrl-single,pins = <
+			DM816X_IOPAD(0x0a70, MUX_MODE0)			/* SD_POW */
+			DM816X_IOPAD(0x0a74, MUX_MODE0)			/* SD_CLK */
+			DM816X_IOPAD(0x0a78, MUX_MODE0)			/* SD_CMD */
+			DM816X_IOPAD(0x0a7C, MUX_MODE0)			/* SD_DAT0 */
+			DM816X_IOPAD(0x0a80, MUX_MODE0)			/* SD_DAT1 */
+			DM816X_IOPAD(0x0a84, MUX_MODE0)			/* SD_DAT2 */
+			DM816X_IOPAD(0x0a88, MUX_MODE0)			/* SD_DAT2 */
+			DM816X_IOPAD(0x0a8c, MUX_MODE2)			/* GP1[7] */
+			DM816X_IOPAD(0x0a90, MUX_MODE2)			/* GP1[8] */
+		>;
+	};
+
 	usb0_pins: pinmux_usb0_pins {
 		pinctrl-single,pins = <
 			DM816X_IOPAD(0x0d00, MUX_MODE0)			/* USB0_DRVVBUS */
@@ -137,7 +151,12 @@
 };
 
 &mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins>;
 	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
 };
 
 /* At least dm8168-evm rev c won't support multipoint, later may */
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 3c97b5f..f35715b 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -150,17 +150,27 @@
 		};
 
 		gpio1: gpio@48032000 {
-			compatible = "ti,omap3-gpio";
+			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
+			ti,gpio-always-on;
 			reg = <0x48032000 0x1000>;
-			interrupts = <97>;
+			interrupts = <96>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio@4804c000 {
-			compatible = "ti,omap3-gpio";
+			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio2";
+			ti,gpio-always-on;
 			reg = <0x4804c000 0x1000>;
-			interrupts = <99>;
+			interrupts = <98>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		gpmc: gpmc@50000000 {
-- 
2.1.4

