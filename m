From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH V2 6/8] ARM: dts: TWL6030/OMAP4: Add OMAP voltage path
 linkage
Date: Fri, 21 Jun 2013 16:25:47 -0500
Message-ID: <1371849949-12649-7-git-send-email-nm@ti.com>
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

OMAP4430 and 4460 platforms use TWL6030 to power voltage rails.
However, on 4460, we use twl6030 only for iva and core voltage rails.

Introduce an twl6030_omap4.dtsi to be able to reuse the base definition
for all OMAP4 platforms and the delta change only for panda-es platform
which is based on 4460.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |    1 +
 arch/arm/boot/dts/omap4-panda-es.dts      |   13 +++++++++++
 arch/arm/boot/dts/omap4-sdp.dts           |    1 +
 arch/arm/boot/dts/omap4-var-som.dts       |    1 +
 arch/arm/boot/dts/twl6030_omap4.dtsi      |   35 +++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/twl6030_omap4.dtsi

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 00cbaa5..2b15c2b 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -199,6 +199,7 @@
 };
 
 #include "twl6030.dtsi"
+#include "twl6030_omap4.dtsi"
 
 &i2c2 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 56c4354..49017c5 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -62,3 +62,16 @@
 		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 	};
 };
+
+&omap_twl6030_vcore1 {
+	ti,vp = <&vp_core>;
+};
+
+&omap_twl6030_vcore2 {
+	ti,vp = <&vp_iva>;
+};
+
+&omap_twl6030_vcore3 {
+	/* We use TPS62361 on this platform instead */
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7951b4e..2f81b4d5 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -337,6 +337,7 @@
 };
 
 #include "twl6030.dtsi"
+#include "twl6030_omap4.dtsi"
 
 &i2c2 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index b41269e..6f0b763 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -40,6 +40,7 @@
 };
 
 #include "twl6030.dtsi"
+#include "twl6030_omap4.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/twl6030_omap4.dtsi b/arch/arm/boot/dts/twl6030_omap4.dtsi
new file mode 100644
index 0000000..7724039
--- /dev/null
+++ b/arch/arm/boot/dts/twl6030_omap4.dtsi
@@ -0,0 +1,35 @@
+/*
+ * TWL6030 entries specific for OMAP
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *	Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&twl {
+	omap_twl6030_vcore1: vcore1 {
+		compatible = "ti,omap-twl6030-vcore1";
+		ti,boot-voltage-micro-volts = <1200000>;
+		ti,vp = <&vp_mpu>;
+	};
+
+	omap_twl6030_vcore2: vcore2 {
+		compatible = "ti,omap-twl6030-vcore2";
+		ti,boot-voltage-micro-volts = <1200000>;
+		ti,vp = <&vp_iva>;
+	};
+
+	omap_twl6030_vcore3: vcore3 {
+		compatible = "ti,omap-twl6030-vcore3";
+		ti,boot-voltage-micro-volts = <1200000>;
+		ti,vp = <&vp_core>;
+	};
+};
+
+&vc {
+	ti,i2c-high-speed;
+	ti,i2c-pad-load = <3>;
+};
-- 
1.7.9.5
