From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 08/24] ARM/dmaengine: edma: Remove limitation on the number of eDMA controllers
Date: Tue, 22 Sep 2015 12:54:19 +0300
Message-ID: <1442915675-7121-9-git-send-email-peter.ujfalusi@ti.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since the driver stack no longer depends on lookup with id number in a
global array of pointers, the limitation for the number of eDMAs are no
longer needed. We can handle as many eDMAs in legacy and DT boot as we have
memory for them to allocate the needed structures.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 22 +++++-----------------
 drivers/dma/edma.c     | 17 ++++++++---------
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 03692520812a..5b747f1bc8b5 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1227,24 +1227,7 @@ static int edma_probe(struct platform_device *pdev)
 		.parent = &pdev->dev,
 	};
 
-	/* When booting with DT the pdev->id is -1 */
-	if (dev_id < 0)
-		dev_id = arch_num_cc;
-
-	if (dev_id >= EDMA_MAX_CC) {
-		dev_err(dev,
-			"eDMA3 with device id 0 and 1 is supported (id: %d)\n",
-			dev_id);
-		return -EINVAL;
-	}
-
 	if (node) {
-		/* Check if this is a second instance registered */
-		if (arch_num_cc) {
-			dev_err(dev, "only one EDMA instance is supported via DT\n");
-			return -ENODEV;
-		}
-
 		info = edma_setup_info_from_dt(dev, node);
 		if (IS_ERR(info)) {
 			dev_err(dev, "failed to get DT data\n");
@@ -1278,6 +1261,11 @@ static int edma_probe(struct platform_device *pdev)
 
 	cc->dev = dev;
 	cc->id = dev_id;
+	/* When booting with DT the pdev->id is -1 */
+	if (dev_id < 0) {
+		cc->id = 0;
+		dev_id = arch_num_cc;
+	}
 	dev_set_drvdata(dev, cc);
 
 	cc->base = devm_ioremap_resource(dev, mem);
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 53d48b2a700d..fc91ab9dd1bb 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -991,14 +991,12 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	INIT_LIST_HEAD(&dma->channels);
 }
 
-static struct of_dma_filter_info edma_filter_info = {
-	.filter_fn = edma_filter_fn,
-};
-
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_cc *ecc;
 	struct device_node *parent_node = pdev->dev.parent->of_node;
+	struct platform_device *parent_pdev =
+					to_platform_device(pdev->dev.parent);
 	int ret;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -1015,7 +1013,10 @@ static int edma_probe(struct platform_device *pdev)
 	if (!ecc->cc)
 		return -ENODEV;
 
-	ecc->ctlr = pdev->id;
+	ecc->ctlr = parent_pdev->id;
+	if (ecc->ctlr < 0)
+		ecc->ctlr = 0;
+
 	ecc->dummy_slot = edma_alloc_slot(ecc->cc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(&pdev->dev, "Can't allocate PaRAM dummy slot\n");
@@ -1038,10 +1039,8 @@ static int edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ecc);
 
 	if (parent_node) {
-		dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
-		dma_cap_set(DMA_CYCLIC, edma_filter_info.dma_cap);
-		of_dma_controller_register(parent_node, of_dma_simple_xlate,
-					   &edma_filter_info);
+		of_dma_controller_register(parent_node, of_dma_xlate_by_chan_id,
+					   &ecc->dma_slave);
 	}
 
 	dev_info(&pdev->dev, "TI EDMA DMA engine driver\n");
-- 
2.5.2
