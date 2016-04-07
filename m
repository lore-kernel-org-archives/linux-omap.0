From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 10/17] mtd: nand: omap: Update DT binding documentation
Date: Thu, 7 Apr 2016 13:08:28 +0300
Message-ID: <1460023715-19332-11-git-send-email-rogerq@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com, boris.brezillon@free-electrons.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id and interrupts. The NAND interrupts are
provided by the GPMC controller node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index fb733c4..ff3215d2 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -13,7 +13,11 @@ Documentation/devicetree/bindings/mtd/nand.txt
 
 Required properties:
 
- - reg:		The CS line the peripheral is connected to
+ - compatible:	"ti,omap2-nand"
+ - reg:		range id (CS number), base offset and length of the
+		NAND I/O space
+ - interrupt-parent: must point to gpmc node
+ - interrupts:	Two interrupt specifiers, one for fifoevent, one for termcount.
 
 Optional properties:
 
@@ -55,17 +59,22 @@ Example for an AM33xx board:
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
+		ranges = <0 0 0x08000000 0x1000000>;	/* CS0 space, 16MB */
 		elm_id = <&elm>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		nand@0,0 {
-			reg = <0 0 0>; /* CS0, offset 0 */
+			compatible = "ti,omap2-nand";
+			reg = <0 0 4>;		/* CS0, offset 0, NAND I/O window 4 */
+			interrupt-parent = <&gpmc>;
+			interrupts = <0 IRQ_TYPE_NONE>, <1 IRQ_TYPE NONE>;
 			nand-bus-width = <16>;
 			ti,nand-ecc-opt = "bch8";
 			ti,nand-xfer-type = "polled";
-- 
2.5.0
