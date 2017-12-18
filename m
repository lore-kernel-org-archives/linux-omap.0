From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: am57xx: Add support for am574x-idk
Date: Mon, 18 Dec 2017 11:50:03 +0530
Message-ID: <20171218062003.9024-4-lokeshvutla@ti.com>
References: <20171218062003.9024-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218062003.9024-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

am574x-idk is similar to am572x-idk with am574x SoC. So create
a common file for both evms and include SoC dtsi as needed.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/am572x-idk-common.dtsi | 100 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts         |  93 +---------------------------
 arch/arm/boot/dts/am574x-idk.dts         |  22 +++++++
 4 files changed, 124 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/boot/dts/am572x-idk-common.dtsi
 create mode 100644 arch/arm/boot/dts/am574x-idk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..a48f0f0f2844 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -689,6 +689,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-sbc-am57x.dtb \
 	am572x-idk.dtb \
 	am571x-idk.dtb \
+	am574x-idk.dtb \
 	dra7-evm.dtb \
 	dra72-evm.dtb \
 	dra72-evm-revc.dtb \
diff --git a/arch/arm/boot/dts/am572x-idk-common.dtsi b/arch/arm/boot/dts/am572x-idk-common.dtsi
new file mode 100644
index 000000000000..c6d858b31011
--- /dev/null
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "am57xx-idk-common.dtsi"
+
+/ {
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	status-leds {
+		compatible = "gpio-leds";
+		cpu0-led {
+			label = "status0:red:cpu0";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "cpu0";
+		};
+
+		usr0-led {
+			label = "status0:green:usr";
+			gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		heartbeat-led {
+			label = "status0:blue:heartbeat";
+			gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		cpu1-led {
+			label = "status1:red:cpu1";
+			gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "cpu1";
+		};
+
+		usr1-led {
+			label = "status1:green:usr";
+			gpios = <&gpio7 23 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		mmc0-led {
+			label = "status1:blue:mmc0";
+			gpios = <&gpio7 22 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+	};
+};
+
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
+&extcon_usb2 {
+	id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
+};
+
+&sn65hvs882 {
+	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+};
+
+&pcie1_rc {
+	status = "okay";
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie1_ep {
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
+
+&mailbox5 {
+	status = "okay";
+	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
+		status = "okay";
+	};
+};
+
+&mailbox6 {
+	status = "okay";
+	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index a578fe97ba3b..9212931f25db 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -9,8 +9,7 @@
 /dts-v1/;
 
 #include "dra74x.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
+#include "am572x-idk-common.dtsi"
 #include "am57xx-idk-common.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
 
@@ -18,54 +17,6 @@
 	model = "TI AM5728 IDK";
 	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
 		     "ti,dra7";
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x80000000>;
-	};
-
-	status-leds {
-		compatible = "gpio-leds";
-		cpu0-led {
-			label = "status0:red:cpu0";
-			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "cpu0";
-		};
-
-		usr0-led {
-			label = "status0:green:usr";
-			gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		heartbeat-led {
-			label = "status0:blue:heartbeat";
-			gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "heartbeat";
-		};
-
-		cpu1-led {
-			label = "status1:red:cpu1";
-			gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "cpu1";
-		};
-
-		usr1-led {
-			label = "status1:green:usr";
-			gpios = <&gpio7 23 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		mmc0-led {
-			label = "status1:blue:mmc0";
-			gpios = <&gpio7 22 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "mmc0";
-		};
-	};
 };
 
 &mmc1 {
@@ -85,45 +36,3 @@
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20>;
 };
-
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
-&extcon_usb2 {
-	id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
-};
-
-&sn65hvs882 {
-	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
-};
-
-&pcie1_rc {
-	status = "okay";
-	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-};
-
-&pcie1_ep {
-	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-};
-
-&mailbox5 {
-	status = "okay";
-	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-		status = "okay";
-	};
-	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
-		status = "okay";
-	};
-};
-
-&mailbox6 {
-	status = "okay";
-	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
-		status = "okay";
-	};
-	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
-		status = "okay";
-	};
-};
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
new file mode 100644
index 000000000000..41e12a382d2f
--- /dev/null
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+
+/dts-v1/;
+
+#include "dra76x.dtsi"
+#include "am572x-idk-common.dtsi"
+
+/ {
+	model = "TI AM5748 IDK";
+	compatible = "ti,am5728-idk", "ti,dra762", "ti,dra7";
+};
+
+&qspi {
+	spi-max-frequency = <96000000>;
+	m25p80@0 {
+		spi-max-frequency = <96000000>;
+	};
+};
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
