From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Check the memory allocation for the memcpy dma device
Date: Wed, 21 Mar 2018 10:30:22 +0200
Message-ID: <20180321083022.32616-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

If the allocation fails then disable the memcpy support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 5b197473106b..519e69e81fca 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1899,6 +1899,11 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 
 	if (memcpy_channels) {
 		m_ddev = devm_kzalloc(ecc->dev, sizeof(*m_ddev), GFP_KERNEL);
+		if (!m_ddev) {
+			dev_warn(ecc->dev, "memcpy is disabled due to OoM\n");
+			memcpy_channels = NULL;
+			goto ch_setup;
+		}
 		ecc->dma_memcpy = m_ddev;
 
 		dma_cap_zero(m_ddev->cap_mask);
@@ -1926,6 +1931,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 		dev_info(ecc->dev, "memcpy is disabled\n");
 	}
 
+ch_setup:
 	for (i = 0; i < ecc->num_channels; i++) {
 		struct edma_chan *echan = &ecc->slave_chans[i];
 		echan->ch_num = EDMA_CTLR_CHAN(ecc->id, i);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
