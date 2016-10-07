From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/7] ARM: dts: am57xx-idk: Add Industrial output support
Date: Fri, 7 Oct 2016 09:44:28 -0500
Message-ID: <20161007144428.16671-7-afd@ti.com>
References: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161007144428.16671-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TPIC2810 is available on both the AM571x and the AM572x IDKs and
is attached to I2C1. Output is attached to the I/O header and 10 LEDs.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 438076e..35e210c 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -43,6 +43,58 @@
 		regulator-always-on;
 		regulator-boot-on;
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
 
 &i2c1 {
@@ -266,6 +318,13 @@
 		spi-max-frequency = <1000000>;
 		spi-cpol;
 	};
+
+	tpic2810: tpic2810@60 {
+		compatible = "ti,tpic2810";
+		reg = <0x60>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &uart3 {
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
