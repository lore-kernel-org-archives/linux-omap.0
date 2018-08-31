From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/3] ARM: dts: am572x-idk: Add tricolor Industrial LED support
Date: Fri, 31 Aug 2018 14:34:02 -0500
Message-ID: <20180831193403.26777-2-afd@ti.com>
References: <20180831193403.26777-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831193403.26777-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

AM572x-IDK rev 1.3A has tricolor RGB LEDs that can be controlled using
GPIO. Expose these to userspace for usage as necessary.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am572x-idk-common.dtsi | 76 ++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk-common.dtsi b/arch/arm/boot/dts/am572x-idk-common.dtsi
index 784639ddf451..a064f13b3880 100644
--- a/arch/arm/boot/dts/am572x-idk-common.dtsi
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -55,6 +55,82 @@
 			linux,default-trigger = "mmc0";
 		};
 	};
+
+	idk-leds {
+		status = "disabled";
+		compatible = "gpio-leds";
+		red0-led {
+			label = "idk:red0";
+			gpios = <&gpio6 19 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green0-led {
+			label = "idk:green0";
+			gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue0-led {
+			label = "idk:blue0";
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red1-led {
+			label = "idk:red1";
+			gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green1-led {
+			label = "idk:green1";
+			gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue1-led {
+			label = "idk:blue1";
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red2-led {
+			label = "idk:red2";
+			gpios = <&gpio7 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green2-led {
+			label = "idk:green2";
+			gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue2-led {
+			label = "idk:blue2";
+			gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red3-led {
+			label = "idk:red3";
+			gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green3-led {
+			label = "idk:green3";
+			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue3-led {
+			label = "idk:blue3";
+			gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &extcon_usb2 {
-- 
2.18.0
