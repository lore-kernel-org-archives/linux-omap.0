From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 12/14] dmaengine: edma: New device tree binding
Date: Fri, 16 Oct 2015 10:18:10 +0300
Message-ID: <1444979892-31626-13-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

With the old binding and driver architecture we had many issues:
No way to assign eDMA channels to event queues, thus not able to tune the
system by moving specific DMA channels to low/high priority servicing. We
moved the cyclic channels to high priority within the code, but that was
just a workaround to this issue.
Memcopy was fundamentally broken: even if the driver scanned the DT/devices
in the booted system for direct DMA users (which is not effective when the
events are going through a crossbar) and created a map of 'used' channels,
this information was not really usable. Since via dmaengien API the eDMA
driver will be called with _some_ channel number, we would try to request
this channel when any channel is requested for memcpy. By luck we got
channel which is not used by any device most of the time so things worked,
but if a device would have been using the given channel, but not requested
it, the memcpy channel would have been waiting for HW event.
The old code had the am33xx/am43xx DMA event router handling embedded. This
should have been done in a separate driver since it is not part of the
actual eDMA IP.
There were no way to 'lock' PaRAM slots to be used by the DSP for example
when booting with DT.
In DT boot the edma node used more than one hwmod which is not a good
practice and the kernel prints warning because of this.

With the new bindings and the changes in the driver we can:
- No regression with Legacy binding and non DT boot
- DMA channels can be assigned to any TC (to set priority)
- PaRAM slots can be reserved for other cores to use
- Dynamic power management for CC and TCs, if only TC0 is used all other TC
  can be powered down for example

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 117 +++++-
 drivers/dma/edma.c                                | 486 +++++++++++++++-------
 include/linux/platform_data/edma.h                |   3 +
 3 files changed, 459 insertions(+), 147 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 5ba525a10035..d3d0a4fb1c73 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -1,4 +1,119 @@
-TI EDMA
+Texas Instruments eDMA
+
+The eDMA3 consists of two components: Channel controller (CC) and Transfer
+Controller(s) (TC). The CC is the main entry for DMA users since it is
+responsible for the DMA channel handling, while the TCs are responsible to
+execute the actual DMA tansfer.
+
+------------------------------------------------------------------------------
+eDMA3 Channel Controller
+
+Required properties:
+- compatible:	"ti,edma3-tpcc" for the channel controller(s)
+- #dma-cells:	Should be set to <2>. The first number is the DMA request
+		number and the second is the TC the channel is serviced on.
+- reg:		Memory map of eDMA CC
+- reg-names:	"edma3_cc"
+- interrupts:	Interrupt lines for CCINT, MPERR and CCERRINT.
+- interrupt-names: "edma3_ccint", "emda3_mperr" and "edma3_ccerrint"
+- ti,tptcs:	List of TPTCs associated with the eDMA in the following form:
+		<&tptc_phandle TC_priority_number>. The highest priority is 0.
+
+Optional properties:
+- ti,hwmods:	Name of the hwmods associated to the eDMA CC
+- ti,edma-memcpy-channels: List of channels allocated to be used for memcpy, iow
+		these channels will be SW triggered channels. The list must
+		contain 16 bits numbers, see example.
+- ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
+		the driver, they are allocated to be used by for example the
+		DSP. See example.
+
+------------------------------------------------------------------------------
+eDMA3 Transfer Controller
+
+Required properties:
+- compatible:	"ti,edma3-tptc" for the transfer controller(s)
+- reg:		Memory map of eDMA TC
+- interrupts:	Interrupt number for TCerrint.
+
+Optional properties:
+- ti,hwmods:	Name of the hwmods associated to the given eDMA TC
+- interrupt-names: "edma3_tcerrint"
+
+------------------------------------------------------------------------------
+Example:
+
+edma: edma@49000000 {
+	compatible = "ti,edma3-tpcc";
+	ti,hwmods = "tpcc";
+	reg =	<0x49000000 0x10000>;
+	reg-names = "edma3_cc";
+	interrupts = <12 13 14>;
+	interrupt-names = "edma3_ccint", "emda3_mperr", "edma3_ccerrint";
+	dma-requests = <64>;
+	#dma-cells = <2>;
+
+	ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 7>, <&edma_tptc2 0>;
+
+	/* Channel 20 and 21 is allocated for memcpy */
+	ti,edma-memcpy-channels = /bits/ 16 <20 21>;
+	/* The following PaRAM slots are reserved: 35-45 and 100-110 */
+	ti,edma-reserved-slot-ranges = /bits/ 16 <35 10>,
+				       /bits/ 16 <100 10>;
+};
+
+edma_tptc0: tptc@49800000 {
+	compatible = "ti,edma3-tptc";
+	ti,hwmods = "tptc0";
+	reg =	<0x49800000 0x100000>;
+	interrupts = <112>;
+	interrupt-names = "edm3_tcerrint";
+};
+
+edma_tptc1: tptc@49900000 {
+	compatible = "ti,edma3-tptc";
+	ti,hwmods = "tptc1";
+	reg =	<0x49900000 0x100000>;
+	interrupts = <113>;
+	interrupt-names = "edm3_tcerrint";
+};
+
+edma_tptc2: tptc@49a00000 {
+	compatible = "ti,edma3-tptc";
+	ti,hwmods = "tptc2";
+	reg =	<0x49a00000 0x100000>;
+	interrupts = <114>;
+	interrupt-names = "edm3_tcerrint";
+};
+
+sham: sham@53100000 {
+	compatible = "ti,omap4-sham";
+	ti,hwmods = "sham";
+	reg = <0x53100000 0x200>;
+	interrupts = <109>;
+	/* DMA channel 36 executed on eDMA TC0 - low priority queue */
+	dmas = <&edma 36 0>;
+	dma-names = "rx";
+};
+
+mcasp0: mcasp@48038000 {
+	compatible = "ti,am33xx-mcasp-audio";
+	ti,hwmods = "mcasp0";
+	reg = <0x48038000 0x2000>,
+		<0x46000000 0x400000>;
+	reg-names = "mpu", "dat";
+	interrupts = <80>, <81>;
+	interrupt-names = "tx", "rx";
+	status = "disabled";
+	/* DMA channels 8 and 9 executed on eDMA TC2 - high priority queue */
+	dmas = <&edma 8 2>,
+	       <&edma 9 2>;
+	dma-names = "tx", "rx";
+};
+
+------------------------------------------------------------------------------
+DEPRECATED binding, new DTS files must use the ti,edma3-tpcc/ti,edma3-tptc
+binding.
 
 Required properties:
 - compatible : "ti,edma3"
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d4d71e60da1b..31722d436a42 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -201,13 +201,20 @@ struct edma_desc {
 
 struct edma_cc;
 
+struct edma_tc {
+	struct device_node		*node;
+	u16				id;
+};
+
 struct edma_chan {
 	struct virt_dma_chan		vchan;
 	struct list_head		node;
 	struct edma_desc		*edesc;
 	struct edma_cc			*ecc;
+	struct edma_tc			*tc;
 	int				ch_num;
 	bool				alloced;
+	bool				hw_triggered;
 	int				slot[EDMA_MAX_SLOTS];
 	int				missed;
 	struct dma_slave_config		cfg;
@@ -218,6 +225,7 @@ struct edma_cc {
 	struct edma_soc_info		*info;
 	void __iomem			*base;
 	int				id;
+	bool				legacy_mode;
 
 	/* eDMA3 resource information */
 	unsigned			num_channels;
@@ -228,20 +236,16 @@ struct edma_cc {
 	bool				chmap_exist;
 	enum dma_event_q		default_queue;
 
-	bool				unused_chan_list_done;
-	/* The slot_inuse bit for each PaRAM slot is clear unless the
-	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
+	/*
+	 * The slot_inuse bit for each PaRAM slot is clear unless the slot is
+	 * in use by Linux or if it is allocated to be used by DSP.
 	 */
 	unsigned long *slot_inuse;
 
-	/* The channel_unused bit for each channel is clear unless
-	 * it is not being used on this platform. It uses a bit
-	 * of SOC-specific initialization code.
-	 */
-	unsigned long *channel_unused;
-
 	struct dma_device		dma_slave;
+	struct dma_device		*dma_memcpy;
 	struct edma_chan		*slave_chans;
+	struct edma_tc			*tc_list;
 	int				dummy_slot;
 };
 
@@ -251,8 +255,17 @@ static const struct edmacc_param dummy_paramset = {
 	.ccnt = 1,
 };
 
+#define EDMA_BINDING_LEGACY	0
+#define EDMA_BINDING_TPCC	1
 static const struct of_device_id edma_of_ids[] = {
-	{ .compatible = "ti,edma3", },
+	{
+		.compatible = "ti,edma3",
+		.data = (void *)EDMA_BINDING_LEGACY,
+	},
+	{
+		.compatible = "ti,edma3-tpcc",
+		.data = (void *)EDMA_BINDING_TPCC,
+	},
 	{}
 };
 
@@ -412,60 +425,6 @@ static void edma_set_chmap(struct edma_chan *echan, int slot)
 	}
 }
 
-static int prepare_unused_channel_list(struct device *dev, void *data)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct edma_cc *ecc = data;
-	int dma_req_min = EDMA_CTLR_CHAN(ecc->id, 0);
-	int dma_req_max = dma_req_min + ecc->num_channels;
-	int i, count;
-	struct of_phandle_args  dma_spec;
-
-	if (dev->of_node) {
-		struct platform_device *dma_pdev;
-
-		count = of_property_count_strings(dev->of_node, "dma-names");
-		if (count < 0)
-			return 0;
-		for (i = 0; i < count; i++) {
-			if (of_parse_phandle_with_args(dev->of_node, "dmas",
-						       "#dma-cells", i,
-						       &dma_spec))
-				continue;
-
-			if (!of_match_node(edma_of_ids, dma_spec.np)) {
-				of_node_put(dma_spec.np);
-				continue;
-			}
-
-			dma_pdev = of_find_device_by_node(dma_spec.np);
-			if (&dma_pdev->dev != ecc->dev)
-				continue;
-
-			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
-				  ecc->channel_unused);
-			of_node_put(dma_spec.np);
-		}
-		return 0;
-	}
-
-	/* For non-OF case */
-	for (i = 0; i < pdev->num_resources; i++) {
-		struct resource	*res = &pdev->resource[i];
-		int dma_req;
-
-		if (!(res->flags & IORESOURCE_DMA))
-			continue;
-
-		dma_req = (int)res->start;
-		if (dma_req >= dma_req_min && dma_req < dma_req_max)
-			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-				  ecc->channel_unused);
-	}
-
-	return 0;
-}
-
 static void edma_setup_interrupt(struct edma_chan *echan, bool enable)
 {
 	struct edma_cc *ecc = echan->ecc;
@@ -617,7 +576,7 @@ static void edma_start(struct edma_chan *echan)
 	int j = (channel >> 5);
 	unsigned int mask = BIT(channel & 0x1f);
 
-	if (test_bit(channel, ecc->channel_unused)) {
+	if (!echan->hw_triggered) {
 		/* EDMA channels without event association */
 		dev_dbg(ecc->dev, "ESR%d %08x\n", j,
 			edma_shadow0_read_array(ecc, SH_ESR, j));
@@ -734,20 +693,6 @@ static int edma_alloc_channel(struct edma_chan *echan,
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
 
-	if (!ecc->unused_chan_list_done) {
-		/*
-		 * Scan all the platform devices to find out the EDMA channels
-		 * used and clear them in the unused list, making the rest
-		 * available for ARM usage.
-		 */
-		int ret = bus_for_each_dev(&platform_bus_type, NULL, ecc,
-					   prepare_unused_channel_list);
-		if (ret < 0)
-			return ret;
-
-		ecc->unused_chan_list_done = true;
-	}
-
 	/* ensure access through shadow region 0 */
 	edma_or_array2(ecc, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
 
@@ -899,7 +844,7 @@ static int edma_terminate_all(struct dma_chan *chan)
 	if (echan->edesc) {
 		edma_stop(echan);
 		/* Move the cyclic channel back to default queue */
-		if (echan->edesc->cyclic)
+		if (!echan->tc && echan->edesc->cyclic)
 			edma_assign_channel_eventq(echan, EVENTQ_DEFAULT);
 		/*
 		 * free the running request descriptor
@@ -1403,7 +1348,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-	edma_assign_channel_eventq(echan, EVENTQ_0);
+	if (!echan->tc)
+		edma_assign_channel_eventq(echan, EVENTQ_0);
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
@@ -1609,18 +1555,54 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
+{
+	struct platform_device *tc_pdev;
+	int ret;
+
+	if (!tc)
+		return;
+
+	tc_pdev = of_find_device_by_node(tc->node);
+	if (!tc_pdev) {
+		pr_err("%s: TPTC device is not found\n", __func__);
+		return;
+	}
+	if (!pm_runtime_enabled(&tc_pdev->dev))
+		pm_runtime_enable(&tc_pdev->dev);
+
+	if (enable)
+		ret = pm_runtime_get_sync(&tc_pdev->dev);
+	else
+		ret = pm_runtime_put_sync(&tc_pdev->dev);
+
+	if (ret < 0)
+		pr_err("%s: pm_runtime_%s_sync() failed for %s\n", __func__,
+		       enable ? "get" : "put", dev_name(&tc_pdev->dev));
+}
+
 /* Alloc channel resources */
 static int edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
-	struct device *dev = chan->device->dev;
+	struct edma_cc *ecc = echan->ecc;
+	struct device *dev = ecc->dev;
+	enum dma_event_q eventq_no = EVENTQ_DEFAULT;
 	int ret;
 
-	ret = edma_alloc_channel(echan, EVENTQ_DEFAULT);
+	if (echan->tc) {
+		eventq_no = echan->tc->id;
+	} else if (ecc->tc_list) {
+		/* memcpy channel */
+		echan->tc = &ecc->tc_list[ecc->info->default_queue];
+		eventq_no = echan->tc->id;
+	}
+
+	ret = edma_alloc_channel(echan, eventq_no);
 	if (ret)
 		return ret;
 
-	echan->slot[0] = edma_alloc_slot(echan->ecc, echan->ch_num);
+	echan->slot[0] = edma_alloc_slot(ecc, echan->ch_num);
 	if (echan->slot[0] < 0) {
 		dev_err(dev, "Entry slot allocation failed for channel %u\n",
 			EDMA_CHAN_SLOT(echan->ch_num));
@@ -1631,8 +1613,11 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	edma_set_chmap(echan, echan->slot[0]);
 	echan->alloced = true;
 
-	dev_dbg(dev, "allocated channel %d for %u:%u\n", echan->ch_num,
-		EDMA_CTLR(echan->ch_num), EDMA_CHAN_SLOT(echan->ch_num));
+	dev_dbg(dev, "Got eDMA channel %d for virt channel %d (%s trigger)\n",
+		EDMA_CHAN_SLOT(echan->ch_num), chan->chan_id,
+		echan->hw_triggered ? "HW" : "SW");
+
+	edma_tc_set_pm_state(echan->tc, true);
 
 	return 0;
 
@@ -1645,6 +1630,7 @@ err_slot:
 static void edma_free_chan_resources(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
+	struct device *dev = echan->ecc->dev;
 	int i;
 
 	/* Terminate transfers */
@@ -1669,7 +1655,12 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 		echan->alloced = false;
 	}
 
-	dev_dbg(chan->device->dev, "freeing channel for %u\n", echan->ch_num);
+	edma_tc_set_pm_state(echan->tc, false);
+	echan->tc = NULL;
+	echan->hw_triggered = false;
+
+	dev_dbg(dev, "Free eDMA channel %d for virt channel %d\n",
+		EDMA_CHAN_SLOT(echan->ch_num), chan->chan_id);
 }
 
 /* Send pending descriptor to hardware */
@@ -1756,41 +1747,90 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 	return ret;
 }
 
+static bool edma_is_memcpy_channel(int ch_num, u16 *memcpy_channels)
+{
+	s16 *memcpy_ch = memcpy_channels;
+
+	if (!memcpy_channels)
+		return false;
+	while (*memcpy_ch != -1) {
+		if (*memcpy_ch == ch_num)
+			return true;
+		memcpy_ch++;
+	}
+	return false;
+}
+
 #define EDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
-static void edma_dma_init(struct edma_cc *ecc)
+static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 {
-	struct dma_device *ddev = &ecc->dma_slave;
+	struct dma_device *s_ddev = &ecc->dma_slave;
+	struct dma_device *m_ddev = NULL;
+	s16 *memcpy_channels = ecc->info->memcpy_channels;
 	int i, j;
 
-	dma_cap_zero(ddev->cap_mask);
-	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
-	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
-	dma_cap_set(DMA_MEMCPY, ddev->cap_mask);
+	dma_cap_zero(s_ddev->cap_mask);
+	dma_cap_set(DMA_SLAVE, s_ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, s_ddev->cap_mask);
+	if (ecc->legacy_mode && !memcpy_channels) {
+		dev_warn(ecc->dev,
+			 "Legacy memcpy is enabled, things might not work\n");
 
-	ddev->device_prep_slave_sg = edma_prep_slave_sg;
-	ddev->device_prep_dma_cyclic = edma_prep_dma_cyclic;
-	ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
-	ddev->device_alloc_chan_resources = edma_alloc_chan_resources;
-	ddev->device_free_chan_resources = edma_free_chan_resources;
-	ddev->device_issue_pending = edma_issue_pending;
-	ddev->device_tx_status = edma_tx_status;
-	ddev->device_config = edma_slave_config;
-	ddev->device_pause = edma_dma_pause;
-	ddev->device_resume = edma_dma_resume;
-	ddev->device_terminate_all = edma_terminate_all;
-
-	ddev->src_addr_widths = EDMA_DMA_BUSWIDTHS;
-	ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
-	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
-
-	ddev->dev = ecc->dev;
+		dma_cap_set(DMA_MEMCPY, s_ddev->cap_mask);
+		s_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
+		s_ddev->directions = BIT(DMA_MEM_TO_MEM);
+	}
 
-	INIT_LIST_HEAD(&ddev->channels);
+	s_ddev->device_prep_slave_sg = edma_prep_slave_sg;
+	s_ddev->device_prep_dma_cyclic = edma_prep_dma_cyclic;
+	s_ddev->device_alloc_chan_resources = edma_alloc_chan_resources;
+	s_ddev->device_free_chan_resources = edma_free_chan_resources;
+	s_ddev->device_issue_pending = edma_issue_pending;
+	s_ddev->device_tx_status = edma_tx_status;
+	s_ddev->device_config = edma_slave_config;
+	s_ddev->device_pause = edma_dma_pause;
+	s_ddev->device_resume = edma_dma_resume;
+	s_ddev->device_terminate_all = edma_terminate_all;
+
+	s_ddev->src_addr_widths = EDMA_DMA_BUSWIDTHS;
+	s_ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
+	s_ddev->directions |= (BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV));
+	s_ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	s_ddev->dev = ecc->dev;
+	INIT_LIST_HEAD(&s_ddev->channels);
+
+	if (memcpy_channels) {
+		m_ddev = devm_kzalloc(ecc->dev, sizeof(*m_ddev), GFP_KERNEL);
+		ecc->dma_memcpy = m_ddev;
+
+		dma_cap_zero(m_ddev->cap_mask);
+		dma_cap_set(DMA_MEMCPY, m_ddev->cap_mask);
+
+		m_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
+		m_ddev->device_alloc_chan_resources = edma_alloc_chan_resources;
+		m_ddev->device_free_chan_resources = edma_free_chan_resources;
+		m_ddev->device_issue_pending = edma_issue_pending;
+		m_ddev->device_tx_status = edma_tx_status;
+		m_ddev->device_config = edma_slave_config;
+		m_ddev->device_pause = edma_dma_pause;
+		m_ddev->device_resume = edma_dma_resume;
+		m_ddev->device_terminate_all = edma_terminate_all;
+
+		m_ddev->src_addr_widths = EDMA_DMA_BUSWIDTHS;
+		m_ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
+		m_ddev->directions = BIT(DMA_MEM_TO_MEM);
+		m_ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+		m_ddev->dev = ecc->dev;
+		INIT_LIST_HEAD(&m_ddev->channels);
+	} else if (!ecc->legacy_mode) {
+		dev_info(ecc->dev, "memcpy is disabled\n");
+	}
 
 	for (i = 0; i < ecc->num_channels; i++) {
 		struct edma_chan *echan = &ecc->slave_chans[i];
@@ -1798,7 +1838,10 @@ static void edma_dma_init(struct edma_cc *ecc)
 		echan->ecc = ecc;
 		echan->vchan.desc_free = edma_desc_free;
 
-		vchan_init(&echan->vchan, ddev);
+		if (m_ddev && edma_is_memcpy_channel(i, memcpy_channels))
+			vchan_init(&echan->vchan, m_ddev);
+		else
+			vchan_init(&echan->vchan, s_ddev);
 
 		INIT_LIST_HEAD(&echan->node);
 		for (j = 0; j < EDMA_MAX_SLOTS; j++)
@@ -1921,7 +1964,8 @@ static int edma_xbar_event_map(struct device *dev, struct edma_soc_info *pdata,
 	return 0;
 }
 
-static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev)
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
+						     bool legacy_mode)
 {
 	struct edma_soc_info *info;
 	struct property *prop;
@@ -1932,20 +1976,121 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev)
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map", &sz);
+	if (legacy_mode) {
+		prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map",
+					&sz);
+		if (prop) {
+			ret = edma_xbar_event_map(dev, info, sz);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+		return info;
+	}
+
+	/* Get the list of channels allocated to be used for memcpy */
+	prop = of_find_property(dev->of_node, "ti,edma-memcpy-channels", &sz);
+	if (prop) {
+		const char pname[] = "ti,edma-memcpy-channels";
+		size_t nelm = sz / sizeof(s16);
+		s16 *memcpy_ch;
+
+		memcpy_ch = devm_kcalloc(dev, nelm + 1, sizeof(s16),
+					 GFP_KERNEL);
+		if (!memcpy_ch)
+			return ERR_PTR(-ENOMEM);
+
+		ret = of_property_read_u16_array(dev->of_node, pname,
+						 (u16 *)memcpy_ch, nelm);
+		if (ret)
+			return ERR_PTR(ret);
+
+		memcpy_ch[nelm] = -1;
+		info->memcpy_channels = memcpy_ch;
+	}
+
+	prop = of_find_property(dev->of_node, "ti,edma-reserved-slot-ranges",
+				&sz);
 	if (prop) {
-		ret = edma_xbar_event_map(dev, info, sz);
+		const char pname[] = "ti,edma-reserved-slot-ranges";
+		s16 (*rsv_slots)[2];
+		size_t nelm = sz / sizeof(*rsv_slots);
+		struct edma_rsv_info *rsv_info;
+
+		if (!nelm)
+			return info;
+
+		rsv_info = devm_kzalloc(dev, sizeof(*rsv_info), GFP_KERNEL);
+		if (!rsv_info)
+			return ERR_PTR(-ENOMEM);
+
+		rsv_slots = devm_kcalloc(dev, nelm + 1, sizeof(*rsv_slots),
+					 GFP_KERNEL);
+		if (!rsv_slots)
+			return ERR_PTR(-ENOMEM);
+
+		ret = of_property_read_u16_array(dev->of_node, pname,
+						 (u16 *)rsv_slots, nelm * 2);
 		if (ret)
 			return ERR_PTR(ret);
+
+		rsv_slots[nelm][0] = -1;
+		rsv_slots[nelm][1] = -1;
+		info->rsv = rsv_info;
+		info->rsv->rsv_slots = (const s16 (*)[2])rsv_slots;
 	}
 
 	return info;
 }
+
+static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
+				      struct of_dma *ofdma)
+{
+	struct edma_cc *ecc = ofdma->of_dma_data;
+	struct dma_chan *chan = NULL;
+	struct edma_chan *echan;
+	int i;
+
+	if (!ecc || dma_spec->args_count < 1)
+		return NULL;
+
+	for (i = 0; i < ecc->num_channels; i++) {
+		echan = &ecc->slave_chans[i];
+		if (echan->ch_num == dma_spec->args[0]) {
+			chan = &echan->vchan.chan;
+			break;
+		}
+	}
+
+	if (!chan)
+		return NULL;
+
+	if (echan->ecc->legacy_mode && dma_spec->args_count == 1)
+		goto out;
+
+	if (!echan->ecc->legacy_mode && dma_spec->args_count == 2 &&
+	    dma_spec->args[1] < echan->ecc->num_tc) {
+		echan->tc = &echan->ecc->tc_list[dma_spec->args[1]];
+		goto out;
+	}
+
+	return NULL;
+out:
+	/* The channel is going to be used as HW synchronized */
+	echan->hw_triggered = true;
+	return dma_get_slave_channel(chan);
+}
 #else
-static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev)
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
+						     bool legacy_mode)
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
+				      struct of_dma *ofdma)
+{
+	return NULL;
+}
 #endif
 
 static int edma_probe(struct platform_device *pdev)
@@ -1953,7 +2098,6 @@ static int edma_probe(struct platform_device *pdev)
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
 	int			i, off, ln;
-	const s16		(*rsv_chans)[2];
 	const s16		(*rsv_slots)[2];
 	const s16		(*xbar_chans)[2];
 	int			irq;
@@ -1962,10 +2106,17 @@ static int edma_probe(struct platform_device *pdev)
 	struct device_node	*node = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 	struct edma_cc		*ecc;
+	bool			legacy_mode = true;
 	int ret;
 
 	if (node) {
-		info = edma_setup_info_from_dt(dev);
+		const struct of_device_id *match;
+
+		match = of_match_node(edma_of_ids, node);
+		if (match && (u32)match->data == EDMA_BINDING_TPCC)
+			legacy_mode = false;
+
+		info = edma_setup_info_from_dt(dev, legacy_mode);
 		if (IS_ERR(info)) {
 			dev_err(dev, "failed to get DT data\n");
 			return PTR_ERR(info);
@@ -1994,6 +2145,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	ecc->dev = dev;
 	ecc->id = pdev->id;
+	ecc->legacy_mode = legacy_mode;
 	/* When booting with DT the pdev->id is -1 */
 	if (ecc->id < 0)
 		ecc->id = 0;
@@ -2024,12 +2176,6 @@ static int edma_probe(struct platform_device *pdev)
 	if (!ecc->slave_chans)
 		return -ENOMEM;
 
-	ecc->channel_unused = devm_kcalloc(dev,
-					   BITS_TO_LONGS(ecc->num_channels),
-					   sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->channel_unused)
-		return -ENOMEM;
-
 	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
 				       sizeof(unsigned long), GFP_KERNEL);
 	if (!ecc->slot_inuse)
@@ -2040,20 +2186,7 @@ static int edma_probe(struct platform_device *pdev)
 	for (i = 0; i < ecc->num_slots; i++)
 		edma_write_slot(ecc, i, &dummy_paramset);
 
-	/* Mark all channels as unused */
-	memset(ecc->channel_unused, 0xff, sizeof(ecc->channel_unused));
-
 	if (info->rsv) {
-		/* Clear the reserved channels in unused list */
-		rsv_chans = info->rsv->rsv_chans;
-		if (rsv_chans) {
-			for (i = 0; rsv_chans[i][0] != -1; i++) {
-				off = rsv_chans[i][0];
-				ln = rsv_chans[i][1];
-				clear_bits(off, ln, ecc->channel_unused);
-			}
-		}
-
 		/* Set the reserved slots in inuse list */
 		rsv_slots = info->rsv->rsv_slots;
 		if (rsv_slots) {
@@ -2070,7 +2203,6 @@ static int edma_probe(struct platform_device *pdev)
 	if (xbar_chans) {
 		for (i = 0; xbar_chans[i][1] != -1; i++) {
 			off = xbar_chans[i][1];
-			clear_bits(off, 1, ecc->channel_unused);
 		}
 	}
 
@@ -2112,6 +2244,31 @@ static int edma_probe(struct platform_device *pdev)
 
 	queue_priority_mapping = info->queue_priority_mapping;
 
+	if (!ecc->legacy_mode) {
+		int lowest_priority = 0;
+		struct of_phandle_args tc_args;
+
+		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
+					    sizeof(*ecc->tc_list), GFP_KERNEL);
+		if (!ecc->tc_list)
+			return -ENOMEM;
+
+		for (i = 0;; i++) {
+			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
+							       1, i, &tc_args);
+			if (ret || i == ecc->num_tc)
+				break;
+
+			ecc->tc_list[i].node = tc_args.np;
+			ecc->tc_list[i].id = i;
+			queue_priority_mapping[i][1] = tc_args.args[0];
+			if (queue_priority_mapping[i][1] > lowest_priority) {
+				lowest_priority = queue_priority_mapping[i][1];
+				info->default_queue = i;
+			}
+		}
+	}
+
 	/* Event queue priority mapping */
 	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
 		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
@@ -2125,7 +2282,7 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->info = info;
 
 	/* Init the dma device and channels */
-	edma_dma_init(ecc);
+	edma_dma_init(ecc, legacy_mode);
 
 	for (i = 0; i < ecc->num_channels; i++) {
 		/* Assign all channels to the default queue */
@@ -2136,12 +2293,23 @@ static int edma_probe(struct platform_device *pdev)
 	}
 
 	ret = dma_async_device_register(&ecc->dma_slave);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
 		goto err_reg1;
+	}
+
+	if (ecc->dma_memcpy) {
+		ret = dma_async_device_register(ecc->dma_memcpy);
+		if (ret) {
+			dev_err(dev, "memcpy ddev registration failed (%d)\n",
+				ret);
+			dma_async_device_unregister(&ecc->dma_slave);
+			goto err_reg1;
+		}
+	}
 
 	if (node)
-		of_dma_controller_register(node, of_dma_xlate_by_chan_id,
-					   &ecc->dma_slave);
+		of_dma_controller_register(node, of_edma_xlate, ecc);
 
 	dev_info(dev, "TI EDMA DMA engine driver\n");
 
@@ -2160,12 +2328,30 @@ static int edma_remove(struct platform_device *pdev)
 	if (dev->of_node)
 		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&ecc->dma_slave);
+	if (ecc->dma_memcpy)
+		dma_async_device_unregister(ecc->dma_memcpy);
 	edma_free_slot(ecc, ecc->dummy_slot);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int edma_pm_suspend(struct device *dev)
+{
+	struct edma_cc *ecc = dev_get_drvdata(dev);
+	struct edma_chan *echan = ecc->slave_chans;
+	int i;
+
+	for (i = 0; i < ecc->num_channels; i++) {
+		if (echan[i].alloced) {
+			edma_setup_interrupt(&echan[i], false);
+			edma_tc_set_pm_state(echan[i].tc, false);
+		}
+	}
+
+	return 0;
+}
+
 static int edma_pm_resume(struct device *dev)
 {
 	struct edma_cc *ecc = dev_get_drvdata(dev);
@@ -2190,6 +2376,8 @@ static int edma_pm_resume(struct device *dev)
 
 			/* Set up channel -> slot mapping for the entry slot */
 			edma_set_chmap(&echan[i], echan[i].slot[0]);
+
+			edma_tc_set_pm_state(echan[i].tc, true);
 		}
 	}
 
@@ -2198,7 +2386,7 @@ static int edma_pm_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops edma_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, edma_pm_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(edma_pm_suspend, edma_pm_resume)
 };
 
 static struct platform_driver edma_driver = {
@@ -2213,12 +2401,18 @@ static struct platform_driver edma_driver = {
 
 bool edma_filter_fn(struct dma_chan *chan, void *param)
 {
+	bool match = false;
+
 	if (chan->device->dev->driver == &edma_driver.driver) {
 		struct edma_chan *echan = to_edma_chan(chan);
 		unsigned ch_req = *(unsigned *)param;
-		return ch_req == echan->ch_num;
+		if (ch_req == echan->ch_num) {
+			/* The channel is going to be used as HW synchronized */
+			echan->hw_triggered = true;
+			match = true;
+		}
 	}
-	return false;
+	return match;
 }
 EXPORT_SYMBOL(edma_filter_fn);
 
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 6b9d500956e4..e2878baeb90e 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -71,6 +71,9 @@ struct edma_soc_info {
 	/* Resource reservation for other cores */
 	struct edma_rsv_info	*rsv;
 
+	/* List of channels allocated for memcpy, terminated with -1 */
+	s16			*memcpy_channels;
+
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
 };
-- 
2.6.1
