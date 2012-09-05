From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v6 2/3] arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
Date: Wed, 5 Sep 2012 17:10:59 +0530
Message-ID: <1346845260-10978-3-git-send-email-anilkumar@ti.com>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35552 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758129Ab2IELlu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 07:41:50 -0400
In-Reply-To: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

[koen@dominion.thruhere.net: led0, led1 suggested by koen]
Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index c634f87..822efe6 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,11 +18,54 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux@44e10800 {
+		userled_pins: pinmux_userled_pins {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial@44e09000 {
 			status = "okay";
 		};
 
+		leds {
+			compatible = "gpio-leds";
+			pinctrl-names = "default";
+			pinctrl-0 = <&userled_pins>;
+
+			heartbeat {
+				label = "beaglebone:green:usr0";
+				gpios = <&gpio2 21 0>;
+				linux,default-trigger = "heartbeat";
+				default-state = "off";
+			};
+
+			mmc {
+				label = "beaglebone:green:usr1";
+				gpios = <&gpio2 22 0>;
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+
+			led2 {
+				label = "beaglebone:green:usr2";
+				gpios = <&gpio2 23 0>;
+				default-state = "off";
+			};
+
+			led3 {
+				label = "beaglebone:green:usr3";
+				gpios = <&gpio2 24 0>;
+				default-state = "off";
+			};
+		};
+
 		i2c1: i2c@44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;
-- 
1.7.9.5

