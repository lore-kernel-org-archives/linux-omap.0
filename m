From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/8] ARM: dts: Add common support for omap3-evm
Date: Thu, 10 Oct 2013 15:20:51 -0700
Message-ID: <20131010222051.9063.82848.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49276 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753259Ab3JJWUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:20:52 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Looks like the main difference between the TMDSEVM3530 and
TMDSEVM3730 is just the omap processor:

http://www.ti.com/tool/tmdsevm3530
http://www.ti.com/tool/tmdsevm3730

So let's add a common file for the EVMs, and fix the description
for the omap3-evm.dst as that's clearly for the TMDSEVM3530
since it includes omap34xx.dtsi. It cannot support the TMDSEVM3730
properly, and we need a separate file for that in the following
patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-common.dtsi |   60 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts         |   58 +-----------------------------
 2 files changed, 62 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm-common.dtsi

diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
new file mode 100644
index 0000000..75753bb
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -0,0 +1,60 @@
+/*
+ * Common support for omap3 EVM boards
+ */
+
+/ {
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		ledb {
+			label = "omap3evm::ledb";
+			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+#include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+
+	/*
+	 * TVP5146 Video decoder-in for analog input support.
+	 */
+	tvp5146@5c {
+		compatible = "ti,tvp5146m2";
+		reg = <0x5c>;
+	};
+};
+
+&twl_gpio {
+	ti,use-leds;
+};
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 7d4329d..e10dcd0 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -8,68 +8,14 @@
 /dts-v1/;
 
 #include "omap34xx.dtsi"
+#include "omap3-evm-common.dtsi"
 
 / {
-	model = "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
+	model = "TI OMAP35XX EVM (TMDSEVM3530)";
 	compatible = "ti,omap3-evm", "ti,omap3";
 
-	cpus {
-		cpu@0 {
-			cpu0-supply = <&vcc>;
-		};
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
-
-	leds {
-		compatible = "gpio-leds";
-		ledb {
-			label = "omap3evm::ledb";
-			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
-			linux,default-trigger = "default-on";
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-	};
-};
-
-#include "twl4030.dtsi"
-#include "twl4030_omap3.dtsi"
-
-&i2c2 {
-	clock-frequency = <400000>;
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-
-	/*
-	 * TVP5146 Video decoder-in for analog input support.
-	 */
-	tvp5146@5c {
-		compatible = "ti,tvp5146m2";
-		reg = <0x5c>;
-	};
-};
-
-&twl_gpio {
-	ti,use-leds;
-};
-
-&usb_otg_hs {
-	interface-type = <0>;
-	usb-phy = <&usb2_phy>;
-	mode = <3>;
-	power = <50>;
 };

