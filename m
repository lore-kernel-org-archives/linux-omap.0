From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 22/27] ARM: dts: am437x: Fix NAND device nodes
Date: Fri, 18 Sep 2015 17:53:44 +0300
Message-ID: <1442588029-13769-23-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

The GPMC driver now implements gpiochip and irqchip so
enable gpio-controller and interrupt-controller properties.

With this the interrupt parent of NAND node changes so fix it
accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        | 4 ++++
 arch/arm/boot/dts/am437x-gp-evm.dts  | 5 ++++-
 arch/arm/boot/dts/am43x-epos-evm.dts | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a..ec8b7a3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -849,6 +849,10 @@
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 22038f2..aa96c99 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -794,9 +794,12 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>;	/* CS0 space. Min partition = 16MB */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* device IO registers */
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 86c2dfb..9a7786d 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -561,9 +561,12 @@
 	status = "okay";	/* Disable QSPI when enabling GPMC (NAND) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x01000000>;	/* CS0 space. Min partition = 16MB */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
-- 
2.1.4
