From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: Add gpio-keys
Date: Fri, 24 Feb 2017 10:02:52 +0100
Message-ID: <20170224090252.31044-1-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Droid 4 "Volume Down" and "Keypad Slide" keys are
connected via SoC GPIOs, "Power Key" via CPCAP and
all other keys via SoC keypad Matrix. This adds the
GPIO keys.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
