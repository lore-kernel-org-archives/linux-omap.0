From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/7] dmaengine: omap-dma: Support for LinkedList transfer of slave_sg
Date: Thu, 14 Jul 2016 15:42:42 +0300
Message-ID: <20160714124242.7579-8-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

sDMA in OMAP3630 or newer SoC have support for LinkedList transfer. When
LinkedList or Descriptor load feature is present we can create the
descriptors for each and program sDMA to walk through the list of
descriptors instead of the current way of sDMA stop, sDMA reconfiguration
and sDMA start after each SG transfer.
By using LinkedList transfer in sDMA the number of DMA interrupts will
decrease dramatically.
Booting up the board with filesystem on SD card for example:
# cat /proc/interrupts | grep dma
W/o LinkedList support:
 27:       4436          0     WUGEN  13 Level     omap-dma-engine

Same board/filesystem with this patch:
 27:       1027          0     WUGEN  13 Level     omap-dma-engine

Or copying files from SD card to eMCC:
# du -h /usr
2.1G    /usr/
# find /usr/ -type f | wc -l
232001

# cp -r /usr/* /mnt/emmc/tmp/

W/o LinkedList we see ~761069 DMA interrupts.
With LinkedList support it is down to ~269314 DMA interrupts.

With the decreased DMA interrupt number the CPU load is dropping
significantly as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 8497750fa44a..22b3e1a5425d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -32,6 +33,7 @@ struct omap_dmadev {
 	const struct omap_dma_reg *reg_map;
 	struct omap_system_dma_plat_info *plat;
 	bool legacy;
+	bool ll123_supported;
 	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
@@ -41,6 +43,7 @@ struct omap_dmadev {
 struct omap_chan {
 	struct virt_dma_chan vc;
 	void __iomem *channel_base;
+	struct dma_pool *desc_pool;
 	const struct omap_dma_reg *reg_map;
 	uint32_t ccr;
 
@@ -55,16 +58,41 @@ struct omap_chan {
 	unsigned sgidx;
 };
 
+#define DESC_NXT_SV_REFRESH	(0x1 << 24)
+#define DESC_NXT_SV_REUSE	(0x2 << 24)
+#define DESC_NXT_DV_REFRESH	(0x1 << 26)
+#define DESC_NXT_DV_REUSE	(0x2 << 26)
+#define DESC_NTYPE_TYPE2	(0x2 << 29)
+
+/* Type 2 descriptor with Source or Destination address update */
+struct omap_type2_desc {
+	uint32_t next_desc;
+	uint32_t en;
+	uint32_t addr; /* src or dst */
+	uint16_t fn;
+	uint16_t cicr;
+	uint16_t cdei;
+	uint16_t csei;
+	uint32_t cdfi;
+	uint32_t csfi;
+} __packed;
+
 struct omap_sg {
 	dma_addr_t addr;
 	uint32_t en;		/* number of elements (24-bit) */
 	uint32_t fn;		/* number of frames (16-bit) */
 	int32_t fi;		/* for double indexing */
 	int16_t ei;		/* for double indexing */
+
+	/* Linked list */
+	struct omap_type2_desc *t2_desc;
+	dma_addr_t t2_desc_paddr;
 };
 
 struct omap_desc {
+	struct omap_chan *c;
 	struct virt_dma_desc vd;
+	bool using_ll;
 	enum dma_transfer_direction dir;
 	dma_addr_t dev_addr;
 
@@ -81,6 +109,9 @@ struct omap_desc {
 };
 
 enum {
+	CAPS_0_SUPPORT_LL123	= BIT(20),	/* Linked List type1/2/3 */
+	CAPS_0_SUPPORT_LL4	= BIT(21),	/* Linked List type4 */
+
 	CCR_FS			= BIT(5),
 	CCR_READ_PRIORITY	= BIT(6),
 	CCR_ENABLE		= BIT(7),
@@ -151,6 +182,19 @@ enum {
 	CICR_SUPER_BLOCK_IE	= BIT(14),	/* OMAP2+ only */
 
 	CLNK_CTRL_ENABLE_LNK	= BIT(15),
+
+	CDP_DST_VALID_INC	= 0 << 0,
+	CDP_DST_VALID_RELOAD	= 1 << 0,
+	CDP_DST_VALID_REUSE	= 2 << 0,
+	CDP_SRC_VALID_INC	= 0 << 2,
+	CDP_SRC_VALID_RELOAD	= 1 << 2,
+	CDP_SRC_VALID_REUSE	= 2 << 2,
+	CDP_NTYPE_TYPE1		= 1 << 4,
+	CDP_NTYPE_TYPE2		= 2 << 4,
+	CDP_NTYPE_TYPE3		= 3 << 4,
+	CDP_TMODE_NORMAL	= 0 << 8,
+	CDP_TMODE_LLIST		= 1 << 8,
+	CDP_FAST		= BIT(10),
 };
 
 static const unsigned es_bytes[] = {
@@ -180,7 +224,64 @@ static inline struct omap_desc *to_omap_dma_desc(struct dma_async_tx_descriptor
 
 static void omap_dma_desc_free(struct virt_dma_desc *vd)
 {
-	kfree(container_of(vd, struct omap_desc, vd));
+	struct omap_desc *d = container_of(vd, struct omap_desc, vd);
+
+	if (d->using_ll) {
+		struct omap_chan *c = d->c;
+		int i;
+
+		for (i = 0; i < d->sglen; i++) {
+			if (d->sg[i].t2_desc)
+				dma_pool_free(c->desc_pool, d->sg[i].t2_desc,
+					      d->sg[i].t2_desc_paddr);
+		}
+	}
+
+	kfree(d);
+}
+
+static void omap_dma_fill_type2_desc(struct omap_desc *d, int idx,
+				     enum dma_transfer_direction dir, bool last)
+{
+	struct omap_sg *sg = &d->sg[idx];
+	struct omap_type2_desc *t2_desc = sg->t2_desc;
+
+	if (idx)
+		d->sg[idx - 1].t2_desc->next_desc = sg->t2_desc_paddr;
+	if (last)
+		t2_desc->next_desc = 0xfffffffc;
+
+	t2_desc->en = sg->en;
+	t2_desc->addr = sg->addr;
+	t2_desc->fn = sg->fn & 0xffff;
+	t2_desc->cicr = d->cicr;
+	if (!last)
+		t2_desc->cicr &= ~CICR_BLOCK_IE;
+
+	switch (dir) {
+	case DMA_DEV_TO_MEM:
+		t2_desc->cdei = sg->ei;
+		t2_desc->csei = d->ei;
+		t2_desc->cdfi = sg->fi;
+		t2_desc->csfi = d->fi;
+
+		t2_desc->en |= DESC_NXT_DV_REFRESH;
+		t2_desc->en |= DESC_NXT_SV_REUSE;
+		break;
+	case DMA_MEM_TO_DEV:
+		t2_desc->cdei = d->ei;
+		t2_desc->csei = sg->ei;
+		t2_desc->cdfi = d->fi;
+		t2_desc->csfi = sg->fi;
+
+		t2_desc->en |= DESC_NXT_SV_REFRESH;
+		t2_desc->en |= DESC_NXT_DV_REUSE;
+		break;
+	default:
+		return;
+	}
+
+	t2_desc->en |= DESC_NTYPE_TYPE2;
 }
 
 static void omap_dma_write(uint32_t val, unsigned type, void __iomem *addr)
@@ -285,6 +386,7 @@ static void omap_dma_assign(struct omap_dmadev *od, struct omap_chan *c,
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
+	uint16_t cicr = d->cicr;
 
 	if (__dma_omap15xx(od->plat->dma_attr))
 		omap_dma_chan_write(c, CPC, 0);
@@ -293,8 +395,27 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 
 	omap_dma_clear_csr(c);
 
+	if (d->using_ll) {
+		uint32_t cdp = CDP_TMODE_LLIST | CDP_NTYPE_TYPE2 | CDP_FAST;
+
+		if (d->dir == DMA_DEV_TO_MEM)
+			cdp |= (CDP_DST_VALID_RELOAD | CDP_SRC_VALID_REUSE);
+		else
+			cdp |= (CDP_DST_VALID_REUSE | CDP_SRC_VALID_RELOAD);
+		omap_dma_chan_write(c, CDP, cdp);
+
+		omap_dma_chan_write(c, CNDP, d->sg[0].t2_desc_paddr);
+		omap_dma_chan_write(c, CCDN, 0);
+		omap_dma_chan_write(c, CCFN, 0xffff);
+		omap_dma_chan_write(c, CCEN, 0xffffff);
+
+		cicr &= ~CICR_BLOCK_IE;
+	} else if (od->ll123_supported) {
+		omap_dma_chan_write(c, CDP, 0);
+	}
+
 	/* Enable interrupts */
-	omap_dma_chan_write(c, CICR, d->cicr);
+	omap_dma_chan_write(c, CICR, cicr);
 
 	/* Enable channel */
 	omap_dma_chan_write(c, CCR, d->ccr | CCR_ENABLE);
@@ -447,7 +568,7 @@ static void omap_dma_callback(int ch, u16 status, void *data)
 	if (d) {
 		if (c->cyclic) {
 			vchan_cyclic_callback(&d->vd);
-		} else if (c->sgidx == d->sglen) {
+		} else if (d->using_ll || c->sgidx == d->sglen) {
 			vchan_cookie_complete(&d->vd);
 			omap_dma_start_desc(c);
 		} else {
@@ -501,8 +622,19 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
 	struct omap_chan *c = to_omap_dma_chan(chan);
+	struct device *dev = od->ddev.dev;
 	int ret;
 
+	if (od->ll123_supported) {
+		c->desc_pool = dma_pool_create(dev_name(dev), dev,
+					       sizeof(struct omap_type2_desc),
+					       4, 0);
+		if (!c->desc_pool) {
+			dev_err(dev, "unable to allocate descriptor pool\n");
+			return -ENOMEM;
+		}
+	}
+
 	if (od->legacy) {
 		ret = omap_request_dma(c->dma_sig, "DMA engine",
 				       omap_dma_callback, c, &c->dma_ch);
@@ -511,8 +643,7 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 				       &c->dma_ch);
 	}
 
-	dev_dbg(od->ddev.dev, "allocating channel %u for %u\n",
-		c->dma_ch, c->dma_sig);
+	dev_dbg(dev, "allocating channel %u for %u\n", c->dma_ch, c->dma_sig);
 
 	if (ret >= 0) {
 		omap_dma_assign(od, c, c->dma_ch);
@@ -567,6 +698,8 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	od->lch_map[c->dma_ch] = NULL;
 	vchan_free_chan_resources(&c->vc);
 	omap_free_dma(c->dma_ch);
+	if (od->ll123_supported)
+		dma_pool_destroy(c->desc_pool);
 
 	dev_dbg(od->ddev.dev, "freeing channel %u used for %u\n", c->dma_ch,
 		c->dma_sig);
@@ -743,6 +876,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	struct omap_desc *d;
 	dma_addr_t dev_addr;
 	unsigned i, es, en, frame_bytes;
+	bool ll_failed = false;
 	u32 burst;
 
 	if (dir == DMA_DEV_TO_MEM) {
@@ -778,6 +912,8 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	if (!d)
 		return NULL;
 
+	d->c = c;
+
 	d->dir = dir;
 	d->dev_addr = dev_addr;
 	d->es = es;
@@ -818,16 +954,47 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	 */
 	en = burst;
 	frame_bytes = es_bytes[es] * en;
+
+	if (sglen >= 2)
+		d->using_ll = od->ll123_supported;
+
 	for_each_sg(sgl, sgent, sglen, i) {
 		struct omap_sg *osg = &d->sg[i];
 
 		osg->addr = sg_dma_address(sgent);
 		osg->en = en;
 		osg->fn = sg_dma_len(sgent) / frame_bytes;
+
+		if (d->using_ll) {
+			osg->t2_desc = dma_pool_alloc(c->desc_pool, GFP_ATOMIC,
+						      &osg->t2_desc_paddr);
+			if (!osg->t2_desc) {
+				dev_err(chan->device->dev,
+					"t2_desc[%d] allocation failed\n", i);
+				ll_failed = true;
+				d->using_ll = false;
+				continue;
+			}
+
+			omap_dma_fill_type2_desc(d, i, dir, (i == sglen - 1));
+		}
 	}
 
 	d->sglen = sglen;
 
+	/* Release the dma_pool entries if one allocation failed */
+	if (ll_failed) {
+		for (i = 0; i < d->sglen; i++) {
+			struct omap_sg *osg = &d->sg[i];
+
+			if (osg->t2_desc) {
+				dma_pool_free(c->desc_pool, osg->t2_desc,
+					      osg->t2_desc_paddr);
+				osg->t2_desc = NULL;
+			}
+		}
+	}
+
 	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
 }
 
@@ -1266,6 +1433,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 			return rc;
 	}
 
+	if (omap_dma_glbl_read(od, CAPS_0) & CAPS_0_SUPPORT_LL123)
+		od->ll123_supported = true;
+
 	od->ddev.filter.map = od->plat->slave_map;
 	od->ddev.filter.mapcnt = od->plat->slavecnt;
 	od->ddev.filter.fn = omap_dma_filter_fn;
@@ -1293,7 +1463,8 @@ static int omap_dma_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_info(&pdev->dev, "OMAP DMA engine driver\n");
+	dev_info(&pdev->dev, "OMAP DMA engine driver%s\n",
+		 od->ll123_supported ? " (LinkedList1/2/3 supported)" : "");
 
 	return rc;
 }
-- 
2.9.1
