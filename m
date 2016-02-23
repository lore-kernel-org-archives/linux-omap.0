From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 5/9] ARM: dts: am335x: Fix NAND device nodes
Date: Tue, 23 Feb 2016 18:37:21 +0200
Message-ID: <1456245445-31824-6-git-send-email-rogerq@ti.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, Ilya Ledvich <ilya@compulab.co.il>, Yegor Yefremov <yegorslists@googlemail.com>, Rostislav Lisovy <lisovy@gmail.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

The GPMC node will provide an interrupt controller for the
NAND IRQs.

Cc: Teresa Remmet <t.remmet@phytec.de>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Rostislav Lisovy <lisovy@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 6 +++++-
 arch/arm/boot/dts/am335x-chilisom.dtsi     | 5 +++++
 arch/arm/boot/dts/am335x-cm-t335.dts       | 7 ++++++-
 arch/arm/boot/dts/am335x-evm.dts           | 4 ++++
 arch/arm/boot/dts/am335x-igep0033.dtsi     | 5 +++++
 arch/arm/boot/dts/am335x-phycore-som.dtsi  | 5 +++++
 arch/arm/boot/dts/am33xx.dtsi              | 2 ++
 7 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index ded1eb6..7b6bcb0 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -236,7 +236,11 @@
 	status = "okay";
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		ti,nand-xfer-type = "polled";
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index fda457b..e8e7d9d 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -7,6 +7,7 @@
  * published by the Free Software Foundation.
  */
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Grinn AM335x ChiliSOM";
@@ -218,7 +219,11 @@
 	pinctrl-0 = <&nandflash_pins>;
 	ranges = <0 0 0x08000000 0x01000000>; /* CS0 0 @addr 0x08000000, size 0x01000000 */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 42e9b66..571df14 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "CompuLab CM-T335";
@@ -302,7 +303,11 @@ status = "okay";
 	pinctrl-0 = <&nandflash_pins>;
 	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0d6a68c..4e7a53e6a 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -519,7 +519,11 @@
 	pinctrl-0 = <&nandflash_pins_s0>;
 	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 54f1135..4cfe041 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	cpus {
@@ -129,7 +130,11 @@
 	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-width = <1>;
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index c20ae6c..80a5687 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -8,6 +8,7 @@
  */
 
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Phytec AM335x phyCORE";
@@ -165,7 +166,11 @@
 	pinctrl-0 = <&nandflash_pins>;
 	ranges = <0 0 0x08000000 0x1000000>;   /* CS0: NAND */
 	nandflash: nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-nand = "true";
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 04885f9..b8ca5b4 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -865,6 +865,8 @@
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			status = "disabled";
 		};
 
-- 
2.5.0
