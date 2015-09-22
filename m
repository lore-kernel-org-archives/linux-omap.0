From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 22/24] dmaengine: edma: Read channel mapping support only once from HW
Date: Tue, 22 Sep 2015 12:54:33 +0300
Message-ID: <1442915675-7121-23-git-send-email-peter.ujfalusi@ti.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Instead of directly reading it from CCCFG register take the information out
once when we set up the configuration from the HW.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index c8350248c0c6..a818d2bf8709 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -223,6 +223,7 @@ struct edma_cc {
 	unsigned			num_region;
 	unsigned			num_slots;
 	unsigned			num_tc;
+	bool				chmap_exist;
 	enum dma_event_q 		default_queue;
 
 	bool				unused_chan_list_done;
@@ -1904,11 +1905,14 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	value = GET_NUM_EVQUE(cccfg);
 	ecc->num_tc = value + 1;
 
+	ecc->chmap_exist = (cccfg & CHMAP_EXIST) ? true : false;
+
 	dev_dbg(dev, "eDMA3 CC HW configuration (cccfg: 0x%08x):\n", cccfg);
 	dev_dbg(dev, "num_region: %u\n", ecc->num_region);
 	dev_dbg(dev, "num_channels: %u\n", ecc->num_channels);
 	dev_dbg(dev, "num_slots: %u\n", ecc->num_slots);
 	dev_dbg(dev, "num_tc: %u\n", ecc->num_tc);
+	dev_dbg(dev, "chmap_exist: %s\n", ecc->chmap_exist ? "yes" : "no");
 
 	/* Nothing need to be done if queue priority is provided */
 	if (pdata->queue_priority_mapping)
@@ -2197,7 +2201,7 @@ static int edma_probe(struct platform_device *pdev)
 					      queue_priority_mapping[i][1]);
 
 	/* Map the channel to param entry if channel mapping logic exist */
-	if (edma_read(ecc, EDMA_CCCFG) & CHMAP_EXIST)
+	if (ecc->chmap_exist)
 		edma_direct_dmach_to_param_mapping(ecc);
 
 	for (i = 0; i < ecc->num_region; i++) {
@@ -2267,7 +2271,7 @@ static int edma_pm_resume(struct device *dev)
 					      queue_priority_mapping[i][1]);
 
 	/* Map the channel to param entry if channel mapping logic */
-	if (edma_read(ecc, EDMA_CCCFG) & CHMAP_EXIST)
+	if (ecc->chmap_exist)
 		edma_direct_dmach_to_param_mapping(ecc);
 
 	for (i = 0; i < ecc->num_channels; i++) {
-- 
2.5.2
