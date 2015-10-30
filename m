From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/3] dmaengine: ti-dma-crossbar: dra7: Support for
 reserving DMA event ranges
Date: Fri, 30 Oct 2015 10:00:37 +0200
Message-ID: <1446192038-11158-3-git-send-email-peter.ujfalusi@ti.com>
References: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In eDMA the events are directly mapped to a DMA channel (for example DMA
event 14 can only be handled by DMA channel 14). If the memcpy is enabled
on the eDMA, there is a possibility that the crossbar driver would assign
DMA event number already allocated in eDMA for memcpy. Furthermore the
eDMA can be shared with DSP in which case the crossbar driver should also
avoid mapping xbar events to DSP used event numbers (or channels).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  6 +++
 drivers/dma/ti-dma-crossbar.c                      | 47 ++++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
index b152a75dceae..aead5869a28d 100644
--- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
@@ -14,6 +14,10 @@ The DMA controller node need to have the following poroperties:
 
 Optional properties:
 - ti,dma-safe-map: Safe routing value for unused request lines
+- ti,reserved-dma-request-ranges: DMA request ranges which should not be used
+		when mapping xbar input to DMA request, they are either
+		allocated to be used by for example the DSP or they are used as
+		memcpy channels in eDMA.
 
 Notes:
 When requesting channel via ti,dra7-dma-crossbar, the DMA clinet must request
@@ -46,6 +50,8 @@ sdma_xbar: dma-router@4a002b78 {
 	#dma-cells = <1>;
 	dma-requests = <205>;
 	ti,dma-safe-map = <0>;
+	/* Protect the sDMA request ranges: 10-14 and 100-126 */
+	ti,reserved-dma-request-ranges = <10 5>, <100 27>;
 	dma-masters = <&sdma>;
 };
 
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 463ad6b18a32..dac7ae06cc58 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -292,14 +292,22 @@ static const struct of_device_id ti_dra7_master_match[] = {
 	{},
 };
 
+static inline void ti_dra7_xbar_reserve(int offset, int len, unsigned long *p)
+{
+	for (; len > 0; len--)
+		clear_bit(offset + (len - 1), p);
+}
+
 static int ti_dra7_xbar_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct device_node *dma_node;
 	struct ti_dra7_xbar_data *xbar;
+	struct property *prop;
 	struct resource *res;
 	u32 safe_val;
+	size_t sz;
 	void __iomem *iomem;
 	int i, ret;
 
@@ -347,6 +355,33 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(node, "ti,dma-safe-map", &safe_val))
 		xbar->safe_val = (u16)safe_val;
 
+
+	prop = of_find_property(node, "ti,reserved-dma-request-ranges", &sz);
+	if (prop) {
+		const char pname[] = "ti,reserved-dma-request-ranges";
+		u32 (*rsv_events)[2];
+		size_t nelm = sz / sizeof(*rsv_events);
+		int i;
+
+		if (!nelm)
+			return -EINVAL;
+
+		rsv_events = kcalloc(nelm, sizeof(*rsv_events), GFP_KERNEL);
+		if (!rsv_events)
+			return -ENOMEM;
+
+		ret = of_property_read_u32_array(node, pname, (u32 *)rsv_events,
+						 nelm * 2);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < nelm; i++) {
+			ti_dra7_xbar_reserve(rsv_events[i][0], rsv_events[i][1],
+					     xbar->dma_inuse);
+		}
+		kfree(rsv_events);
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iomem = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(iomem))
@@ -362,15 +397,19 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, xbar);
 
 	/* Reset the crossbar */
-	for (i = 0; i < xbar->dma_requests; i++)
-		ti_dra7_xbar_write(xbar->iomem, i, xbar->safe_val);
+	for (i = 0; i < xbar->dma_requests; i++) {
+		if (!test_bit(i, xbar->dma_inuse))
+			ti_dra7_xbar_write(xbar->iomem, i, xbar->safe_val);
+	}
 
 	ret = of_dma_router_register(node, ti_dra7_xbar_route_allocate,
 				     &xbar->dmarouter);
 	if (ret) {
 		/* Restore the defaults for the crossbar */
-		for (i = 0; i < xbar->dma_requests; i++)
-			ti_dra7_xbar_write(xbar->iomem, i, i);
+		for (i = 0; i < xbar->dma_requests; i++) {
+			if (!test_bit(i, xbar->dma_inuse))
+				ti_dra7_xbar_write(xbar->iomem, i, i);
+		}
 	}
 
 	return ret;
-- 
2.6.1
