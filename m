From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/7] ARM: dts: am437x-idk: Add Industrial output support
Date: Fri, 7 Oct 2016 09:44:26 -0500
Message-ID: <20161007144428.16671-5-afd@ti.com>
References: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161007144428.16671-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TPIC2810 is available on the AM437x IDK and is attached to I2C1.
Output is attached to the I/O header and 10 LEDs.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index fff7ef6..b76a7c0 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -117,6 +117,58 @@
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 	};
+
+	leds-iio {
+		status = "disabled";
+		compatible = "gpio-leds";
+		led-out0 {
+			label = "out0";
+			gpios = <&tpic2810 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out1 {
+			label = "out1";
+			gpios = <&tpic2810 1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out2 {
+			label = "out2";
+			gpios = <&tpic2810 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out3 {
+			label = "out3";
+			gpios = <&tpic2810 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out4 {
+			label = "out4";
+			gpios = <&tpic2810 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out5 {
+			label = "out5";
+			gpios = <&tpic2810 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out6 {
+			label = "out6";
+			gpios = <&tpic2810 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-out7 {
+			label = "out7";
+			gpios = <&tpic2810 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &am43xx_pinmux {
@@ -308,6 +360,13 @@
 	pinctrl-0 = <&i2c2_pins_default>;
 	pinctrl-1 = <&i2c2_pins_sleep>;
 	clock-frequency = <100000>;
+
+	tpic2810: tpic2810@60 {
+		compatible = "ti,tpic2810";
+		reg = <0x60>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &spi1 {
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
