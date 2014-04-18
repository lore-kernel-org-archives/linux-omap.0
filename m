From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 2/4] ARM: dts: Add support for OMAP4 VAR-DVK-OM44
Date: Fri, 18 Apr 2014 17:10:47 +0200
Message-ID: <1397833849-22396-3-git-send-email-manabian@gmail.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:59544 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbaDRPLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 11:11:06 -0400
Received: by mail-lb0-f169.google.com with SMTP id q8so1476750lbi.0
        for <linux-omap@vger.kernel.org>; Fri, 18 Apr 2014 08:11:05 -0700 (PDT)
In-Reply-To: <1397833849-22396-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |  3 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/omap4-var-dvk-om44.dts           | 70 ++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-var-dvk-om44.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 7db69ac46188..62df0244114e 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -105,6 +105,9 @@ Boards:
 - OMAP4 VAR-STK-OM44 : Commercial dev kit with VAR-OM44CustomBoard and VAR-SOM-OM44 w/WLAN
   compatible = "variscite,var-stk-om44", "variscite,var-som-om44", "ti,omap4430", "ti,omap4";
 
+- OMAP4 VAR-DVK-OM44 : Commercial dev kit with VAR-OM44CustomBoard, VAR-SOM-OM44 w/WLAN and LCD touchscreen
+  compatible = "variscite,var-dvk-om44", "variscite,var-som-om44", "ti,omap4430", "ti,omap4";
+
 - OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
   compatible = "ti,omap3-evm", "ti,omap3"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f443ade8ae3c..2cc120cf6bbf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -273,6 +273,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
+	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb \
diff --git a/arch/arm/boot/dts/omap4-var-dvk-om44.dts b/arch/arm/boot/dts/omap4-var-dvk-om44.dts
new file mode 100644
index 000000000000..9471bbd8cb33
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-var-dvk-om44.dts
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2014 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap4-var-som-om44.dtsi"
+#include "omap4-var-om44customboard.dtsi"
+
+/ {
+	model = "Variscite VAR-DVK-OM44";
+	compatible = "variscite,var-dvk-om44", "variscite,var-som-om44", "ti,omap4430", "ti,omap4";
+
+	aliases {
+		display0 = &lcd0;
+		display1 = &hdmi0;
+	};
+
+	lcd0: display {
+		compatible = "innolux,at070tn83", "panel-dpi";
+		label = "lcd";
+		panel-timing {
+			clock-frequency = <33333333>;
+
+			hback-porch = <40>;
+			hactive = <800>;
+			hfront-porch = <40>;
+			hsync-len = <48>;
+
+			vback-porch = <29>;
+			vactive = <480>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
+
+	backlight {
+		compatible = "gpio-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+
+		gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>; /* gpio 122 */
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+&dsi2 {
+	status = "okay";
+	vdd-supply = <&vcxio>;
+};
-- 
1.8.0

