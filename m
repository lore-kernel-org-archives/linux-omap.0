From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 18/26] ARM: dts: dra7: Fix NAND device nodes.
Date: Fri, 19 Feb 2016 23:15:40 +0200
Message-ID: <1455916548-3441-19-git-send-email-rogerq@ti.com>
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
 arch/arm/boot/dts/dra7-evm.dts  | 6 +++++-
 arch/arm/boot/dts/dra7.dtsi     | 4 ++++
 arch/arm/boot/dts/dra72-evm.dts | 6 +++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index cfc24e5..28ae95e 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -741,9 +741,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x16>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* device IO registers */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>; /* termcount */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8ea153a..1ac3ffdb 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1402,6 +1402,10 @@
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 00b1200..6cf211b 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -492,13 +492,17 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_default>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
 		/* To use NAND, DIP switch SW5 must be set like so:
 		 * SW5.1 (NAND_SELn) = ON (LOW)
 		 * SW5.9 (GPMC_WPN) = OFF (HIGH)
 		 */
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* device IO registers */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
-- 
2.1.4
