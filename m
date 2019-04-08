From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/1] ARM: dts: dra7: Separate AM57 dtsi files
Date: Mon, 8 Apr 2019 12:42:49 +0300
Message-ID: <20190408094249.29894-1-rogerq@ti.com>
References: <20190405132806.20772-1-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405132806.20772-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

AM5 and DRA7 SoC families have different set of modules
in them so the SoC sepecific dtsi files need to be separated.

e.g. Some of the major differences between AM576 and DRA76

		DRA76x	AM576x

USB3		x
USB4		x
ATL		x
VCP		x
MLB		x
ISS		x
PRU-ICSS1		x
PRU-ICSS2		x

This patch only deals with disabling USB3, USB4 and ATL for
AM57 variants.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---

Changelog:

v2:
- fix am57xx-beagle-x15-common.dtsi

 arch/arm/boot/dts/am5718.dtsi                 | 32 ++++++++++++++++++
 arch/arm/boot/dts/am571x-idk.dts              |  2 +-
 arch/arm/boot/dts/am5728.dtsi                 | 33 +++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts              |  5 ++-
 arch/arm/boot/dts/am5748.dtsi                 | 33 +++++++++++++++++++
 arch/arm/boot/dts/am574x-idk.dts              |  4 +--
 .../boot/dts/am57xx-beagle-x15-common.dtsi    |  2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts     |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                |  6 ++--
 9 files changed, 108 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/am5718.dtsi
 create mode 100644 arch/arm/boot/dts/am5728.dtsi
 create mode 100644 arch/arm/boot/dts/am5748.dtsi

diff --git a/arch/arm/boot/dts/am5718.dtsi b/arch/arm/boot/dts/am5718.dtsi
new file mode 100644
index 000000000000..d51007c3e8c4
--- /dev/null
+++ b/arch/arm/boot/dts/am5718.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "dra72x.dtsi"
+
+/ {
+	compatible = "ti,am5718", "ti,dra7";
+};
+
+/*
+ * These modules are not present on AM5718
+ *
+ * ATL
+ * VCP1, VCP2
+ * MLB
+ * ISS
+ * USB3, USB4
+ */
+
+&usb3_tm {
+	status = "disabled";
+};
+
+&usb4_tm {
+	status = "disabled";
+};
+
+&atl_tm {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 6432309b39e3..66116ad3f9f4 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-#include "dra72x.dtsi"
+#include "am5718.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "dra7-mmc-iodelay.dtsi"
diff --git a/arch/arm/boot/dts/am5728.dtsi b/arch/arm/boot/dts/am5728.dtsi
new file mode 100644
index 000000000000..82e5427ef6a9
--- /dev/null
+++ b/arch/arm/boot/dts/am5728.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "dra74x.dtsi"
+
+/ {
+	compatible = "ti,am5728", "ti,dra7";
+};
+
+/*
+ * These modules are not present on AM5728
+ *
+ * EVE1, EVE2
+ * ATL
+ * VCP1, VCP2
+ * MLB
+ * ISS
+ * USB3, USB4
+ */
+
+&usb3_tm {
+	status = "disabled";
+};
+
+&usb4_tm {
+	status = "disabled";
+};
+
+&atl_tm {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index b2fb6e097be7..4f835222c266 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -8,15 +8,14 @@
 
 /dts-v1/;
 
-#include "dra74x.dtsi"
+#include "am5728.dtsi"
 #include "dra7-mmc-iodelay.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
 #include "am572x-idk-common.dtsi"
 
 / {
 	model = "TI AM5728 IDK";
-	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
-		     "ti,dra7";
+	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra7";
 };
 
 &mmc1 {
diff --git a/arch/arm/boot/dts/am5748.dtsi b/arch/arm/boot/dts/am5748.dtsi
new file mode 100644
index 000000000000..5e129759d04a
--- /dev/null
+++ b/arch/arm/boot/dts/am5748.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "dra76x.dtsi"
+
+/ {
+	compatible = "ti,am5748", "ti,dra762", "ti,dra7";
+};
+
+/*
+ * These modules are not present on AM5748
+ *
+ * EVE1, EVE2
+ * ATL
+ * VCP1, VCP2
+ * MLB
+ * ISS
+ * USB3, USB4
+ */
+
+&usb3_tm {
+	status = "disabled";
+};
+
+&usb4_tm {
+	status = "disabled";
+};
+
+&atl_tm {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index 378dfa780ac1..dc5141c35610 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -6,14 +6,14 @@
 
 /dts-v1/;
 
-#include "dra76x.dtsi"
+#include "am5748.dtsi"
 #include "dra7-mmc-iodelay.dtsi"
 #include "dra76x-mmc-iodelay.dtsi"
 #include "am572x-idk-common.dtsi"
 
 / {
 	model = "TI AM5748 IDK";
-	compatible = "ti,am5728-idk", "ti,dra762", "ti,dra7";
+	compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
 };
 
 &qspi {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 1e6620f139dd..2341a56ebab9 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-#include "dra74x.dtsi"
+#include "am5728.dtsi"
 #include "am57xx-commercial-grade.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 4748ce8747ad..0460de0da2bf 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -13,7 +13,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "dra74x.dtsi"
+#include "am5728.dtsi"
 
 / {
 	model = "CompuLab CL-SOM-AM57x";
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd68733..fe9f0bc29fec 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2499,7 +2499,7 @@
 			ranges = <0x0 0x3a000 0x1000>;
 		};
 
-		target-module@3c000 {			/* 0x4843c000, ap 23 08.0 */
+		atl_tm: target-module@3c000 {		/* 0x4843c000, ap 23 08.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0x3c000 0x4>;
 			reg-names = "rev";
@@ -4099,7 +4099,7 @@
 			};
 		};
 
-		target-module@100000 {			/* 0x48900000, ap 85 04.0 */
+		usb3_tm: target-module@100000 {		/* 0x48900000, ap 85 04.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "usb_otg_ss3";
 			reg = <0x100000 0x4>,
@@ -4148,7 +4148,7 @@
 			};
 		};
 
-		target-module@140000 {			/* 0x48940000, ap 75 3c.0 */
+		usb4_tm: target-module@140000 {		/* 0x48940000, ap 75 3c.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "usb_otg_ss4";
 			reg = <0x140000 0x4>,
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
