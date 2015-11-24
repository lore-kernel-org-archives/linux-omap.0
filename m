From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 12/14] ARM: sb-som: dts: introduce SB-SOM baseboard
Date: Tue, 24 Nov 2015 15:19:13 +0200
Message-ID: <1448371155-17307-13-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448371155-17307-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CompuLab SB-SOM baseboard is a carrier board for multiple arm-based SoMs.
It currently supports (with minor adjustments to assembly) CM-T43, CM-T54,
and CM-QS600 modules. It is a building block in the SBC-T43 single board
computer, which consists of cm-t43 on top of sb-som-t43.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
 .../devicetree/bindings/arm/compulab-boards.txt    |  5 +++
 .../bindings/display/panel/startek,startek-kd050c  |  4 +++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/compulab-sb-som.dtsi             | 42 ++++++++++++++++++++++
 4 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi

diff --git a/Documentation/devicetree/bindings/arm/compulab-boards.txt b/Documentation/devicetree/bindings/arm/compulab-boards.txt
new file mode 100644
index 0000000..3e742a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/compulab-boards.txt
@@ -0,0 +1,5 @@
+CompuLab SB-SOM is a multi-module baseboard capable of carrying CM-T43, CM-T54,
+and QS-600 modules with minor modifications to the SB-SOM assembly.
+
+Required root node properties:
+    - compatible = should be "compulab,sb-som"
diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
new file mode 100644
index 0000000..70cd8d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
@@ -0,0 +1,4 @@
+Startek Electronic Technology Co. KD050C 5.0" WVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "startek,startek-kd050c"
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..409b134 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -218,6 +218,7 @@ sony	Sony Corporation
 spansion	Spansion Inc.
 sprd	Spreadtrum Communications Inc.
 st	STMicroelectronics
+startek	Startek
 ste	ST-Ericsson
 stericsson	ST-Ericsson
 synology	Synology, Inc.
diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/compulab-sb-som.dtsi
new file mode 100644
index 0000000..402a143
--- /dev/null
+++ b/arch/arm/boot/dts/compulab-sb-som.dtsi
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	model = "CompuLab SB-SOM";
+	compatible = "compulab,sb-som";
+
+	vsb_3v3: fixedregulator-v3_3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsb_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		enable-active-high;
+	};
+
+	lcd0: display {
+		compatible = "startek,startek-kd050c", "panel-dpi";
+		label = "lcd";
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <43>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
