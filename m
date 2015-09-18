From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 12/27] mtd: nand: omap: Update DT binding documentation
Date: Fri, 18 Sep 2015 17:53:34 +0300
Message-ID: <1442588029-13769-13-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id and interrupts. The NAND interrupts are
provided by the GPMC controller node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index fb733c4..253e6de 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -13,7 +13,11 @@ Documentation/devicetree/bindings/mtd/nand.txt
 
 Required properties:
 
- - reg:		The CS line the peripheral is connected to
+ - compatible:	"ti,omap2-nand"
+ - reg:		range id (CS number), base offset and length of the
+		NAND I/O space
+ - interrupt-parent: must point to gpmc node
+ - interrupts: gpmc interrupt
 
 Optional properties:
 
@@ -55,20 +59,24 @@ Example for an AM33xx board:
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
 
 		nand@0,0 {
-			reg = <0 0 0>; /* CS0, offset 0 */
+			compatible = "ti,omap2-nand";
+			reg = <0 0 4>;		/* CS0, offset 0, NAND I/O window 4 */
+			interrupts = <100>;
 			nand-bus-width = <16>;
 			ti,nand-ecc-opt = "bch8";
 			ti,nand-xfer-type = "polled";
+			interrupt-parent = <&gpmc>;
+			interrupts = <0>, <1>;
 
 			gpmc,sync-clk-ps = <0>;
 			gpmc,cs-on-ns = <0>;
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
