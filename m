From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 6/9] arm: dts: am437x-gp-evm: Add gp dts.
Date: Thu, 19 Dec 2013 18:03:38 +0530
Message-ID: <1387456421-21379-7-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, afzal-l0cyMroinI0@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

AM437x GP EVM DTS with pinmux information to make I2C on
EVM usable.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 ++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |   47 ++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/am437x-gp-evm.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 808c154..be5f365 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -61,5 +61,8 @@ Boards:
 - AM43x EPOS EVM
   compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
 
+- AM437x GP EVM
+  compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
+
 - DRA7 EVM:  Software Developement Board for DRA7XX
   compatible = "ti,dra7-evm", "ti,dra7"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ad155fc..aaeddf9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -209,6 +209,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
 	am43x-epos-evm.dtb \
+	am437x-gp-evm.dtb \
 	dra7-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
new file mode 100644
index 0000000..11d93ba
--- /dev/null
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* AM437x GP EVM */
+
+/dts-v1/;
+
+#include "am4372.dtsi"
+#include <dt-bindings/pinctrl/am43xx.h>
+
+/ {
+	model = "TI AM437x GP EVM";
+	compatible = "ti,am437x-gp-evm","ti,am4372","ti,am43";
+};
+
+&am43xx_pinmux {
+	i2c0_pins: i2c0_pins {
+		pinctrl-single,pins = <
+			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
+			0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+		>;
+	};
+
+	i2c1_pins: i2c1_pins {
+		pinctrl-single,pins = <
+			0x15c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
+			0x158 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
+		>;
+	};
+};
+
+&i2c0 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2c0_pins>;
+};
+
+&i2c1 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2c1_pins>;
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
