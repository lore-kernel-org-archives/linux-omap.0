From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] dmaengine: ti-dma-crossbar: Change the compatible string to ti,dra7-sdma-crossbar
Date: Fri, 5 Jun 2015 18:34:32 +0300
Message-ID: <1433518474-26628-2-git-send-email-peter.ujfalusi@ti.com>
References: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

Currently the driver can be used with sDMA only due to the fact that the
sDMA bindings are using "real DMA_REQ + 1" indexing of the DMA requests.
This is not a case with the eDMA for example so the driver in current form
can not handle the case when it is used with eDMA.
Be precise with the compatible.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/dma.txt             | 2 +-
 Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt | 4 ++--
 drivers/dma/ti-dma-crossbar.c                             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
index 6312fb00ce8d..2ba51ca37cda 100644
--- a/Documentation/devicetree/bindings/dma/dma.txt
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -52,7 +52,7 @@ Optional properties:
 
 Example:
 	sdma_xbar: dma-router@4a002b78 {
-		compatible = "ti,dra7-dma-crossbar";
+		compatible = "ti,dra7-sdma-crossbar";
 		reg = <0x4a002b78 0xfc>;
 		#dma-cells = <1>;
 		dma-requests = <205>;
diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
index 63a48928f3a8..76a10d0724b7 100644
--- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
@@ -1,7 +1,7 @@
 Texas Instruments DMA Crossbar (DMA request router)
 
 Required properties:
-- compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
+- compatible:	"ti,dra7-sdma-crossbar" for DRA7xx sDMA crossbar
 - reg:		Memory map for accessing module
 - #dma-cells:	Should be set to <1>.
 		Clients should use the crossbar request number (input)
@@ -31,7 +31,7 @@ sdma: dma-controller@4a056000 {
 
 /* DMA crossbar */
 sdma_xbar: dma-router@4a002b78 {
-	compatible = "ti,dra7-dma-crossbar";
+	compatible = "ti,dra7-sdma-crossbar";
 	reg = <0x4a002b78 0xfc>;
 	#dma-cells = <1>;
 	dma-requests = <205>;
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 24f5ca2356bf..73ecd0a1e312 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -169,7 +169,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ti_dma_xbar_match[] = {
-	{ .compatible = "ti,dra7-dma-crossbar" },
+	{ .compatible = "ti,dra7-sdma-crossbar" },
 	{},
 };
 
-- 
2.4.2
