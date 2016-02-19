From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 20/26] ARM: dts: am437x: Fix NAND device nodes
Date: Fri, 19 Feb 2016 23:15:42 +0200
Message-ID: <1455916548-3441-21-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
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
 arch/arm/boot/dts/am437x-cm-t43.dts  | 7 +++++--
 arch/arm/boot/dts/am437x-gp-evm.dts  | 6 +++++-
 arch/arm/boot/dts/am43x-epos-evm.dts | 6 +++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 38790a32..5b58679 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -893,6 +893,10 @@
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 8677f4c..1600cad 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -146,10 +146,13 @@
 	pinctrl-0 = <&nand_flash_x8>;
 	ranges = <0 0 0x08000000 0x1000000>;
 	nand@0,0 {
-		reg = <0 0 0>;
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>;		/* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
-
 		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 64d4332..7081b88 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -812,9 +812,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>;	/* CS0 space. Min partition = 16MB */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* device IO registers */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 746fd2b..12b08cf 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -561,9 +561,13 @@
 	status = "okay";	/* Disable QSPI when enabling GPMC (NAND) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x01000000>;	/* CS0 space. Min partition = 16MB */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
-- 
2.1.4
