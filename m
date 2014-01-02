From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 02/26] dmaengine: omap-dma: provide a hook to get the
 underlying DMA platform ops
Date: Thu, 02 Jan 2014 15:09:09 +0000
Message-ID: <E1VyjtV-0005E1-No@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-omap@vger.kernel.org

Provide and use a hook to obtain the underlying DMA platform operations
so that omap-dma.c can access the hardware more directly without
involving the legacy DMA driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/dma.c |    6 ++++++
 drivers/dma/omap-dma.c   |    7 +++++++
 include/linux/omap-dma.h |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 01619c2910e3..d4d9a5e62152 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2000,6 +2000,12 @@ void omap_dma_global_context_restore(void)
 			omap_clear_dma(ch);
 }
 
+struct omap_system_dma_plat_info *omap_get_plat_info(void)
+{
+	return p;
+}
+EXPORT_SYMBOL_GPL(omap_get_plat_info);
+
 static int omap_system_dma_probe(struct platform_device *pdev)
 {
 	int ch, ret = 0;
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index d9349be33bdf..3c1bb34aad0a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -26,11 +26,13 @@ struct omap_dmadev {
 	spinlock_t lock;
 	struct tasklet_struct task;
 	struct list_head pending;
+	struct omap_system_dma_plat_info *plat;
 };
 
 struct omap_chan {
 	struct virt_dma_chan vc;
 	struct list_head node;
+	struct omap_system_dma_plat_info *plat;
 
 	struct dma_slave_config	cfg;
 	unsigned dma_sig;
@@ -573,6 +575,7 @@ static int omap_dma_chan_init(struct omap_dmadev *od, int dma_sig)
 	if (!c)
 		return -ENOMEM;
 
+	c->plat = od->plat;
 	c->dma_sig = dma_sig;
 	c->vc.desc_free = omap_dma_desc_free;
 	vchan_init(&c->vc, &od->ddev);
@@ -605,6 +608,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (!od)
 		return -ENOMEM;
 
+	od->plat = omap_get_plat_info();
+	if (!od->plat)
+		return -EPROBE_DEFER;
+
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 7af25a9c9c51..14742fc2aefe 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -292,6 +292,8 @@ struct omap_system_dma_plat_info {
 #define dma_omap15xx()	((dma_omap1() && (d->dev_caps & ENABLE_1510_MODE)))
 #define dma_omap16xx()	((dma_omap1() && (d->dev_caps & ENABLE_16XX_MODE)))
 
+extern struct omap_system_dma_plat_info *omap_get_plat_info(void);
+
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
-- 
1.7.4.4
