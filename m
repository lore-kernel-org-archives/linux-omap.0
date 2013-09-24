From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2] arm: dts: omap5: Add status parameter.
Date: Tue, 24 Sep 2013 12:58:26 +0530
Message-ID: <1380007706-24062-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch disables devices initially(status = "disabled").
Devices will only be probed, if the devices are
present in the board file(status = "okay").

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
v1->v2:
change approach to disabling devices in dtsi and
enable it in respective board file.
 arch/arm/boot/dts/omap5-uevm.dts |   43 ++++++++++++++++++++-----------------
 arch/arm/boot/dts/omap5.dtsi     |   24 +++++++++++++++++++++
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 65d7b60..08d6bc1 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -235,30 +235,26 @@
 };
 
 &mmc1 {
+	status = "okay";
 	vmmc-supply = <&ldo9_reg>;
 	bus-width = <4>;
 };
 
 &mmc2 {
+	status = "okay";
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	ti,non-removable;
 };
 
 &mmc3 {
+	status = "okay";
 	bus-width = <4>;
 	ti,non-removable;
 };
 
-&mmc4 {
-	status = "disabled";
-};
-
-&mmc5 {
-	status = "disabled";
-};
-
 &i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
 
@@ -451,14 +447,19 @@
 };
 
 &i2c5 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c5_pins>;
 
 	clock-frequency = <400000>;
 };
 
-&mcbsp3 {
-	status = "disabled";
+&mcbsp1 {
+	status = "okay";
+};
+
+&mcbsp2 {
+	status = "okay";
 };
 
 &usbhshost {
@@ -470,36 +471,38 @@
 	phys = <0 &hsusb2_phy &hsusb3_phy>;
 };
 
-&mcspi1 {
-
-};
-
 &mcspi2 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi2_pins>;
 };
 
 &mcspi3 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi3_pins>;
 };
 
 &mcspi4 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi4_pins>;
 };
 
 &uart1 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 };
 
 &uart3 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&uart3_pins>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart5 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&uart5_pins>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_pins>;
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 8500beb..96aa7ba 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -259,6 +259,7 @@
 			ti,hwmods = "i2c1";
 			clocks = <&func_96m_fclk>;
 			clock-names = "fck";
+			status = "disabled";
 		};
 
 		i2c2: i2c@48072000 {
@@ -270,6 +271,7 @@
 			ti,hwmods = "i2c2";
 			clocks = <&func_96m_fclk>;
 			clock-names = "fck";
+			status = "disabled";
 		};
 
 		i2c3: i2c@48060000 {
@@ -281,6 +283,7 @@
 			ti,hwmods = "i2c3";
 			clocks = <&func_96m_fclk>;
 			clock-names = "fck";
+			status = "disabled";
 		};
 
 		i2c4: i2c@4807a000 {
@@ -292,6 +295,7 @@
 			ti,hwmods = "i2c4";
 			clocks = <&func_96m_fclk>;
 			clock-names = "fck";
+			status = "disabled";
 		};
 
 		i2c5: i2c@4807c000 {
@@ -303,6 +307,7 @@
 			ti,hwmods = "i2c5";
 			clocks = <&func_96m_fclk>;
 			clock-names = "fck";
+			status = "disabled";
 		};
 
 		mcspi1: spi@48098000 {
@@ -325,6 +330,7 @@
 			       <&sdma 42>;
 			dma-names = "tx0", "rx0", "tx1", "rx1",
 				    "tx2", "rx2", "tx3", "rx3";
+			status = "disabled";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -342,6 +348,7 @@
 			       <&sdma 45>,
 			       <&sdma 46>;
 			dma-names = "tx0", "rx0", "tx1", "rx1";
+			status = "disabled";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -356,6 +363,7 @@
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
+			status = "disabled";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -370,6 +378,7 @@
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
+			status = "disabled";
 		};
 
 		uart1: serial@4806a000 {
@@ -380,6 +389,7 @@
 			clocks = <&func_48m_fclk>;
 			clock-names = "fck";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};
 
 		uart2: serial@4806c000 {
@@ -390,6 +400,7 @@
 			clocks = <&func_48m_fclk>;
 			clock-names = "fck";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart3: serial@48020000 {
@@ -400,6 +411,7 @@
 			clocks = <&func_48m_fclk>;
 			clock-names = "fck";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart4: serial@4806e000 {
@@ -410,6 +422,7 @@
 			clocks = <&func_48m_fclk>;
 			clock-names = "fck";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};
 
 		uart5: serial@48066000 {
@@ -420,6 +433,7 @@
 			clocks = <&func_48m_fclk>;
 			clock-names = "fck";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};
 
 		uart6: serial@48068000 {
@@ -430,6 +444,7 @@
 			clocks = <&func_48m_fclk>;
 			clock-names = "fck";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};
 
 		mmc1: mmc@4809c000 {
@@ -443,6 +458,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mmc2: mmc@480b4000 {
@@ -455,6 +471,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mmc3: mmc@480ad000 {
@@ -467,6 +484,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mmc4: mmc@480d1000 {
@@ -479,6 +497,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mmc5: mmc@480d5000 {
@@ -491,6 +510,7 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		keypad: keypad@4ae1c000 {
@@ -499,6 +519,7 @@
 			ti,hwmods = "kbd";
 			clocks = <&sys_32k_ck>;
 			clock-names = "fck";
+                        status = "disabled";
 		};
 
 		mcpdm: mcpdm@40132000 {
@@ -542,6 +563,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp@40124000 {
@@ -558,6 +580,7 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp3: mcbsp@40126000 {
@@ -574,6 +597,7 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mailbox: mailbox@4a0f4000 {
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
