From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 2/3] arm/dts: AM33XX: Configure pinmuxs for user leds
 control on Bone
Date: Thu, 6 Sep 2012 15:08:23 +0530
Message-ID: <1346924304-27425-3-git-send-email-anilkumar@ti.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346924304-27425-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

[koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org: led0, led1 suggested by koen]
Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts |   43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index c634f87..b0a7409 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,11 +18,54 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am33xx_pinmux: pinmux@44e10800 {
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
