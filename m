From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 11/21] dmaengine: edma: Allocate memory dynamically for bitmaps and structures
Date: Thu, 10 Sep 2015 11:37:40 +0300
Message-ID: <1441874270-2399-12-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Instead of using defines to specify the size of different arrays and
bitmaps, allocate the memory for them based on the information we get from
the HW itself.
Since these defines are set based on the worst case, there are devices
where they are not valid.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 62 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index cdde9a69cc59..153869c9e13c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -113,23 +113,6 @@
 #define CHMAP_EXIST		BIT(24)
 
 /*
- * This will go away when the private EDMA API is folded
- * into this driver and the platform device(s) are
- * instantiated in the arch code. We can only get away
- * with this simplification because DA8XX may not be built
- * in the same kernel image with other DaVinci parts. This
- * avoids having to sprinkle dmaengine driver platform devices
- * and data throughout all the existing board files.
- */
-#ifdef CONFIG_ARCH_DAVINCI_DA8XX
-#define EDMA_CTLRS	2
-#define EDMA_CHANS	32
-#else
-#define EDMA_CTLRS	1
-#define EDMA_CHANS	64
-#endif /* CONFIG_ARCH_DAVINCI_DA8XX */
-
-/*
  * Max of 20 segments per channel to conserve PaRAM slots
  * Also note that MAX_NR_SG should be atleast the no.of periods
  * that are required for ASoC, otherwise DMA prep calls will
@@ -140,16 +123,12 @@
 #define EDMA_MAX_SLOTS		MAX_NR_SG
 #define EDMA_DESCRIPTORS	16
 
-#define EDMA_MAX_PARAMENTRY     512
-
 #define EDMA_CHANNEL_ANY		-1	/* for edma_alloc_channel() */
 #define EDMA_SLOT_ANY			-1	/* for edma_alloc_slot() */
 #define EDMA_CONT_PARAMS_ANY		 1001
 #define EDMA_CONT_PARAMS_FIXED_EXACT	 1002
 #define EDMA_CONT_PARAMS_FIXED_NOT_EXACT 1003
 
-#define EDMA_MAX_CC               2
-
 /* PaRAM slots are laid out like this */
 struct edmacc_param {
 	u32 opt;
@@ -256,22 +235,22 @@ struct edma_cc {
 	/* The edma_inuse bit for each PaRAM slot is clear unless the
 	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
 	 */
-	DECLARE_BITMAP(edma_inuse, EDMA_MAX_PARAMENTRY);
+	unsigned long *edma_inuse;
 
 	/* The edma_unused bit for each channel is clear unless
 	 * it is not being used on this platform. It uses a bit
 	 * of SOC-specific initialization code.
 	 */
-	DECLARE_BITMAP(edma_unused, EDMA_CHANS);
+	unsigned long *edma_unused;
 
 	struct dma_interrupt_data {
 		void (*callback)(unsigned channel, unsigned short ch_status,
 				void *data);
 		void *data;
-	} intr_data[EDMA_CHANS];
+	} *intr_data;
 
 	struct dma_device		dma_slave;
-	struct edma_chan		slave_chans[EDMA_CHANS];
+	struct edma_chan		*slave_chans;
 	int				dummy_slot;
 };
 
@@ -431,6 +410,8 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct edma_cc *ecc = data;
+	int dma_req_min = EDMA_CTLR_CHAN(ecc->id, 0);
+	int dma_req_max = dma_req_min + ecc->num_channels;
 	int i, count;
 	struct of_phandle_args  dma_spec;
 
@@ -466,11 +447,15 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 	/* For non-OF case */
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct resource	*res = &pdev->resource[i];
+		int dma_req;
 
-		if ((res->flags & IORESOURCE_DMA) && (int)res->start >= 0) {
+		if (!(res->flags & IORESOURCE_DMA))
+			continue;
+
+		dma_req = (int)res->start;
+		if (dma_req >= dma_req_min && dma_req < dma_req_max)
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
 				  ecc->edma_unused);
-		}
 	}
 
 	return 0;
@@ -1953,7 +1938,7 @@ static void __init edma_chan_init(struct edma_cc *ecc,
 {
 	int i, j;
 
-	for (i = 0; i < EDMA_CHANS; i++) {
+	for (i = 0; i < ecc->num_channels; i++) {
 		struct edma_chan *echan = &echans[i];
 		echan->ch_num = EDMA_CTLR_CHAN(ecc->id, i);
 		echan->ecc = ecc;
@@ -2222,6 +2207,27 @@ static int edma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Allocate memory based on the information we got from the IP */
+	ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
+					sizeof(*ecc->slave_chans), GFP_KERNEL);
+	if (!ecc->slave_chans)
+		return -ENOMEM;
+
+	ecc->intr_data = devm_kcalloc(dev, ecc->num_channels,
+				      sizeof(*ecc->intr_data), GFP_KERNEL);
+	if (!ecc->intr_data)
+		return -ENOMEM;
+
+	ecc->edma_unused = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_channels),
+					sizeof(unsigned long), GFP_KERNEL);
+	if (!ecc->edma_unused)
+		return -ENOMEM;
+
+	ecc->edma_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
+				       sizeof(unsigned long), GFP_KERNEL);
+	if (!ecc->edma_inuse)
+		return -ENOMEM;
+
 	ecc->default_queue = info->default_queue;
 
 	for (i = 0; i < ecc->num_slots; i++)
-- 
2.5.1
