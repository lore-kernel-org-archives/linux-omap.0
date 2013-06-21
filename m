From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH V2 7/8] ARM: dts: omap4-panda-es: add TPS62361 supply for
 vdd_mpu
Date: Fri, 21 Jun 2013 16:25:48 -0500
Message-ID: <1371849949-12649-8-git-send-email-nm@ti.com>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371849949-12649-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
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
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Unlike other OMAP4 platforms including the the "vanilla" PandaBoard,
PandaBoard-ES uses TPS62361 to supply vdd_mpu.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda-es.dts |   18 ++++++++++++++++++
 arch/arm/boot/dts/tps62361_omap.dtsi |   18 ++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps62361_omap.dtsi

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 49017c5..325816c 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -75,3 +75,21 @@
 	/* We use TPS62361 on this platform instead */
 	status = "disabled";
 };
+
+#include "tps62361_omap.dtsi"
+
+&omap4_pmx_wkup {
+	tps62361_wkgpio_pins: pinmux_tps62361_wkpins {
+		pinctrl-single,pins = <
+			0x1a (PIN_OUTPUT | MUX_MODE3 | OFF_EN | OFFOUT_VAL) /* gpio_wk7 */
+		>;
+	};
+};
+
+&omap_tps62361 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&tps62361_wkgpio_pins
+	>;
+	gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/tps62361_omap.dtsi b/arch/arm/boot/dts/tps62361_omap.dtsi
new file mode 100644
index 0000000..ee261ec
--- /dev/null
+++ b/arch/arm/boot/dts/tps62361_omap.dtsi
@@ -0,0 +1,18 @@
+/*
+ * TPS62361 entries specific for OMAP
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *	Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	omap_tps62361: tps62361 {
+		compatible = "ti,omap-tps62361";
+		ti,boot-voltage-micro-volts = <1203000>;
+		ti,vp = <&vp_mpu>;
+	};
+};
-- 
1.7.9.5
