From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
Date: Wed, 24 Feb 2016 15:41:04 +0530
Message-ID: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

DRA7 SoC has the capability to support DDR memory upto 4GB. In order to
represent this in memory dt node, the address-cells and size cells
should be 2. So, changing the address-cells and size-cells to 2 and
updating the memory nodes accordingly.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts |  2 +-
 arch/arm/boot/dts/dra7-evm.dts            |  2 +-
 arch/arm/boot/dts/dra7.dtsi               | 20 ++++++++++----------
 arch/arm/boot/dts/dra72-evm.dts           |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 50312f8..9b664c5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -24,7 +24,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
+		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
 	vdd_3v3: fixedregulator-vdd_3v3 {
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index c538826..e6c40db 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -21,7 +21,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x20000000>; /* 512 MB - minimal configuration */
+		reg = <0x0 0x80000000 0x0 0x20000000>; /* 512 MB - minimal configuration */
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index cfc24e5..2d1d3dd 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -18,7 +18,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x60000000>; /* 1536 MB */
+		reg = <0x0 0x80000000 0x0 0x60000000>; /* 1536 MB */
 	};
 
 	evm_3v3_sd: fixedregulator-sd {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8ea153a..5460a2a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -15,8 +15,8 @@
 #define MAX_SOURCES 400
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	compatible = "ti,dra7xx";
 	interrupt-parent = <&crossbar_mpu>;
@@ -57,10 +57,10 @@
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = <0x48211000 0x1000>,
-		      <0x48212000 0x1000>,
-		      <0x48214000 0x2000>,
-		      <0x48216000 0x2000>;
+		reg = <0x0 0x48211000 0x0 0x1000>,
+		      <0x0 0x48212000 0x0 0x1000>,
+		      <0x0 0x48214000 0x0 0x2000>,
+		      <0x0 0x48216000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 		interrupt-parent = <&gic>;
 	};
@@ -69,7 +69,7 @@
 		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = <0x48281000 0x1000>;
+		reg = <0x0 0x48281000 0x0 0x1000>;
 		interrupt-parent = <&gic>;
 	};
 
@@ -96,10 +96,10 @@
 		compatible = "ti,dra7-l3-noc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges;
+		ranges = <0x0 0x0 0x0 0xc0000000>;
 		ti,hwmods = "l3_main_1", "l3_main_2";
-		reg = <0x44000000 0x1000000>,
-		      <0x45000000 0x1000>;
+		reg = <0x0 0x44000000 0x0 0x1000000>,
+		      <0x0 0x45000000 0x0 0x1000>;
 		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 00b1200..6a5b0c8 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -17,7 +17,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x40000000>; /* 1024 MB */
+		reg = <0x0 0x80000000 0x0 0x40000000>; /* 1024 MB */
 	};
 
 	aliases {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
