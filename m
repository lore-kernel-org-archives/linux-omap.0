From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/21] ARM: davinci/common: Convert edma driver to handle one
 eDMA instance per driver
Date: Thu, 10 Sep 2015 11:37:33 +0300
Message-ID: <1441874270-2399-5-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently we have one device created to handle all (maximum 2) eDMAs in the
system.
With this change all eDMA instance will have it's own device/driver.
This change is needed for further cleanups in the eDMA driver stack since
the one device/driver to handle all eDMAs in the system was not flexible
enough and prevents the upcoming work.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c                | 357 +++++++++++++++-------------------
 arch/arm/mach-davinci/devices-da8xx.c | 110 ++++-------
 arch/arm/mach-davinci/dm355.c         |  21 +-
 arch/arm/mach-davinci/dm365.c         |  25 +--
 arch/arm/mach-davinci/dm644x.c        |  21 +-
 arch/arm/mach-davinci/dm646x.c        |  27 ++-
 6 files changed, 235 insertions(+), 326 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index e9c4cb16a47e..72fce68a959f 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -235,6 +235,7 @@ static inline void clear_bits(int offset, int len, unsigned long *p)
 
 /* actual number of DMA channels and slots on this silicon */
 struct edma {
+	struct device	*dev;
 	/* how many dma resources of each type */
 	unsigned	num_channels;
 	unsigned	num_region;
@@ -246,6 +247,7 @@ struct edma {
 	const s8	*noevent;
 
 	struct edma_soc_info *info;
+	int		id;
 
 	/* The edma_inuse bit for each PaRAM slot is clear unless the
 	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
@@ -258,9 +260,6 @@ struct edma {
 	 */
 	DECLARE_BITMAP(edma_unused, EDMA_MAX_DMACH);
 
-	unsigned	irq_res_start;
-	unsigned	irq_res_end;
-
 	struct dma_interrupt_data {
 		void (*callback)(unsigned channel, unsigned short ch_status,
 				void *data);
@@ -349,17 +348,6 @@ setup_dma_interrupt(unsigned lch,
 	}
 }
 
-static int irq2ctlr(int irq)
-{
-	if (irq >= edma_cc[0]->irq_res_start && irq <= edma_cc[0]->irq_res_end)
-		return 0;
-	else if (irq >= edma_cc[1]->irq_res_start &&
-		irq <= edma_cc[1]->irq_res_end)
-		return 1;
-
-	return -1;
-}
-
 /******************************************************************************
  *
  * DMA interrupt handler
@@ -367,16 +355,17 @@ static int irq2ctlr(int irq)
  *****************************************************************************/
 static irqreturn_t dma_irq_handler(int irq, void *data)
 {
+	struct edma *cc = data;
 	int ctlr;
 	u32 sh_ier;
 	u32 sh_ipr;
 	u32 bank;
 
-	ctlr = irq2ctlr(irq);
+	ctlr = cc->id;
 	if (ctlr < 0)
 		return IRQ_NONE;
 
-	dev_dbg(data, "dma_irq_handler\n");
+	dev_dbg(cc->dev, "dma_irq_handler\n");
 
 	sh_ipr = edma_shadow0_read_array(ctlr, SH_IPR, 0);
 	if (!sh_ipr) {
@@ -394,7 +383,7 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 		u32 slot;
 		u32 channel;
 
-		dev_dbg(data, "IPR%d %08x\n", bank, sh_ipr);
+		dev_dbg(cc->dev, "IPR%d %08x\n", bank, sh_ipr);
 
 		slot = __ffs(sh_ipr);
 		sh_ipr &= ~(BIT(slot));
@@ -404,11 +393,11 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 			/* Clear the corresponding IPR bits */
 			edma_shadow0_write_array(ctlr, SH_ICR, bank,
 					BIT(slot));
-			if (edma_cc[ctlr]->intr_data[channel].callback)
-				edma_cc[ctlr]->intr_data[channel].callback(
+			if (cc->intr_data[channel].callback)
+				cc->intr_data[channel].callback(
 					EDMA_CTLR_CHAN(ctlr, channel),
 					EDMA_DMA_COMPLETE,
-					edma_cc[ctlr]->intr_data[channel].data);
+					cc->intr_data[channel].data);
 		}
 	} while (sh_ipr);
 
@@ -423,15 +412,16 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
  *****************************************************************************/
 static irqreturn_t dma_ccerr_handler(int irq, void *data)
 {
+	struct edma *cc = data;
 	int i;
 	int ctlr;
 	unsigned int cnt = 0;
 
-	ctlr = irq2ctlr(irq);
+	ctlr = cc->id;
 	if (ctlr < 0)
 		return IRQ_NONE;
 
-	dev_dbg(data, "dma_ccerr_handler\n");
+	dev_dbg(cc->dev, "dma_ccerr_handler\n");
 
 	if ((edma_read_array(ctlr, EDMA_EMR, 0) == 0) &&
 	    (edma_read_array(ctlr, EDMA_EMR, 1) == 0) &&
@@ -446,8 +436,8 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 		else if (edma_read_array(ctlr, EDMA_EMR, 1))
 			j = 1;
 		if (j >= 0) {
-			dev_dbg(data, "EMR%d %08x\n", j,
-					edma_read_array(ctlr, EDMA_EMR, j));
+			dev_dbg(cc->dev, "EMR%d %08x\n", j,
+				edma_read_array(ctlr, EDMA_EMR, j));
 			for (i = 0; i < 32; i++) {
 				int k = (j << 5) + i;
 				if (edma_read_array(ctlr, EDMA_EMR, j) &
@@ -458,19 +448,16 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 					/* Clear any SER */
 					edma_shadow0_write_array(ctlr, SH_SECR,
 								j, BIT(i));
-					if (edma_cc[ctlr]->intr_data[k].
-								callback) {
-						edma_cc[ctlr]->intr_data[k].
-						callback(
-						EDMA_CTLR_CHAN(ctlr, k),
-						EDMA_DMA_CC_ERROR,
-						edma_cc[ctlr]->intr_data
-						[k].data);
+					if (cc->intr_data[k].callback) {
+						cc->intr_data[k].callback(
+							EDMA_CTLR_CHAN(ctlr, k),
+							EDMA_DMA_CC_ERROR,
+							cc->intr_data[k].data);
 					}
 				}
 			}
 		} else if (edma_read(ctlr, EDMA_QEMR)) {
-			dev_dbg(data, "QEMR %02x\n",
+			dev_dbg(cc->dev, "QEMR %02x\n",
 				edma_read(ctlr, EDMA_QEMR));
 			for (i = 0; i < 8; i++) {
 				if (edma_read(ctlr, EDMA_QEMR) & BIT(i)) {
@@ -483,7 +470,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 				}
 			}
 		} else if (edma_read(ctlr, EDMA_CCERR)) {
-			dev_dbg(data, "CCERR %08x\n",
+			dev_dbg(cc->dev, "CCERR %08x\n",
 				edma_read(ctlr, EDMA_CCERR));
 			/* FIXME:  CCERR.BIT(16) ignored!  much better
 			 * to just write CCERRCLR with CCERR value...
@@ -1239,21 +1226,19 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 
 static int edma_probe(struct platform_device *pdev)
 {
-	struct edma_soc_info	**info = pdev->dev.platform_data;
-	struct edma_soc_info    *ninfo[EDMA_MAX_CC] = {NULL};
+	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8		(*queue_priority_mapping)[2];
-	int			i, j, off, ln, found = 0;
-	int			status = -1;
+	int			i, off, ln;
 	const s16		(*rsv_chans)[2];
 	const s16		(*rsv_slots)[2];
 	const s16		(*xbar_chans)[2];
-	int			irq[EDMA_MAX_CC] = {0, 0};
-	int			err_irq[EDMA_MAX_CC] = {0, 0};
-	struct resource		*r[EDMA_MAX_CC] = {NULL};
-	struct resource		res[EDMA_MAX_CC];
-	char			res_name[10];
+	int			irq;
+	char			*irq_name;
+	struct resource		*mem;
 	struct device_node	*node = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
+	int			dev_id = pdev->id;
+	struct edma		*cc;
 	int			ret;
 	struct platform_device_info edma_dev_info = {
 		.name = "edma-dma-engine",
@@ -1261,6 +1246,17 @@ static int edma_probe(struct platform_device *pdev)
 		.parent = &pdev->dev,
 	};
 
+	/* When booting with DT the pdev->id is -1 */
+	if (dev_id < 0)
+		dev_id = arch_num_cc;
+
+	if (dev_id >= EDMA_MAX_CC) {
+		dev_err(dev,
+			"eDMA3 with device id 0 and 1 is supported (id: %d)\n",
+			dev_id);
+		return -EINVAL;
+	}
+
 	if (node) {
 		/* Check if this is a second instance registered */
 		if (arch_num_cc) {
@@ -1268,13 +1264,11 @@ static int edma_probe(struct platform_device *pdev)
 			return -ENODEV;
 		}
 
-		ninfo[0] = edma_setup_info_from_dt(dev, node);
-		if (IS_ERR(ninfo[0])) {
+		info = edma_setup_info_from_dt(dev, node);
+		if (IS_ERR(info)) {
 			dev_err(dev, "failed to get DT data\n");
-			return PTR_ERR(ninfo[0]);
+			return PTR_ERR(info);
 		}
-
-		info = ninfo;
 	}
 
 	if (!info)
@@ -1287,154 +1281,133 @@ static int edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	for (j = 0; j < EDMA_MAX_CC; j++) {
-		if (!info[j]) {
-			if (!found)
-				return -ENODEV;
-			break;
-		}
-		if (node) {
-			ret = of_address_to_resource(node, j, &res[j]);
-			if (!ret)
-				r[j] = &res[j];
-		} else {
-			sprintf(res_name, "edma_cc%d", j);
-			r[j] = platform_get_resource_byname(pdev,
-						IORESOURCE_MEM,
-						res_name);
-		}
-		if (!r[j]) {
-			if (found)
-				break;
-			else
-				return -ENODEV;
-		} else {
-			found = 1;
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "edma3_cc");
+	if (!mem) {
+		dev_dbg(dev, "mem resource not found, using index 0\n");
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!mem) {
+			dev_err(dev, "no mem resource?\n");
+			return -ENODEV;
 		}
+	}
 
-		edmacc_regs_base[j] = devm_ioremap_resource(&pdev->dev, r[j]);
-		if (IS_ERR(edmacc_regs_base[j]))
-			return PTR_ERR(edmacc_regs_base[j]);
+	edmacc_regs_base[dev_id] = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(edmacc_regs_base[dev_id]))
+		return PTR_ERR(edmacc_regs_base[dev_id]);
 
-		edma_cc[j] = devm_kzalloc(&pdev->dev, sizeof(struct edma),
-					  GFP_KERNEL);
-		if (!edma_cc[j])
-			return -ENOMEM;
+	edma_cc[dev_id] = devm_kzalloc(dev, sizeof(struct edma), GFP_KERNEL);
+	if (!edma_cc[dev_id])
+		return -ENOMEM;
 
-		/* Get eDMA3 configuration from IP */
-		ret = edma_setup_from_hw(dev, info[j], edma_cc[j], j);
-		if (ret)
-			return ret;
+	cc = edma_cc[dev_id];
+	cc->dev = dev;
+	cc->id = dev_id;
+	dev_set_drvdata(dev, cc);
 
-		edma_cc[j]->default_queue = info[j]->default_queue;
+	/* Get eDMA3 configuration from IP */
+	ret = edma_setup_from_hw(dev, info, cc, dev_id);
+	if (ret)
+		return ret;
 
-		dev_dbg(&pdev->dev, "DMA REG BASE ADDR=%p\n",
-			edmacc_regs_base[j]);
+	cc->default_queue = info->default_queue;
 
-		for (i = 0; i < edma_cc[j]->num_slots; i++)
-			memcpy_toio(edmacc_regs_base[j] + PARM_OFFSET(i),
-					&dummy_paramset, PARM_SIZE);
+	dev_dbg(dev, "DMA REG BASE ADDR=%p\n", edmacc_regs_base[dev_id]);
 
-		/* Mark all channels as unused */
-		memset(edma_cc[j]->edma_unused, 0xff,
-			sizeof(edma_cc[j]->edma_unused));
+	for (i = 0; i < cc->num_slots; i++)
+		memcpy_toio(edmacc_regs_base[dev_id] + PARM_OFFSET(i),
+			    &dummy_paramset, PARM_SIZE);
 
-		if (info[j]->rsv) {
+	/* Mark all channels as unused */
+	memset(cc->edma_unused, 0xff, sizeof(cc->edma_unused));
 
-			/* Clear the reserved channels in unused list */
-			rsv_chans = info[j]->rsv->rsv_chans;
-			if (rsv_chans) {
-				for (i = 0; rsv_chans[i][0] != -1; i++) {
-					off = rsv_chans[i][0];
-					ln = rsv_chans[i][1];
-					clear_bits(off, ln,
-						  edma_cc[j]->edma_unused);
-				}
-			}
+	if (info->rsv) {
 
-			/* Set the reserved slots in inuse list */
-			rsv_slots = info[j]->rsv->rsv_slots;
-			if (rsv_slots) {
-				for (i = 0; rsv_slots[i][0] != -1; i++) {
-					off = rsv_slots[i][0];
-					ln = rsv_slots[i][1];
-					set_bits(off, ln,
-						edma_cc[j]->edma_inuse);
-				}
+		/* Clear the reserved channels in unused list */
+		rsv_chans = info->rsv->rsv_chans;
+		if (rsv_chans) {
+			for (i = 0; rsv_chans[i][0] != -1; i++) {
+				off = rsv_chans[i][0];
+				ln = rsv_chans[i][1];
+				clear_bits(off, ln, cc->edma_unused);
 			}
 		}
 
-		/* Clear the xbar mapped channels in unused list */
-		xbar_chans = info[j]->xbar_chans;
-		if (xbar_chans) {
-			for (i = 0; xbar_chans[i][1] != -1; i++) {
-				off = xbar_chans[i][1];
-				clear_bits(off, 1,
-					   edma_cc[j]->edma_unused);
+		/* Set the reserved slots in inuse list */
+		rsv_slots = info->rsv->rsv_slots;
+		if (rsv_slots) {
+			for (i = 0; rsv_slots[i][0] != -1; i++) {
+				off = rsv_slots[i][0];
+				ln = rsv_slots[i][1];
+				set_bits(off, ln, cc->edma_inuse);
 			}
 		}
+	}
 
-		if (node) {
-			irq[j] = irq_of_parse_and_map(node, 0);
-			err_irq[j] = irq_of_parse_and_map(node, 2);
-		} else {
-			char irq_name[10];
-
-			sprintf(irq_name, "edma%d", j);
-			irq[j] = platform_get_irq_byname(pdev, irq_name);
-
-			sprintf(irq_name, "edma%d_err", j);
-			err_irq[j] = platform_get_irq_byname(pdev, irq_name);
-		}
-		edma_cc[j]->irq_res_start = irq[j];
-		edma_cc[j]->irq_res_end = err_irq[j];
-
-		status = devm_request_irq(dev, irq[j], dma_irq_handler, 0,
-					  "edma", dev);
-		if (status < 0) {
-			dev_dbg(&pdev->dev,
-				"devm_request_irq %d failed --> %d\n",
-				irq[j], status);
-			return status;
+	/* Clear the xbar mapped channels in unused list */
+	xbar_chans = info->xbar_chans;
+	if (xbar_chans) {
+		for (i = 0; xbar_chans[i][1] != -1; i++) {
+			off = xbar_chans[i][1];
+			clear_bits(off, 1, cc->edma_unused);
 		}
+	}
 
-		status = devm_request_irq(dev, err_irq[j], dma_ccerr_handler, 0,
-					  "edma_error", dev);
-		if (status < 0) {
-			dev_dbg(&pdev->dev,
-				"devm_request_irq %d failed --> %d\n",
-				err_irq[j], status);
-			return status;
+	irq = platform_get_irq_byname(pdev, "edma3_ccint");
+	if (irq < 0 && node)
+		irq = irq_of_parse_and_map(node, 0);
+
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint\n",
+					  dev_name(dev));
+		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
+				       cc);
+		if (ret) {
+			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
+			return ret;
 		}
+	}
 
-		for (i = 0; i < edma_cc[j]->num_channels; i++)
-			map_dmach_queue(j, i, info[j]->default_queue);
+	irq = platform_get_irq_byname(pdev, "edma3_ccerrint");
+	if (irq < 0 && node)
+		irq = irq_of_parse_and_map(node, 2);
+
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(dev, GFP_KERNEL,
+					  "%s_ccerrint\n",
+					  dev_name(dev));
+		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
+				       cc);
+		if (ret) {
+			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
+			return ret;
+		}
+	}
 
-		queue_priority_mapping = info[j]->queue_priority_mapping;
+	for (i = 0; i < cc->num_channels; i++)
+		map_dmach_queue(dev_id, i, info->default_queue);
 
-		/* Event queue priority mapping */
-		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
-			assign_priority_to_queue(j,
-						queue_priority_mapping[i][0],
-						queue_priority_mapping[i][1]);
+	queue_priority_mapping = info->queue_priority_mapping;
 
-		/* Map the channel to param entry if channel mapping logic
-		 * exist
-		 */
-		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
-			map_dmach_param(j);
+	/* Event queue priority mapping */
+	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+		assign_priority_to_queue(dev_id, queue_priority_mapping[i][0],
+					 queue_priority_mapping[i][1]);
 
-		for (i = 0; i < edma_cc[j]->num_region; i++) {
-			edma_write_array2(j, EDMA_DRAE, i, 0, 0x0);
-			edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
-			edma_write_array(j, EDMA_QRAE, i, 0x0);
-		}
-		edma_cc[j]->info = info[j];
-		arch_num_cc++;
+	/* Map the channel to param entry if channel mapping logic exist */
+	if (edma_read(dev_id, EDMA_CCCFG) & CHMAP_EXIST)
+		map_dmach_param(dev_id);
 
-		edma_dev_info.id = j;
-		platform_device_register_full(&edma_dev_info);
+	for (i = 0; i < cc->num_region; i++) {
+		edma_write_array2(dev_id, EDMA_DRAE, i, 0, 0x0);
+		edma_write_array2(dev_id, EDMA_DRAE, i, 1, 0x0);
+		edma_write_array(dev_id, EDMA_QRAE, i, 0x0);
 	}
+	cc->info = info;
+	arch_num_cc++;
+
+	edma_dev_info.id = dev_id;
+
+	platform_device_register_full(&edma_dev_info);
 
 	return 0;
 }
@@ -1442,38 +1415,30 @@ static int edma_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int edma_pm_resume(struct device *dev)
 {
-	int i, j;
+	struct edma *cc = dev_get_drvdata(dev);
+	int i;
+	s8 (*queue_priority_mapping)[2];
 
-	for (j = 0; j < arch_num_cc; j++) {
-		struct edma *cc = edma_cc[j];
+	queue_priority_mapping = cc->info->queue_priority_mapping;
 
-		s8 (*queue_priority_mapping)[2];
+	/* Event queue priority mapping */
+	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+		assign_priority_to_queue(cc->id, queue_priority_mapping[i][0],
+					 queue_priority_mapping[i][1]);
 
-		queue_priority_mapping = cc->info->queue_priority_mapping;
+	/* Map the channel to param entry if channel mapping logic */
+	if (edma_read(cc->id, EDMA_CCCFG) & CHMAP_EXIST)
+		map_dmach_param(cc->id);
 
-		/* Event queue priority mapping */
-		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
-			assign_priority_to_queue(j,
-						 queue_priority_mapping[i][0],
-						 queue_priority_mapping[i][1]);
+	for (i = 0; i < cc->num_channels; i++) {
+		if (test_bit(i, cc->edma_inuse)) {
+			/* ensure access through shadow region 0 */
+			edma_or_array2(cc->id, EDMA_DRAE, 0, i >> 5,
+				       BIT(i & 0x1f));
 
-		/*
-		 * Map the channel to param entry if channel mapping logic
-		 * exist
-		 */
-		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
-			map_dmach_param(j);
-
-		for (i = 0; i < cc->num_channels; i++) {
-			if (test_bit(i, cc->edma_inuse)) {
-				/* ensure access through shadow region 0 */
-				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
-					       BIT(i & 0x1f));
-
-				setup_dma_interrupt(i,
-						    cc->intr_data[i].callback,
-						    cc->intr_data[i].data);
-			}
+			setup_dma_interrupt(EDMA_CTLR_CHAN(cc->id, i),
+					    cc->intr_data[i].callback,
+					    cc->intr_data[i].data);
 		}
 	}
 
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 29e08aac8294..9ae049ae816a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -147,150 +147,114 @@ static s8 da850_queue_priority_mapping[][2] = {
 	{-1, -1}
 };
 
-static struct edma_soc_info da830_edma_cc0_info = {
+static struct edma_soc_info da8xx_edma0_pdata = {
 	.queue_priority_mapping	= da8xx_queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
 };
 
-static struct edma_soc_info *da830_edma_info[EDMA_MAX_CC] = {
-	&da830_edma_cc0_info,
+static struct edma_soc_info da850_edma1_pdata = {
+	.queue_priority_mapping	= da850_queue_priority_mapping,
+	.default_queue		= EVENTQ_0,
 };
 
-static struct edma_soc_info da850_edma_cc_info[] = {
+static struct resource da8xx_edma0_resources[] = {
 	{
-		.queue_priority_mapping	= da8xx_queue_priority_mapping,
-		.default_queue		= EVENTQ_1,
-	},
-	{
-		.queue_priority_mapping	= da850_queue_priority_mapping,
-		.default_queue		= EVENTQ_0,
-	},
-};
-
-static struct edma_soc_info *da850_edma_info[EDMA_MAX_CC] = {
-	&da850_edma_cc_info[0],
-	&da850_edma_cc_info[1],
-};
-
-static struct resource da830_edma_resources[] = {
-	{
-		.name	= "edma_cc0",
+		.name	= "edma3_cc",
 		.start	= DA8XX_TPCC_BASE,
 		.end	= DA8XX_TPCC_BASE + SZ_32K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc0",
+		.name	= "edma3_tc0",
 		.start	= DA8XX_TPTC0_BASE,
 		.end	= DA8XX_TPTC0_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc1",
+		.name	= "edma3_tc1",
 		.start	= DA8XX_TPTC1_BASE,
 		.end	= DA8XX_TPTC1_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma0",
+		.name	= "edma3_ccint",
 		.start	= IRQ_DA8XX_CCINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.name	= "edma0_err",
+		.name	= "edma3_ccerrint",
 		.start	= IRQ_DA8XX_CCERRINT,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
-static struct resource da850_edma_resources[] = {
-	{
-		.name	= "edma_cc0",
-		.start	= DA8XX_TPCC_BASE,
-		.end	= DA8XX_TPCC_BASE + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma_tc0",
-		.start	= DA8XX_TPTC0_BASE,
-		.end	= DA8XX_TPTC0_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+static struct resource da850_edma1_resources[] = {
 	{
-		.name	= "edma_tc1",
-		.start	= DA8XX_TPTC1_BASE,
-		.end	= DA8XX_TPTC1_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma_cc1",
+		.name	= "edma3_cc",
 		.start	= DA850_TPCC1_BASE,
 		.end	= DA850_TPCC1_BASE + SZ_32K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc2",
+		.name	= "edma3_tc0",
 		.start	= DA850_TPTC2_BASE,
 		.end	= DA850_TPTC2_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma0",
-		.start	= IRQ_DA8XX_CCINT0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "edma0_err",
-		.start	= IRQ_DA8XX_CCERRINT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "edma1",
+		.name	= "edma3_ccint",
 		.start	= IRQ_DA850_CCINT1,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.name	= "edma1_err",
+		.name	= "edma3_ccerrint",
 		.start	= IRQ_DA850_CCERRINT1,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
-static struct platform_device da830_edma_device = {
+static struct platform_device da8xx_edma0_device = {
 	.name		= "edma",
-	.id		= -1,
+	.id		= 0,
 	.dev = {
-		.platform_data = da830_edma_info,
+		.platform_data = &da8xx_edma0_pdata,
 	},
-	.num_resources	= ARRAY_SIZE(da830_edma_resources),
-	.resource	= da830_edma_resources,
+	.num_resources	= ARRAY_SIZE(da8xx_edma0_resources),
+	.resource	= da8xx_edma0_resources,
 };
 
-static struct platform_device da850_edma_device = {
+static struct platform_device da850_edma1_device = {
 	.name		= "edma",
-	.id		= -1,
+	.id		= 1,
 	.dev = {
-		.platform_data = da850_edma_info,
+		.platform_data = &da850_edma1_pdata,
 	},
-	.num_resources	= ARRAY_SIZE(da850_edma_resources),
-	.resource	= da850_edma_resources,
+	.num_resources	= ARRAY_SIZE(da850_edma1_resources),
+	.resource	= da850_edma1_resources,
 };
 
 int __init da830_register_edma(struct edma_rsv_info *rsv)
 {
-	da830_edma_cc0_info.rsv = rsv;
+	da8xx_edma0_pdata.rsv = rsv;
 
-	return platform_device_register(&da830_edma_device);
+	return platform_device_register(&da8xx_edma0_device);
 }
 
 int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 {
+	int ret;
+
 	if (rsv) {
-		da850_edma_cc_info[0].rsv = rsv[0];
-		da850_edma_cc_info[1].rsv = rsv[1];
+		da8xx_edma0_pdata.rsv = rsv[0];
+		da850_edma1_pdata.rsv = rsv[1];
 	}
 
-	return platform_device_register(&da850_edma_device);
+	ret = platform_device_register(&da8xx_edma0_device);
+	if (ret) {
+		pr_warn("%s: Failed to register eDMA0\n", __func__);
+		return ret;
+	}
+	return platform_device_register(&da850_edma1_device);
 }
 
 static struct resource da8xx_i2c_resources0[] = {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 567dc56fe8cd..a50bb9c66952 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -569,49 +569,44 @@ static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static s8
-queue_priority_mapping[][2] = {
+static s8 queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
 	{1, 7},
 	{-1, -1},
 };
 
-static struct edma_soc_info edma_cc0_info = {
+static struct edma_soc_info dm355_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
 };
 
-static struct edma_soc_info *dm355_edma_info[EDMA_MAX_CC] = {
-       &edma_cc0_info,
-};
-
 static struct resource edma_resources[] = {
 	{
-		.name	= "edma_cc0",
+		.name	= "edma3_cc",
 		.start	= 0x01c00000,
 		.end	= 0x01c00000 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc0",
+		.name	= "edma3_tc0",
 		.start	= 0x01c10000,
 		.end	= 0x01c10000 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc1",
+		.name	= "edma3_tc1",
 		.start	= 0x01c10400,
 		.end	= 0x01c10400 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma0",
+		.name	= "edma3_ccint",
 		.start	= IRQ_CCINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.name	= "edma0_err",
+		.name	= "edma3_ccerrint",
 		.start	= IRQ_CCERRINT,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -621,7 +616,7 @@ static struct resource edma_resources[] = {
 static struct platform_device dm355_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= dm355_edma_info,
+	.dev.platform_data	= &dm355_edma_pdata,
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6a890a8486d0..2068cbeaeb03 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -853,8 +853,7 @@ static u8 dm365_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 };
 
 /* Four Transfer Controllers on DM365 */
-static s8
-dm365_queue_priority_mapping[][2] = {
+static s8 dm365_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 7},
 	{1, 7},
@@ -863,53 +862,49 @@ dm365_queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
-static struct edma_soc_info edma_cc0_info = {
+static struct edma_soc_info dm365_edma_pdata = {
 	.queue_priority_mapping	= dm365_queue_priority_mapping,
 	.default_queue		= EVENTQ_3,
 };
 
-static struct edma_soc_info *dm365_edma_info[EDMA_MAX_CC] = {
-	&edma_cc0_info,
-};
-
 static struct resource edma_resources[] = {
 	{
-		.name	= "edma_cc0",
+		.name	= "edma3_cc",
 		.start	= 0x01c00000,
 		.end	= 0x01c00000 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc0",
+		.name	= "edma3_tc0",
 		.start	= 0x01c10000,
 		.end	= 0x01c10000 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc1",
+		.name	= "edma3_tc1",
 		.start	= 0x01c10400,
 		.end	= 0x01c10400 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc2",
+		.name	= "edma3_tc2",
 		.start	= 0x01c10800,
 		.end	= 0x01c10800 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc3",
+		.name	= "edma3_tc3",
 		.start	= 0x01c10c00,
 		.end	= 0x01c10c00 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma0",
+		.name	= "edma3_ccint",
 		.start	= IRQ_CCINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.name	= "edma0_err",
+		.name	= "edma3_ccerrint",
 		.start	= IRQ_CCERRINT,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -919,7 +914,7 @@ static struct resource edma_resources[] = {
 static struct platform_device dm365_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= dm365_edma_info,
+	.dev.platform_data	= &dm365_edma_pdata,
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index dc52657909c4..d759ca8e58e8 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -498,49 +498,44 @@ static u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static s8
-queue_priority_mapping[][2] = {
+static s8 queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
 	{1, 7},
 	{-1, -1},
 };
 
-static struct edma_soc_info edma_cc0_info = {
+static struct edma_soc_info dm644x_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
 };
 
-static struct edma_soc_info *dm644x_edma_info[EDMA_MAX_CC] = {
-	&edma_cc0_info,
-};
-
 static struct resource edma_resources[] = {
 	{
-		.name	= "edma_cc0",
+		.name	= "edma3_cc",
 		.start	= 0x01c00000,
 		.end	= 0x01c00000 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc0",
+		.name	= "edma3_tc0",
 		.start	= 0x01c10000,
 		.end	= 0x01c10000 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc1",
+		.name	= "edma3_tc1",
 		.start	= 0x01c10400,
 		.end	= 0x01c10400 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma0",
+		.name	= "edma3_ccint",
 		.start	= IRQ_CCINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.name	= "edma0_err",
+		.name	= "edma3_ccerrint",
 		.start	= IRQ_CCERRINT,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -550,7 +545,7 @@ static struct resource edma_resources[] = {
 static struct platform_device dm644x_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= dm644x_edma_info,
+	.dev.platform_data	= &dm644x_edma_pdata,
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 3f842bb266d6..219ebc8f674a 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -531,8 +531,7 @@ static u8 dm646x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 /*----------------------------------------------------------------------*/
 
 /* Four Transfer Controllers on DM646x */
-static s8
-dm646x_queue_priority_mapping[][2] = {
+static s8 dm646x_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 4},
 	{1, 0},
@@ -541,53 +540,49 @@ dm646x_queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
-static struct edma_soc_info edma_cc0_info = {
+static struct edma_soc_info dm646x_edma_pdata = {
 	.queue_priority_mapping	= dm646x_queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
 };
 
-static struct edma_soc_info *dm646x_edma_info[EDMA_MAX_CC] = {
-	&edma_cc0_info,
-};
-
 static struct resource edma_resources[] = {
 	{
-		.name	= "edma_cc0",
+		.name	= "edma3_cc",
 		.start	= 0x01c00000,
 		.end	= 0x01c00000 + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc0",
+		.name	= "edma3_tc0",
 		.start	= 0x01c10000,
 		.end	= 0x01c10000 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc1",
+		.name	= "edma3_tc1",
 		.start	= 0x01c10400,
 		.end	= 0x01c10400 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc2",
+		.name	= "edma3_tc2",
 		.start	= 0x01c10800,
 		.end	= 0x01c10800 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma_tc3",
+		.name	= "edma3_tc3",
 		.start	= 0x01c10c00,
 		.end	= 0x01c10c00 + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.name	= "edma0",
+		.name	= "edma3_ccint",
 		.start	= IRQ_CCINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.name	= "edma0_err",
+		.name	= "edma3_ccerrint",
 		.start	= IRQ_CCERRINT,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -597,7 +592,7 @@ static struct resource edma_resources[] = {
 static struct platform_device dm646x_edma_device = {
 	.name			= "edma",
 	.id			= 0,
-	.dev.platform_data	= dm646x_edma_info,
+	.dev.platform_data	= &dm646x_edma_pdata,
 	.num_resources		= ARRAY_SIZE(edma_resources),
 	.resource		= edma_resources,
 };
@@ -936,7 +931,7 @@ void dm646x_setup_vpif(struct vpif_display_config *display_config,
 
 int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 {
-	edma_cc0_info.rsv = rsv;
+	dm646x_edma_pdata.rsv = rsv;
 
 	return platform_device_register(&dm646x_edma_device);
 }
-- 
2.5.1
