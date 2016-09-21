From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/9] dmaengine: edma: Fix of_device_id data parameter usage
 (legacy vs TPCC)
Date: Wed, 21 Sep 2016 15:41:28 +0300
Message-ID: <20160921124135.11849-3-peter.ujfalusi@ti.com>
References: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160921124135.11849-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use pointers to static constant variables for eDMA binding
type (legacy vs TPCC).

Fixes the following warning when compiling the driver for 64bit
architectures (x86_64 for example):
drivers/dma/edma.c:2185:16: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   if (match && (u32)match->data == EDMA_BINDING_TPCC)
                ^

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index c2098a4b4dcf..87c58710ae31 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -263,14 +263,19 @@ static const struct edmacc_param dummy_paramset = {
 
 #define EDMA_BINDING_LEGACY	0
 #define EDMA_BINDING_TPCC	1
+static const u32 edma_binding_type[] = {
+	[EDMA_BINDING_LEGACY] = EDMA_BINDING_LEGACY,
+	[EDMA_BINDING_TPCC] = EDMA_BINDING_TPCC,
+};
+
 static const struct of_device_id edma_of_ids[] = {
 	{
 		.compatible = "ti,edma3",
-		.data = (void *)EDMA_BINDING_LEGACY,
+		.data = &edma_binding_type[EDMA_BINDING_LEGACY],
 	},
 	{
 		.compatible = "ti,edma3-tpcc",
-		.data = (void *)EDMA_BINDING_TPCC,
+		.data = &edma_binding_type[EDMA_BINDING_TPCC],
 	},
 	{}
 };
@@ -2184,7 +2189,7 @@ static int edma_probe(struct platform_device *pdev)
 		const struct of_device_id *match;
 
 		match = of_match_node(edma_of_ids, node);
-		if (match && (u32)match->data == EDMA_BINDING_TPCC)
+		if (match && (*(u32*)match->data) == EDMA_BINDING_TPCC)
 			legacy_mode = false;
 
 		info = edma_setup_info_from_dt(dev, legacy_mode);
-- 
2.10.0
