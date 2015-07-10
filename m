From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 08/12] mtd: nand: omap: Update DT binding documentation
Date: Fri, 10 Jul 2015 15:23:35 +0300
Message-ID: <1436531019-18088-9-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, interrupts and update reg property description.
As the NAND controller needs access to GPMC register space, we need
to pass a second memory resource to the NAND controller node.

Due to the weird way the reg property has been implemented (i.e.
CS number required in 1st number of reg property) we will need to
use a number outside the possible CS numbers for the GPMC register space.

As a SoC can have fewer than 10 chip selects, 255 seems like a safe
bet for the GPMC register space.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index fb733c4..3a8ebfa 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -13,7 +13,13 @@ Documentation/devicetree/bindings/mtd/nand.txt
 
 Required properties:
 
+ - compatible:	"ti,omap2-nand"
  - reg:		The CS line the peripheral is connected to
+		Should contain 2 resource specifiers
+		- range id (CS number), base offset and length of the
+		  NAND I/O space
+		- range id,  base offset and length of the GPMC register space.
+ - interrupts:	Interrupt resource specifier for GPMC interrupt.
 
 Optional properties:
 
@@ -55,17 +61,21 @@ Example for an AM33xx board:
 	gpmc: gpmc@50000000 {
 		compatible = "ti,am3352-gpmc";
 		ti,hwmods = "gpmc";
-		reg = <0x50000000 0x1000000>;
+		reg = <0x50000000 0x36c>;
 		interrupts = <100>;
 		gpmc,num-cs = <8>;
 		gpmc,num-waitpins = <2>;
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <0 0 0x08000000 0x2000>;	/* CS0: NAND */
+		ranges = <0 0 0x08000000 0x1000000	/* CS0 space, 16MB */
+			  255 0 0x50000000 0x36c>;	/* GPMC reg space */
 		elm_id = <&elm>;
 
 		nand@0,0 {
-			reg = <0 0 0>; /* CS0, offset 0 */
+			compatible = "ti,omap2-nand";
+			reg = <0 0 4		/* CS0, offset 0, NAND I/O window 4 */
+			       255 0 0x36c>;	/* GPMC reg space */
+			interrupts = <100>;
 			nand-bus-width = <16>;
 			ti,nand-ecc-opt = "bch8";
 			ti,nand-xfer-type = "polled";
-- 
2.1.4
