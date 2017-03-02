From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/8] ARM: dts: omap4-droid4: Add gpio-keys
Date: Thu,  2 Mar 2017 02:08:53 +0100
Message-ID: <20170302010900.28532-2-sre@kernel.org>
References: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302010900.28532-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Droid 4 "Volume Down" and "Keypad Slide" keys are
connected via SoC GPIOs, "Power Key" via CPCAP and
all other keys via SoC keypad Matrix. This adds the
GPIO keys.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index f3ccb4ceed9e..89f5f17cda7a 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "omap443x.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Motorola Droid 4 XT894";
@@ -53,6 +54,26 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		volume_down {
+			label = "Volume Down";
+			gpios = <&gpio5 26 GPIO_ACTIVE_LOW>; /* gpio154 */
+			linux,code = <KEY_VOLUMEDOWN>;
+			linux,can-disable;
+		};
+
+		slider {
+			label = "Keypad Slide";
+			gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>; /* gpio122 */
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_KEYPAD_SLIDE>;
+			linux,can-disable;
+
+		};
+	};
 };
 
 /* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
-- 
2.11.0
