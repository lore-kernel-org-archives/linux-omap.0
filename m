From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 23/24] dmaengine: edma: Rename bitfields for slot and channel usage tracking
Date: Wed, 14 Oct 2015 14:43:05 +0300
Message-ID: <1444822986-20562-24-git-send-email-peter.ujfalusi@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The names chosen for the bitfields were quite confusing and given no real
information on what they are used for...

edma_inuse -> slot_inuse: tracks the slot usage/availability
edma_unused -> channel_unused: tracks the channel usage/availability

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 4b2ccc9de0ad..8d9169b7f208 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -227,16 +227,16 @@ struct edma_cc {
 	enum dma_event_q		default_queue;
 
 	bool				unused_chan_list_done;
-	/* The edma_inuse bit for each PaRAM slot is clear unless the
+	/* The slot_inuse bit for each PaRAM slot is clear unless the
 	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
 	 */
-	unsigned long *edma_inuse;
+	unsigned long *slot_inuse;
 
-	/* The edma_unused bit for each channel is clear unless
+	/* The channel_unused bit for each channel is clear unless
 	 * it is not being used on this platform. It uses a bit
 	 * of SOC-specific initialization code.
 	 */
-	unsigned long *edma_unused;
+	unsigned long *channel_unused;
 
 	struct dma_device		dma_slave;
 	struct edma_chan		*slave_chans;
@@ -452,7 +452,7 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 				continue;
 
 			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
-				  ecc->edma_unused);
+				  ecc->channel_unused);
 			of_node_put(dma_spec.np);
 		}
 		return 0;
@@ -469,7 +469,7 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 		dma_req = (int)res->start;
 		if (dma_req >= dma_req_min && dma_req < dma_req_max)
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-				  ecc->edma_unused);
+				  ecc->channel_unused);
 	}
 
 	return 0;
@@ -533,17 +533,17 @@ static int edma_alloc_slot(struct edma_cc *ecc, int slot)
 	if (slot < 0) {
 		slot = ecc->num_channels;
 		for (;;) {
-			slot = find_next_zero_bit(ecc->edma_inuse,
+			slot = find_next_zero_bit(ecc->slot_inuse,
 						  ecc->num_slots,
 						  slot);
 			if (slot == ecc->num_slots)
 				return -ENOMEM;
-			if (!test_and_set_bit(slot, ecc->edma_inuse))
+			if (!test_and_set_bit(slot, ecc->slot_inuse))
 				break;
 		}
 	} else if (slot < ecc->num_channels || slot >= ecc->num_slots) {
 		return -EINVAL;
-	} else if (test_and_set_bit(slot, ecc->edma_inuse)) {
+	} else if (test_and_set_bit(slot, ecc->slot_inuse)) {
 		return -EBUSY;
 	}
 
@@ -559,7 +559,7 @@ static void edma_free_slot(struct edma_cc *ecc, unsigned slot)
 		return;
 
 	edma_write_slot(ecc, slot, &dummy_paramset);
-	clear_bit(slot, ecc->edma_inuse);
+	clear_bit(slot, ecc->slot_inuse);
 }
 
 /**
@@ -631,7 +631,7 @@ static int edma_start(struct edma_cc *ecc, unsigned channel)
 		unsigned int mask = BIT(channel & 0x1f);
 
 		/* EDMA channels without event association */
-		if (test_bit(channel, ecc->edma_unused)) {
+		if (test_bit(channel, ecc->channel_unused)) {
 			dev_dbg(ecc->dev, "ESR%d %08x\n", j,
 				edma_shadow0_read_array(ecc, SH_ESR, j));
 			edma_shadow0_write_array(ecc, SH_ESR, j, mask);
@@ -835,11 +835,11 @@ static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 	if (channel < 0) {
 		channel = 0;
 		for (;;) {
-			channel = find_next_bit(ecc->edma_unused,
+			channel = find_next_bit(ecc->channel_unused,
 						ecc->num_channels, channel);
 			if (channel == ecc->num_channels)
 				break;
-			if (!test_and_set_bit(channel, ecc->edma_inuse)) {
+			if (!test_and_set_bit(channel, ecc->slot_inuse)) {
 				done = 1;
 				break;
 			}
@@ -849,7 +849,7 @@ static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 			return -ENOMEM;
 	} else if (channel >= ecc->num_channels) {
 		return -EINVAL;
-	} else if (test_and_set_bit(channel, ecc->edma_inuse)) {
+	} else if (test_and_set_bit(channel, ecc->slot_inuse)) {
 		return -EBUSY;
 	}
 
@@ -895,7 +895,7 @@ static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
 	/* REVISIT should probably take out of shadow region 0 */
 
 	edma_write_slot(ecc, channel, &dummy_paramset);
-	clear_bit(channel, ecc->edma_inuse);
+	clear_bit(channel, ecc->slot_inuse);
 }
 
 /* Move channel to a specific event queue */
@@ -2137,14 +2137,15 @@ static int edma_probe(struct platform_device *pdev)
 	if (!ecc->slave_chans)
 		return -ENOMEM;
 
-	ecc->edma_unused = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_channels),
-					sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->edma_unused)
+	ecc->channel_unused = devm_kcalloc(dev,
+					   BITS_TO_LONGS(ecc->num_channels),
+					   sizeof(unsigned long), GFP_KERNEL);
+	if (!ecc->channel_unused)
 		return -ENOMEM;
 
-	ecc->edma_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
+	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
 				       sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->edma_inuse)
+	if (!ecc->slot_inuse)
 		return -ENOMEM;
 
 	ecc->default_queue = info->default_queue;
@@ -2153,7 +2154,7 @@ static int edma_probe(struct platform_device *pdev)
 		edma_write_slot(ecc, i, &dummy_paramset);
 
 	/* Mark all channels as unused */
-	memset(ecc->edma_unused, 0xff, sizeof(ecc->edma_unused));
+	memset(ecc->channel_unused, 0xff, sizeof(ecc->channel_unused));
 
 	if (info->rsv) {
 		/* Clear the reserved channels in unused list */
@@ -2162,7 +2163,7 @@ static int edma_probe(struct platform_device *pdev)
 			for (i = 0; rsv_chans[i][0] != -1; i++) {
 				off = rsv_chans[i][0];
 				ln = rsv_chans[i][1];
-				clear_bits(off, ln, ecc->edma_unused);
+				clear_bits(off, ln, ecc->channel_unused);
 			}
 		}
 
@@ -2172,7 +2173,7 @@ static int edma_probe(struct platform_device *pdev)
 			for (i = 0; rsv_slots[i][0] != -1; i++) {
 				off = rsv_slots[i][0];
 				ln = rsv_slots[i][1];
-				set_bits(off, ln, ecc->edma_inuse);
+				set_bits(off, ln, ecc->slot_inuse);
 			}
 		}
 	}
@@ -2182,7 +2183,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (xbar_chans) {
 		for (i = 0; xbar_chans[i][1] != -1; i++) {
 			off = xbar_chans[i][1];
-			clear_bits(off, 1, ecc->edma_unused);
+			clear_bits(off, 1, ecc->channel_unused);
 		}
 	}
 
@@ -2301,7 +2302,7 @@ static int edma_pm_resume(struct device *dev)
 		edma_direct_dmach_to_param_mapping(ecc);
 
 	for (i = 0; i < ecc->num_channels; i++) {
-		if (test_bit(i, ecc->edma_inuse)) {
+		if (test_bit(i, ecc->slot_inuse)) {
 			/* ensure access through shadow region 0 */
 			edma_or_array2(ecc, EDMA_DRAE, 0, i >> 5,
 				       BIT(i & 0x1f));
-- 
2.6.1
