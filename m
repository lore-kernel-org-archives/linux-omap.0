From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Add probe callback to edma_tptc_driver
Date: Wed, 16 Dec 2015 15:19:05 +0200
Message-ID: <1450271945-15263-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, tony@atomide.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Due to changes in device and platform code drivers w/o probe will fail to
load. This means that the devices for eDMA TPTCs are goign to be without
driver and omap hwmod code will turn them off after the kernel finished
loading:
[    3.015900] platform 49800000.tptc: omap_device_late_idle: enabled but no driver.  Idling
[    3.024671] platform 49a00000.tptc: omap_device_late_idle: enabled but no driver.  Idling

This will prevent eDMA to work since the TPTCs are not enabled.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Fixes: 34635b1accb9 ("dmaengine: edma: Add dummy driver skeleton for edma3-tptc")
---
Hi,

The issue surfaced with next-20151216, next-20151214 was worked fine.

Regards,
Peter

 drivers/dma/edma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 2e8acde6b134..50584015e046 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2425,7 +2425,13 @@ static struct platform_driver edma_driver = {
 	},
 };
 
+static int edma_tptc_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
 static struct platform_driver edma_tptc_driver = {
+	.probe		= edma_tptc_probe,
 	.driver = {
 		.name	= "edma3-tptc",
 		.of_match_table = edma_tptc_of_ids,
-- 
2.6.4
