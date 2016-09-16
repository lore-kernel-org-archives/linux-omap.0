From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/9] dmaengine: edma: Add missing MODULE_DEVICE_TABLE() for
 of_device_id structs
Date: Fri, 16 Sep 2016 11:33:16 +0300
Message-ID: <20160916083324.29133-2-peter.ujfalusi@ti.com>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160916083324.29133-1-peter.ujfalusi@ti.com>
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

The MODULE_DEVICE_TABLE() were missing from the driver for the of_device_id
structures.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3d277fa76c1a..c2098a4b4dcf 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -274,11 +274,13 @@ static const struct of_device_id edma_of_ids[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, edma_of_ids);
 
 static const struct of_device_id edma_tptc_of_ids[] = {
 	{ .compatible = "ti,edma3-tptc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, edma_tptc_of_ids);
 
 static inline unsigned int edma_read(struct edma_cc *ecc, int offset)
 {
-- 
2.10.0
