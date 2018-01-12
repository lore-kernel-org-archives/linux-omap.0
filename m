From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v6 01/14] dt-bindings: mtd: gpmc-onenand: Update properties
 description
Date: Fri, 12 Jan 2018 14:11:53 +0100
Message-ID: <20180112131153.GB13810@lenoch>
References: <20180112131105.GA13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180112131105.GA13810@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Compatible property is required for OMAP2+ mtd driver. Also
add INT pin gpio description and delete unused dma-channel
property.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---

Changes in v6: None
Changes in v5:
- renamed R/B pin to INT pin

Changes in v4:
- new patch

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
index b6e8bfd024f4..e9f01a963a0a 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
@@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
 
 Required properties:
 
+ - compatible:		"ti,omap2-onenand"
  - reg:			The CS line the peripheral is connected to
- - gpmc,device-width	Width of the ONENAND device connected to the GPMC
+ - gpmc,device-width:	Width of the ONENAND device connected to the GPMC
 			in bytes. Must be 1 or 2.
 
 Optional properties:
 
- - dma-channel:		DMA Channel index
+ - int-gpios:		GPIO specifier for the INT pin.
 
 For inline partition table parsing (optional):
 
@@ -35,6 +36,7 @@ Example for an OMAP3430 board:
 		#size-cells = <1>;
 
 		onenand@0 {
+			compatible = "ti,omap2-onenand";
 			reg = <0 0 0>; /* CS0, offset 0 */
 			gpmc,device-width = <2>;
 
-- 
2.15.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
