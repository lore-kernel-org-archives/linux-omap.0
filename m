From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 06/23] ARM: common: edma: Internal API to use pointer to 'struct edma'
Date: Fri, 11 Sep 2015 15:27:05 +0300
Message-ID: <1441974442-8233-7-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Merge the iomem into the 'struct edma' and change the internal (static)
functions to use pointer to the edma_cc instead of the ctlr number.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 400 ++++++++++++++++++++++++-------------------------
 1 file changed, 197 insertions(+), 203 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index dc960de1a95f..5fd8293a48aa 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -114,108 +114,141 @@
 #define EDMA_MAX_PARAMENTRY     512
 
 /*****************************************************************************/
+struct edma {
+	struct device	*dev;
+	void __iomem *base;
+
+	/* how many dma resources of each type */
+	unsigned	num_channels;
+	unsigned	num_region;
+	unsigned	num_slots;
+	unsigned	num_tc;
+	enum dma_event_q 	default_queue;
 
-static void __iomem *edmacc_regs_base[EDMA_MAX_CC];
+	/* list of channels with no even trigger; terminated by "-1" */
+	const s8	*noevent;
+
+	struct edma_soc_info *info;
+	int		id;
+
+	/* The edma_inuse bit for each PaRAM slot is clear unless the
+	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
+	 */
+	DECLARE_BITMAP(edma_inuse, EDMA_MAX_PARAMENTRY);
 
-static inline unsigned int edma_read(unsigned ctlr, int offset)
+	/* The edma_unused bit for each channel is clear unless
+	 * it is not being used on this platform. It uses a bit
+	 * of SOC-specific initialization code.
+	 */
+	DECLARE_BITMAP(edma_unused, EDMA_MAX_DMACH);
+
+	struct dma_interrupt_data {
+		void (*callback)(unsigned channel, unsigned short ch_status,
+				void *data);
+		void *data;
+	} intr_data[EDMA_MAX_DMACH];
+};
+/*****************************************************************************/
+
+static inline unsigned int edma_read(struct edma *cc, int offset)
 {
-	return (unsigned int)__raw_readl(edmacc_regs_base[ctlr] + offset);
+	return (unsigned int)__raw_readl(cc->base + offset);
 }
 
-static inline void edma_write(unsigned ctlr, int offset, int val)
+static inline void edma_write(struct edma *cc, int offset, int val)
 {
-	__raw_writel(val, edmacc_regs_base[ctlr] + offset);
+	__raw_writel(val, cc->base + offset);
 }
-static inline void edma_modify(unsigned ctlr, int offset, unsigned and,
-		unsigned or)
+static inline void edma_modify(struct edma *cc, int offset, unsigned and,
+			       unsigned or)
 {
-	unsigned val = edma_read(ctlr, offset);
+	unsigned val = edma_read(cc, offset);
 	val &= and;
 	val |= or;
-	edma_write(ctlr, offset, val);
+	edma_write(cc, offset, val);
 }
-static inline void edma_and(unsigned ctlr, int offset, unsigned and)
+static inline void edma_and(struct edma *cc, int offset, unsigned and)
 {
-	unsigned val = edma_read(ctlr, offset);
+	unsigned val = edma_read(cc, offset);
 	val &= and;
-	edma_write(ctlr, offset, val);
+	edma_write(cc, offset, val);
 }
-static inline void edma_or(unsigned ctlr, int offset, unsigned or)
+static inline void edma_or(struct edma *cc, int offset, unsigned or)
 {
-	unsigned val = edma_read(ctlr, offset);
+	unsigned val = edma_read(cc, offset);
 	val |= or;
-	edma_write(ctlr, offset, val);
+	edma_write(cc, offset, val);
 }
-static inline unsigned int edma_read_array(unsigned ctlr, int offset, int i)
+static inline unsigned int edma_read_array(struct edma *cc, int offset, int i)
 {
-	return edma_read(ctlr, offset + (i << 2));
+	return edma_read(cc, offset + (i << 2));
 }
-static inline void edma_write_array(unsigned ctlr, int offset, int i,
+static inline void edma_write_array(struct edma *cc, int offset, int i,
 		unsigned val)
 {
-	edma_write(ctlr, offset + (i << 2), val);
+	edma_write(cc, offset + (i << 2), val);
 }
-static inline void edma_modify_array(unsigned ctlr, int offset, int i,
+static inline void edma_modify_array(struct edma *cc, int offset, int i,
 		unsigned and, unsigned or)
 {
-	edma_modify(ctlr, offset + (i << 2), and, or);
+	edma_modify(cc, offset + (i << 2), and, or);
 }
-static inline void edma_or_array(unsigned ctlr, int offset, int i, unsigned or)
+static inline void edma_or_array(struct edma *cc, int offset, int i, unsigned or)
 {
-	edma_or(ctlr, offset + (i << 2), or);
+	edma_or(cc, offset + (i << 2), or);
 }
-static inline void edma_or_array2(unsigned ctlr, int offset, int i, int j,
+static inline void edma_or_array2(struct edma *cc, int offset, int i, int j,
 		unsigned or)
 {
-	edma_or(ctlr, offset + ((i*2 + j) << 2), or);
+	edma_or(cc, offset + ((i*2 + j) << 2), or);
 }
-static inline void edma_write_array2(unsigned ctlr, int offset, int i, int j,
+static inline void edma_write_array2(struct edma *cc, int offset, int i, int j,
 		unsigned val)
 {
-	edma_write(ctlr, offset + ((i*2 + j) << 2), val);
+	edma_write(cc, offset + ((i*2 + j) << 2), val);
 }
-static inline unsigned int edma_shadow0_read(unsigned ctlr, int offset)
+static inline unsigned int edma_shadow0_read(struct edma *cc, int offset)
 {
-	return edma_read(ctlr, EDMA_SHADOW0 + offset);
+	return edma_read(cc, EDMA_SHADOW0 + offset);
 }
-static inline unsigned int edma_shadow0_read_array(unsigned ctlr, int offset,
+static inline unsigned int edma_shadow0_read_array(struct edma *cc, int offset,
 		int i)
 {
-	return edma_read(ctlr, EDMA_SHADOW0 + offset + (i << 2));
+	return edma_read(cc, EDMA_SHADOW0 + offset + (i << 2));
 }
-static inline void edma_shadow0_write(unsigned ctlr, int offset, unsigned val)
+static inline void edma_shadow0_write(struct edma *cc, int offset, unsigned val)
 {
-	edma_write(ctlr, EDMA_SHADOW0 + offset, val);
+	edma_write(cc, EDMA_SHADOW0 + offset, val);
 }
-static inline void edma_shadow0_write_array(unsigned ctlr, int offset, int i,
+static inline void edma_shadow0_write_array(struct edma *cc, int offset, int i,
 		unsigned val)
 {
-	edma_write(ctlr, EDMA_SHADOW0 + offset + (i << 2), val);
+	edma_write(cc, EDMA_SHADOW0 + offset + (i << 2), val);
 }
-static inline unsigned int edma_parm_read(unsigned ctlr, int offset,
+static inline unsigned int edma_parm_read(struct edma *cc, int offset,
 		int param_no)
 {
-	return edma_read(ctlr, EDMA_PARM + offset + (param_no << 5));
+	return edma_read(cc, EDMA_PARM + offset + (param_no << 5));
 }
-static inline void edma_parm_write(unsigned ctlr, int offset, int param_no,
+static inline void edma_parm_write(struct edma *cc, int offset, int param_no,
 		unsigned val)
 {
-	edma_write(ctlr, EDMA_PARM + offset + (param_no << 5), val);
+	edma_write(cc, EDMA_PARM + offset + (param_no << 5), val);
 }
-static inline void edma_parm_modify(unsigned ctlr, int offset, int param_no,
+static inline void edma_parm_modify(struct edma *cc, int offset, int param_no,
 		unsigned and, unsigned or)
 {
-	edma_modify(ctlr, EDMA_PARM + offset + (param_no << 5), and, or);
+	edma_modify(cc, EDMA_PARM + offset + (param_no << 5), and, or);
 }
-static inline void edma_parm_and(unsigned ctlr, int offset, int param_no,
+static inline void edma_parm_and(struct edma *cc, int offset, int param_no,
 		unsigned and)
 {
-	edma_and(ctlr, EDMA_PARM + offset + (param_no << 5), and);
+	edma_and(cc, EDMA_PARM + offset + (param_no << 5), and);
 }
-static inline void edma_parm_or(unsigned ctlr, int offset, int param_no,
+static inline void edma_parm_or(struct edma *cc, int offset, int param_no,
 		unsigned or)
 {
-	edma_or(ctlr, EDMA_PARM + offset + (param_no << 5), or);
+	edma_or(cc, EDMA_PARM + offset + (param_no << 5), or);
 }
 
 static inline void set_bits(int offset, int len, unsigned long *p)
@@ -231,41 +264,6 @@ static inline void clear_bits(int offset, int len, unsigned long *p)
 }
 
 /*****************************************************************************/
-
-/* actual number of DMA channels and slots on this silicon */
-struct edma {
-	struct device	*dev;
-	/* how many dma resources of each type */
-	unsigned	num_channels;
-	unsigned	num_region;
-	unsigned	num_slots;
-	unsigned	num_tc;
-	enum dma_event_q 	default_queue;
-
-	/* list of channels with no even trigger; terminated by "-1" */
-	const s8	*noevent;
-
-	struct edma_soc_info *info;
-	int		id;
-
-	/* The edma_inuse bit for each PaRAM slot is clear unless the
-	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
-	 */
-	DECLARE_BITMAP(edma_inuse, EDMA_MAX_PARAMENTRY);
-
-	/* The edma_unused bit for each channel is clear unless
-	 * it is not being used on this platform. It uses a bit
-	 * of SOC-specific initialization code.
-	 */
-	DECLARE_BITMAP(edma_unused, EDMA_MAX_DMACH);
-
-	struct dma_interrupt_data {
-		void (*callback)(unsigned channel, unsigned short ch_status,
-				void *data);
-		void *data;
-	} intr_data[EDMA_MAX_DMACH];
-};
-
 static struct edma *edma_cc[EDMA_MAX_CC];
 static int arch_num_cc;
 
@@ -282,26 +280,25 @@ static const struct of_device_id edma_of_ids[] = {
 
 /*****************************************************************************/
 
-static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
-		enum dma_event_q queue_no)
+static void map_dmach_queue(struct edma *cc, unsigned ch_no,
+			    enum dma_event_q queue_no)
 {
 	int bit = (ch_no & 0x7) * 4;
 
 	/* default to low priority queue */
 	if (queue_no == EVENTQ_DEFAULT)
-		queue_no = edma_cc[ctlr]->default_queue;
+		queue_no = cc->default_queue;
 
 	queue_no &= 7;
-	edma_modify_array(ctlr, EDMA_DMAQNUM, (ch_no >> 3),
-			~(0x7 << bit), queue_no << bit);
+	edma_modify_array(cc, EDMA_DMAQNUM, (ch_no >> 3),
+			  ~(0x7 << bit), queue_no << bit);
 }
 
-static void assign_priority_to_queue(unsigned ctlr, int queue_no,
-		int priority)
+static void assign_priority_to_queue(struct edma *cc, int queue_no,
+				     int priority)
 {
 	int bit = queue_no * 4;
-	edma_modify(ctlr, EDMA_QUEPRI, ~(0x7 << bit),
-			((priority & 0x7) << bit));
+	edma_modify(cc, EDMA_QUEPRI, ~(0x7 << bit), ((priority & 0x7) << bit));
 }
 
 /**
@@ -315,35 +312,30 @@ static void assign_priority_to_queue(unsigned ctlr, int queue_no,
  * included in that particular EDMA variant (Eg : dm646x)
  *
  */
-static void map_dmach_param(unsigned ctlr)
+static void map_dmach_param(struct edma *cc)
 {
 	int i;
 	for (i = 0; i < EDMA_MAX_DMACH; i++)
-		edma_write_array(ctlr, EDMA_DCHMAP , i , (i << 5));
+		edma_write_array(cc, EDMA_DCHMAP , i , (i << 5));
 }
 
-static inline void
-setup_dma_interrupt(unsigned lch,
+static inline void setup_dma_interrupt(struct edma *cc, unsigned lch,
 	void (*callback)(unsigned channel, u16 ch_status, void *data),
 	void *data)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(lch);
 	lch = EDMA_CHAN_SLOT(lch);
 
 	if (!callback)
-		edma_shadow0_write_array(ctlr, SH_IECR, lch >> 5,
-				BIT(lch & 0x1f));
+		edma_shadow0_write_array(cc, SH_IECR, lch >> 5,
+					 BIT(lch & 0x1f));
 
-	edma_cc[ctlr]->intr_data[lch].callback = callback;
-	edma_cc[ctlr]->intr_data[lch].data = data;
+	cc->intr_data[lch].callback = callback;
+	cc->intr_data[lch].data = data;
 
 	if (callback) {
-		edma_shadow0_write_array(ctlr, SH_ICR, lch >> 5,
-				BIT(lch & 0x1f));
-		edma_shadow0_write_array(ctlr, SH_IESR, lch >> 5,
-				BIT(lch & 0x1f));
+		edma_shadow0_write_array(cc, SH_ICR, lch >> 5, BIT(lch & 0x1f));
+		edma_shadow0_write_array(cc, SH_IESR, lch >> 5,
+					 BIT(lch & 0x1f));
 	}
 }
 
@@ -366,15 +358,15 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 
 	dev_dbg(cc->dev, "dma_irq_handler\n");
 
-	sh_ipr = edma_shadow0_read_array(ctlr, SH_IPR, 0);
+	sh_ipr = edma_shadow0_read_array(cc, SH_IPR, 0);
 	if (!sh_ipr) {
-		sh_ipr = edma_shadow0_read_array(ctlr, SH_IPR, 1);
+		sh_ipr = edma_shadow0_read_array(cc, SH_IPR, 1);
 		if (!sh_ipr)
 			return IRQ_NONE;
-		sh_ier = edma_shadow0_read_array(ctlr, SH_IER, 1);
+		sh_ier = edma_shadow0_read_array(cc, SH_IER, 1);
 		bank = 1;
 	} else {
-		sh_ier = edma_shadow0_read_array(ctlr, SH_IER, 0);
+		sh_ier = edma_shadow0_read_array(cc, SH_IER, 0);
 		bank = 0;
 	}
 
@@ -390,8 +382,7 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 		if (sh_ier & BIT(slot)) {
 			channel = (bank << 5) | slot;
 			/* Clear the corresponding IPR bits */
-			edma_shadow0_write_array(ctlr, SH_ICR, bank,
-					BIT(slot));
+			edma_shadow0_write_array(cc, SH_ICR, bank, BIT(slot));
 			if (cc->intr_data[channel].callback)
 				cc->intr_data[channel].callback(
 					EDMA_CTLR_CHAN(ctlr, channel),
@@ -400,7 +391,7 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 		}
 	} while (sh_ipr);
 
-	edma_shadow0_write(ctlr, SH_IEVAL, 1);
+	edma_shadow0_write(cc, SH_IEVAL, 1);
 	return IRQ_HANDLED;
 }
 
@@ -422,30 +413,30 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 
 	dev_dbg(cc->dev, "dma_ccerr_handler\n");
 
-	if ((edma_read_array(ctlr, EDMA_EMR, 0) == 0) &&
-	    (edma_read_array(ctlr, EDMA_EMR, 1) == 0) &&
-	    (edma_read(ctlr, EDMA_QEMR) == 0) &&
-	    (edma_read(ctlr, EDMA_CCERR) == 0))
+	if ((edma_read_array(cc, EDMA_EMR, 0) == 0) &&
+	    (edma_read_array(cc, EDMA_EMR, 1) == 0) &&
+	    (edma_read(cc, EDMA_QEMR) == 0) &&
+	    (edma_read(cc, EDMA_CCERR) == 0))
 		return IRQ_NONE;
 
 	while (1) {
 		int j = -1;
-		if (edma_read_array(ctlr, EDMA_EMR, 0))
+		if (edma_read_array(cc, EDMA_EMR, 0))
 			j = 0;
-		else if (edma_read_array(ctlr, EDMA_EMR, 1))
+		else if (edma_read_array(cc, EDMA_EMR, 1))
 			j = 1;
 		if (j >= 0) {
 			dev_dbg(cc->dev, "EMR%d %08x\n", j,
-				edma_read_array(ctlr, EDMA_EMR, j));
+				edma_read_array(cc, EDMA_EMR, j));
 			for (i = 0; i < 32; i++) {
 				int k = (j << 5) + i;
-				if (edma_read_array(ctlr, EDMA_EMR, j) &
+				if (edma_read_array(cc, EDMA_EMR, j) &
 							BIT(i)) {
 					/* Clear the corresponding EMR bits */
-					edma_write_array(ctlr, EDMA_EMCR, j,
-							BIT(i));
+					edma_write_array(cc, EDMA_EMCR, j,
+							 BIT(i));
 					/* Clear any SER */
-					edma_shadow0_write_array(ctlr, SH_SECR,
+					edma_shadow0_write_array(cc, SH_SECR,
 								j, BIT(i));
 					if (cc->intr_data[k].callback) {
 						cc->intr_data[k].callback(
@@ -455,44 +446,44 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 					}
 				}
 			}
-		} else if (edma_read(ctlr, EDMA_QEMR)) {
+		} else if (edma_read(cc, EDMA_QEMR)) {
 			dev_dbg(cc->dev, "QEMR %02x\n",
-				edma_read(ctlr, EDMA_QEMR));
+				edma_read(cc, EDMA_QEMR));
 			for (i = 0; i < 8; i++) {
-				if (edma_read(ctlr, EDMA_QEMR) & BIT(i)) {
+				if (edma_read(cc, EDMA_QEMR) & BIT(i)) {
 					/* Clear the corresponding IPR bits */
-					edma_write(ctlr, EDMA_QEMCR, BIT(i));
-					edma_shadow0_write(ctlr, SH_QSECR,
-								BIT(i));
+					edma_write(cc, EDMA_QEMCR, BIT(i));
+					edma_shadow0_write(cc, SH_QSECR,
+							   BIT(i));
 
 					/* NOTE:  not reported!! */
 				}
 			}
-		} else if (edma_read(ctlr, EDMA_CCERR)) {
+		} else if (edma_read(cc, EDMA_CCERR)) {
 			dev_dbg(cc->dev, "CCERR %08x\n",
-				edma_read(ctlr, EDMA_CCERR));
+				edma_read(cc, EDMA_CCERR));
 			/* FIXME:  CCERR.BIT(16) ignored!  much better
 			 * to just write CCERRCLR with CCERR value...
 			 */
 			for (i = 0; i < 8; i++) {
-				if (edma_read(ctlr, EDMA_CCERR) & BIT(i)) {
+				if (edma_read(cc, EDMA_CCERR) & BIT(i)) {
 					/* Clear the corresponding IPR bits */
-					edma_write(ctlr, EDMA_CCERRCLR, BIT(i));
+					edma_write(cc, EDMA_CCERRCLR, BIT(i));
 
 					/* NOTE:  not reported!! */
 				}
 			}
 		}
-		if ((edma_read_array(ctlr, EDMA_EMR, 0) == 0) &&
-		    (edma_read_array(ctlr, EDMA_EMR, 1) == 0) &&
-		    (edma_read(ctlr, EDMA_QEMR) == 0) &&
-		    (edma_read(ctlr, EDMA_CCERR) == 0))
+		if ((edma_read_array(cc, EDMA_EMR, 0) == 0) &&
+		    (edma_read_array(cc, EDMA_EMR, 1) == 0) &&
+		    (edma_read(cc, EDMA_QEMR) == 0) &&
+		    (edma_read(cc, EDMA_CCERR) == 0))
 			break;
 		cnt++;
 		if (cnt > 10)
 			break;
 	}
-	edma_write(ctlr, EDMA_EEVAL, 1);
+	edma_write(cc, EDMA_EEVAL, 1);
 	return IRQ_HANDLED;
 }
 
@@ -629,18 +620,19 @@ int edma_alloc_channel(int channel,
 	}
 
 	/* ensure access through shadow region 0 */
-	edma_or_array2(ctlr, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
+	edma_or_array2(edma_cc[ctlr], EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
 
 	/* ensure no events are pending */
 	edma_stop(EDMA_CTLR_CHAN(ctlr, channel));
-	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(channel),
-			&dummy_paramset, PARM_SIZE);
+	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(channel), &dummy_paramset,
+		    PARM_SIZE);
 
 	if (callback)
-		setup_dma_interrupt(EDMA_CTLR_CHAN(ctlr, channel),
-					callback, data);
+		setup_dma_interrupt(edma_cc[ctlr],
+				    EDMA_CTLR_CHAN(ctlr, channel), callback,
+				    data);
 
-	map_dmach_queue(ctlr, channel, eventq_no);
+	map_dmach_queue(edma_cc[ctlr], channel, eventq_no);
 
 	return EDMA_CTLR_CHAN(ctlr, channel);
 }
@@ -668,11 +660,11 @@ void edma_free_channel(unsigned channel)
 	if (channel >= edma_cc[ctlr]->num_channels)
 		return;
 
-	setup_dma_interrupt(channel, NULL, NULL);
+	setup_dma_interrupt(edma_cc[ctlr], channel, NULL, NULL);
 	/* REVISIT should probably take out of shadow region 0 */
 
-	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(channel),
-			&dummy_paramset, PARM_SIZE);
+	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(channel), &dummy_paramset,
+		    PARM_SIZE);
 	clear_bit(channel, edma_cc[ctlr]->edma_inuse);
 }
 EXPORT_SYMBOL(edma_free_channel);
@@ -716,8 +708,8 @@ int edma_alloc_slot(unsigned ctlr, int slot)
 		return -EBUSY;
 	}
 
-	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot),
-			&dummy_paramset, PARM_SIZE);
+	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(slot), &dummy_paramset,
+		    PARM_SIZE);
 
 	return EDMA_CTLR_CHAN(ctlr, slot);
 }
@@ -742,8 +734,8 @@ void edma_free_slot(unsigned slot)
 		slot >= edma_cc[ctlr]->num_slots)
 		return;
 
-	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot),
-			&dummy_paramset, PARM_SIZE);
+	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(slot), &dummy_paramset,
+		    PARM_SIZE);
 	clear_bit(slot, edma_cc[ctlr]->edma_inuse);
 }
 EXPORT_SYMBOL(edma_free_slot);
@@ -768,7 +760,7 @@ dma_addr_t edma_get_position(unsigned slot, bool dst)
 	offs = PARM_OFFSET(slot);
 	offs += dst ? PARM_DST : PARM_SRC;
 
-	return edma_read(ctlr, offs);
+	return edma_read(edma_cc[ctlr], offs);
 }
 
 /**
@@ -791,7 +783,7 @@ void edma_link(unsigned from, unsigned to)
 		return;
 	if (to >= edma_cc[ctlr_to]->num_slots)
 		return;
-	edma_parm_modify(ctlr_from, PARM_LINK_BCNTRLD, from, 0xffff0000,
+	edma_parm_modify(edma_cc[ctlr_from], PARM_LINK_BCNTRLD, from, 0xffff0000,
 				PARM_OFFSET(to));
 }
 EXPORT_SYMBOL(edma_link);
@@ -819,8 +811,7 @@ void edma_write_slot(unsigned slot, const struct edmacc_param *param)
 
 	if (slot >= edma_cc[ctlr]->num_slots)
 		return;
-	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot), param,
-			PARM_SIZE);
+	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(slot), param, PARM_SIZE);
 }
 EXPORT_SYMBOL(edma_write_slot);
 
@@ -841,8 +832,8 @@ void edma_read_slot(unsigned slot, struct edmacc_param *param)
 
 	if (slot >= edma_cc[ctlr]->num_slots)
 		return;
-	memcpy_fromio(param, edmacc_regs_base[ctlr] + PARM_OFFSET(slot),
-			PARM_SIZE);
+	memcpy_fromio(param, edma_cc[ctlr]->base + PARM_OFFSET(slot),
+		      PARM_SIZE);
 }
 EXPORT_SYMBOL(edma_read_slot);
 
@@ -867,7 +858,8 @@ void edma_pause(unsigned channel)
 	if (channel < edma_cc[ctlr]->num_channels) {
 		unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(ctlr, SH_EECR, channel >> 5, mask);
+		edma_shadow0_write_array(edma_cc[ctlr], SH_EECR, channel >> 5,
+					 mask);
 	}
 }
 EXPORT_SYMBOL(edma_pause);
@@ -888,7 +880,8 @@ void edma_resume(unsigned channel)
 	if (channel < edma_cc[ctlr]->num_channels) {
 		unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(ctlr, SH_EESR, channel >> 5, mask);
+		edma_shadow0_write_array(edma_cc[ctlr], SH_EESR, channel >> 5,
+					 mask);
 	}
 }
 EXPORT_SYMBOL(edma_resume);
@@ -902,10 +895,11 @@ int edma_trigger_channel(unsigned channel)
 	channel = EDMA_CHAN_SLOT(channel);
 	mask = BIT(channel & 0x1f);
 
-	edma_shadow0_write_array(ctlr, SH_ESR, (channel >> 5), mask);
+	edma_shadow0_write_array(edma_cc[ctlr], SH_ESR, (channel >> 5), mask);
 
 	pr_debug("EDMA: ESR%d %08x\n", (channel >> 5),
-		 edma_shadow0_read_array(ctlr, SH_ESR, (channel >> 5)));
+		 edma_shadow0_read_array(edma_cc[ctlr], SH_ESR,
+					 (channel >> 5)));
 	return 0;
 }
 EXPORT_SYMBOL(edma_trigger_channel);
@@ -929,28 +923,29 @@ int edma_start(unsigned channel)
 	channel = EDMA_CHAN_SLOT(channel);
 
 	if (channel < edma_cc[ctlr]->num_channels) {
+		struct edma *cc = edma_cc[ctlr];
 		int j = channel >> 5;
 		unsigned int mask = BIT(channel & 0x1f);
 
 		/* EDMA channels without event association */
-		if (test_bit(channel, edma_cc[ctlr]->edma_unused)) {
+		if (test_bit(channel, cc->edma_unused)) {
 			pr_debug("EDMA: ESR%d %08x\n", j,
-				edma_shadow0_read_array(ctlr, SH_ESR, j));
-			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
+				 edma_shadow0_read_array(cc, SH_ESR, j));
+			edma_shadow0_write_array(cc, SH_ESR, j, mask);
 			return 0;
 		}
 
 		/* EDMA channel with event association */
 		pr_debug("EDMA: ER%d %08x\n", j,
-			edma_shadow0_read_array(ctlr, SH_ER, j));
+			edma_shadow0_read_array(cc, SH_ER, j));
 		/* Clear any pending event or error */
-		edma_write_array(ctlr, EDMA_ECR, j, mask);
-		edma_write_array(ctlr, EDMA_EMCR, j, mask);
+		edma_write_array(cc, EDMA_ECR, j, mask);
+		edma_write_array(cc, EDMA_EMCR, j, mask);
 		/* Clear any SER */
-		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
-		edma_shadow0_write_array(ctlr, SH_EESR, j, mask);
+		edma_shadow0_write_array(cc, SH_SECR, j, mask);
+		edma_shadow0_write_array(cc, SH_EESR, j, mask);
 		pr_debug("EDMA: EER%d %08x\n", j,
-			edma_shadow0_read_array(ctlr, SH_EER, j));
+			 edma_shadow0_read_array(cc, SH_EER, j));
 		return 0;
 	}
 
@@ -975,19 +970,20 @@ void edma_stop(unsigned channel)
 	channel = EDMA_CHAN_SLOT(channel);
 
 	if (channel < edma_cc[ctlr]->num_channels) {
+		struct edma *cc = edma_cc[ctlr];
 		int j = channel >> 5;
 		unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
-		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
-		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
-		edma_write_array(ctlr, EDMA_EMCR, j, mask);
+		edma_shadow0_write_array(cc, SH_EECR, j, mask);
+		edma_shadow0_write_array(cc, SH_ECR, j, mask);
+		edma_shadow0_write_array(cc, SH_SECR, j, mask);
+		edma_write_array(cc, EDMA_EMCR, j, mask);
 
 		/* clear possibly pending completion interrupt */
-		edma_shadow0_write_array(ctlr, SH_ICR, j, mask);
+		edma_shadow0_write_array(cc, SH_ICR, j, mask);
 
 		pr_debug("EDMA: EER%d %08x\n", j,
-				edma_shadow0_read_array(ctlr, SH_EER, j));
+			 edma_shadow0_read_array(cc, SH_EER, j));
 
 		/* REVISIT:  consider guarding against inappropriate event
 		 * chaining by overwriting with dummy_paramset.
@@ -1017,17 +1013,18 @@ void edma_clean_channel(unsigned channel)
 	channel = EDMA_CHAN_SLOT(channel);
 
 	if (channel < edma_cc[ctlr]->num_channels) {
+		struct edma *cc = edma_cc[ctlr];
 		int j = (channel >> 5);
 		unsigned int mask = BIT(channel & 0x1f);
 
 		pr_debug("EDMA: EMR%d %08x\n", j,
-				edma_read_array(ctlr, EDMA_EMR, j));
-		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
+			 edma_read_array(cc, EDMA_EMR, j));
+		edma_shadow0_write_array(cc, SH_ECR, j, mask);
 		/* Clear the corresponding EMR bits */
-		edma_write_array(ctlr, EDMA_EMCR, j, mask);
+		edma_write_array(cc, EDMA_EMCR, j, mask);
 		/* Clear any SER */
-		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
-		edma_write(ctlr, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
+		edma_shadow0_write_array(cc, SH_SECR, j, mask);
+		edma_write(cc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
 	}
 }
 EXPORT_SYMBOL(edma_clean_channel);
@@ -1056,7 +1053,7 @@ void edma_assign_channel_eventq(unsigned channel, enum dma_event_q eventq_no)
 	if (eventq_no >= edma_cc[ctlr]->num_tc)
 		return;
 
-	map_dmach_queue(ctlr, channel, eventq_no);
+	map_dmach_queue(edma_cc[ctlr], channel, eventq_no);
 }
 EXPORT_SYMBOL(edma_assign_channel_eventq);
 
@@ -1068,7 +1065,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	s8 (*queue_priority_map)[2];
 
 	/* Decode the eDMA3 configuration from CCCFG register */
-	cccfg = edma_read(cc_id, EDMA_CCCFG);
+	cccfg = edma_read(edma_cc, EDMA_CCCFG);
 
 	value = GET_NUM_REGN(cccfg);
 	edma_cc->num_region = BIT(value);
@@ -1281,10 +1278,6 @@ static int edma_probe(struct platform_device *pdev)
 		}
 	}
 
-	edmacc_regs_base[dev_id] = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(edmacc_regs_base[dev_id]))
-		return PTR_ERR(edmacc_regs_base[dev_id]);
-
 	edma_cc[dev_id] = devm_kzalloc(dev, sizeof(struct edma), GFP_KERNEL);
 	if (!edma_cc[dev_id])
 		return -ENOMEM;
@@ -1294,6 +1287,10 @@ static int edma_probe(struct platform_device *pdev)
 	cc->id = dev_id;
 	dev_set_drvdata(dev, cc);
 
+	cc->base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(cc->base))
+		return PTR_ERR(cc->base);
+
 	/* Get eDMA3 configuration from IP */
 	ret = edma_setup_from_hw(dev, info, cc, dev_id);
 	if (ret)
@@ -1301,11 +1298,9 @@ static int edma_probe(struct platform_device *pdev)
 
 	cc->default_queue = info->default_queue;
 
-	dev_dbg(dev, "DMA REG BASE ADDR=%p\n", edmacc_regs_base[dev_id]);
-
 	for (i = 0; i < cc->num_slots; i++)
-		memcpy_toio(edmacc_regs_base[dev_id] + PARM_OFFSET(i),
-			    &dummy_paramset, PARM_SIZE);
+		memcpy_toio(cc->base + PARM_OFFSET(i), &dummy_paramset,
+			    PARM_SIZE);
 
 	/* Mark all channels as unused */
 	memset(cc->edma_unused, 0xff, sizeof(cc->edma_unused));
@@ -1374,23 +1369,23 @@ static int edma_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < cc->num_channels; i++)
-		map_dmach_queue(dev_id, i, info->default_queue);
+		map_dmach_queue(cc, i, info->default_queue);
 
 	queue_priority_mapping = info->queue_priority_mapping;
 
 	/* Event queue priority mapping */
 	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
-		assign_priority_to_queue(dev_id, queue_priority_mapping[i][0],
+		assign_priority_to_queue(cc, queue_priority_mapping[i][0],
 					 queue_priority_mapping[i][1]);
 
 	/* Map the channel to param entry if channel mapping logic exist */
-	if (edma_read(dev_id, EDMA_CCCFG) & CHMAP_EXIST)
-		map_dmach_param(dev_id);
+	if (edma_read(cc, EDMA_CCCFG) & CHMAP_EXIST)
+		map_dmach_param(cc);
 
 	for (i = 0; i < cc->num_region; i++) {
-		edma_write_array2(dev_id, EDMA_DRAE, i, 0, 0x0);
-		edma_write_array2(dev_id, EDMA_DRAE, i, 1, 0x0);
-		edma_write_array(dev_id, EDMA_QRAE, i, 0x0);
+		edma_write_array2(cc, EDMA_DRAE, i, 0, 0x0);
+		edma_write_array2(cc, EDMA_DRAE, i, 1, 0x0);
+		edma_write_array(cc, EDMA_QRAE, i, 0x0);
 	}
 	cc->info = info;
 	arch_num_cc++;
@@ -1413,20 +1408,19 @@ static int edma_pm_resume(struct device *dev)
 
 	/* Event queue priority mapping */
 	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
-		assign_priority_to_queue(cc->id, queue_priority_mapping[i][0],
+		assign_priority_to_queue(cc, queue_priority_mapping[i][0],
 					 queue_priority_mapping[i][1]);
 
 	/* Map the channel to param entry if channel mapping logic */
-	if (edma_read(cc->id, EDMA_CCCFG) & CHMAP_EXIST)
-		map_dmach_param(cc->id);
+	if (edma_read(cc, EDMA_CCCFG) & CHMAP_EXIST)
+		map_dmach_param(cc);
 
 	for (i = 0; i < cc->num_channels; i++) {
 		if (test_bit(i, cc->edma_inuse)) {
 			/* ensure access through shadow region 0 */
-			edma_or_array2(cc->id, EDMA_DRAE, 0, i >> 5,
-				       BIT(i & 0x1f));
+			edma_or_array2(cc, EDMA_DRAE, 0, i >> 5, BIT(i & 0x1f));
 
-			setup_dma_interrupt(EDMA_CTLR_CHAN(cc->id, i),
+			setup_dma_interrupt(cc, EDMA_CTLR_CHAN(cc->id, i),
 					    cc->intr_data[i].callback,
 					    cc->intr_data[i].data);
 		}
-- 
2.5.1
