From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] usb: musb: Set up function pointers for DMA
Date: Fri,  1 May 2015 12:29:28 -0700
Message-ID: <1430508578-5208-3-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i773.relay.mailchannels.net ([50.61.143.73]:36011 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751885AbbEATgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:36:10 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Set up function pointers for DMA so get closer to
being able to build in all the DMA engines.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/am35x.c         |  4 ++++
 drivers/usb/musb/blackfin.c      |  4 ++++
 drivers/usb/musb/cppi_dma.c      |  9 ++++++---
 drivers/usb/musb/da8xx.c         |  4 ++++
 drivers/usb/musb/davinci.c       |  4 ++++
 drivers/usb/musb/jz4740.c        |  4 ++++
 drivers/usb/musb/musb_core.c     | 25 ++++++++++++++++++++++---
 drivers/usb/musb/musb_core.h     |  5 +++++
 drivers/usb/musb/musb_cppi41.c   |  8 +++++---
 drivers/usb/musb/musb_dma.h      | 32 +++++++++++++++++++++++++++-----
 drivers/usb/musb/musb_dsps.c     |  4 ++++
 drivers/usb/musb/musbhsdma.c     |  9 ++++++---
 drivers/usb/musb/omap2430.c      |  4 ++++
 drivers/usb/musb/tusb6010.c      |  4 ++++
 drivers/usb/musb/tusb6010_omap.c |  9 ++++++---
 drivers/usb/musb/ux500.c         |  4 ++++
 drivers/usb/musb/ux500_dma.c     |  8 +++++---
 17 files changed, 118 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 72ce2e8..6cfd43a 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -443,6 +443,10 @@ static const struct musb_platform_ops am35x_ops = {
 	.exit		= am35x_musb_exit,
 
 	.read_fifo	= am35x_read_fifo,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init	= musbhs_dma_controller_create,
+	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
 	.enable		= am35x_musb_enable,
 	.disable	= am35x_musb_disable,
 
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 2a73a73..310238c 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -478,6 +478,10 @@ static const struct musb_platform_ops bfin_ops = {
 	.fifo_mode	= 2,
 	.read_fifo	= bfin_read_fifo,
 	.write_fifo	= bfin_write_fifo,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init	= musbhs_dma_controller_create,
+	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
 	.enable		= bfin_musb_enable,
 	.disable	= bfin_musb_disable,
 
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 904fb85..cc13410 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1297,7 +1297,8 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 EXPORT_SYMBOL_GPL(cppi_interrupt);
 
 /* Instantiate a software object representing a DMA controller. */
-struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *mregs)
+struct dma_controller *
+cppi_dma_controller_create(struct musb *musb, void __iomem *mregs)
 {
 	struct cppi		*controller;
 	struct device		*dev = musb->controller;
@@ -1334,7 +1335,7 @@ struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *mr
 	if (irq > 0) {
 		if (request_irq(irq, cppi_interrupt, 0, "cppi-dma", musb)) {
 			dev_err(dev, "request_irq %d failed!\n", irq);
-			dma_controller_destroy(&controller->controller);
+			musb_dma_controller_destroy(&controller->controller);
 			return NULL;
 		}
 		controller->irq = irq;
@@ -1343,11 +1344,12 @@ struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *mr
 	cppi_controller_start(controller);
 	return &controller->controller;
 }
+EXPORT_SYMBOL_GPL(cppi_dma_controller_create);
 
 /*
  *  Destroy a previously-instantiated DMA controller.
  */
-void dma_controller_destroy(struct dma_controller *c)
+void cppi_dma_controller_destroy(struct dma_controller *c)
 {
 	struct cppi	*cppi;
 
@@ -1363,6 +1365,7 @@ void dma_controller_destroy(struct dma_controller *c)
 
 	kfree(cppi);
 }
+EXPORT_SYMBOL_GPL(cppi_dma_controller_destroy);
 
 /*
  * Context: controller irqlocked, endpoint selected
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 06c442c..b03d3b8 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -463,6 +463,10 @@ static const struct musb_platform_ops da8xx_ops = {
 	.exit		= da8xx_musb_exit,
 
 	.fifo_mode	= 2,
+#ifdef CONFIG_USB_TI_CPPI_DMA
+	.dma_init	= cppi_dma_controller_create,
+	.dma_exit	= cppi_dma_controller_destroy,
+#endif
 	.enable		= da8xx_musb_enable,
 	.disable	= da8xx_musb_disable,
 
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 26bfdb3..cee61a5 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -495,6 +495,10 @@ static const struct musb_platform_ops davinci_ops = {
 	.init		= davinci_musb_init,
 	.exit		= davinci_musb_exit,
 
+#ifdef CONFIG_USB_TI_CPPI_DMA
+	.dma_init	= cppi_dma_controller_create,
+	.dma_exit	= cppi_dma_controller_destroy,
+#endif
 	.enable		= davinci_musb_enable,
 	.disable	= davinci_musb_disable,
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index b7b5fdc..5e5a8fa 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -105,6 +105,10 @@ static int jz4740_musb_exit(struct musb *musb)
 	return 0;
 }
 
+/*
+ * DMA has not been confirmed to work with CONFIG_USB_INVENTRA_DMA,
+ * so let's not set up the dma function pointers yet.
+ */
 static const struct musb_platform_ops jz4740_musb_ops = {
 	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.fifo_mode	= 2,
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 4ac060a..5f35ecdc 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -389,6 +389,15 @@ EXPORT_SYMBOL_GPL(musb_readl);
 void (*musb_writel)(void __iomem *addr, unsigned offset, u32 data);
 EXPORT_SYMBOL_GPL(musb_writel);
 
+#ifndef CONFIG_MUSB_PIO_ONLY
+struct dma_controller *
+(*musb_dma_controller_create)(struct musb *musb, void __iomem *base);
+EXPORT_SYMBOL(musb_dma_controller_create);
+
+void (*musb_dma_controller_destroy)(struct dma_controller *c);
+EXPORT_SYMBOL(musb_dma_controller_destroy);
+#endif
+
 /*
  * New style IO functions
  */
@@ -2059,6 +2068,15 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (musb->ops->writel)
 		musb_writel = musb->ops->writel;
 
+#ifndef CONFIG_MUSB_PIO_ONLY
+	if (!musb->ops->dma_init || !musb->ops->dma_exit) {
+		dev_err(dev, "DMA controller not set\n");
+		goto fail2;
+	}
+	musb_dma_controller_create = musb->ops->dma_init;
+	musb_dma_controller_destroy = musb->ops->dma_exit;
+#endif
+
 	if (musb->ops->read_fifo)
 		musb->io.read_fifo = musb->ops->read_fifo;
 	else
@@ -2078,7 +2096,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	pm_runtime_get_sync(musb->controller);
 
 	if (use_dma && dev->dma_mask) {
-		musb->dma_controller = dma_controller_create(musb, musb->mregs);
+		musb->dma_controller =
+			musb_dma_controller_create(musb, musb->mregs);
 		if (IS_ERR(musb->dma_controller)) {
 			status = PTR_ERR(musb->dma_controller);
 			goto fail2_5;
@@ -2189,7 +2208,7 @@ fail3:
 	cancel_delayed_work_sync(&musb->finish_resume_work);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	if (musb->dma_controller)
-		dma_controller_destroy(musb->dma_controller);
+		musb_dma_controller_destroy(musb->dma_controller);
 fail2_5:
 	pm_runtime_put_sync(musb->controller);
 
@@ -2248,7 +2267,7 @@ static int musb_remove(struct platform_device *pdev)
 	musb_shutdown(pdev);
 
 	if (musb->dma_controller)
-		dma_controller_destroy(musb->dma_controller);
+		musb_dma_controller_destroy(musb->dma_controller);
 
 	cancel_work_sync(&musb->irq_work);
 	cancel_delayed_work_sync(&musb->finish_resume_work);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 3877249..c7a0d93 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -157,6 +157,8 @@ struct musb_io;
  * @writel:	write 32 bits
  * @read_fifo:	reads the fifo
  * @write_fifo:	writes to fifo
+ * @dma_init:	platform specific dma init function
+ * @dma_exit:	platform specific dma exit function
  * @init:	turns on clocks, sets up platform-specific registers, etc
  * @exit:	undoes @init
  * @set_mode:	forcefully changes operating mode
@@ -195,6 +197,9 @@ struct musb_platform_ops {
 	void	(*writel)(void __iomem *addr, unsigned offset, u32 data);
 	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
 	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
+	struct dma_controller *
+		(*dma_init) (struct musb *musb, void __iomem *base);
+	void	(*dma_exit)(struct dma_controller *c);
 	int	(*set_mode)(struct musb *musb, u8 mode);
 	void	(*try_idle)(struct musb *musb, unsigned long timeout);
 	int	(*recover)(struct musb *musb);
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 8bd8c5e..4d1b44c 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -678,7 +678,7 @@ err:
 	return ret;
 }
 
-void dma_controller_destroy(struct dma_controller *c)
+void cppi41_dma_controller_destroy(struct dma_controller *c)
 {
 	struct cppi41_dma_controller *controller = container_of(c,
 			struct cppi41_dma_controller, controller);
@@ -687,9 +687,10 @@ void dma_controller_destroy(struct dma_controller *c)
 	cppi41_dma_controller_stop(controller);
 	kfree(controller);
 }
+EXPORT_SYMBOL_GPL(cppi41_dma_controller_destroy);
 
-struct dma_controller *dma_controller_create(struct musb *musb,
-					void __iomem *base)
+struct dma_controller *
+cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	struct cppi41_dma_controller *controller;
 	int ret = 0;
@@ -726,3 +727,4 @@ kzalloc_fail:
 		return ERR_PTR(ret);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(cppi41_dma_controller_create);
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 555f2ae..46357e1 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -202,19 +202,41 @@ struct dma_controller {
 extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit);
 
 #ifdef CONFIG_MUSB_PIO_ONLY
-static inline struct dma_controller *dma_controller_create(struct musb *m,
-		void __iomem *io)
+static inline struct dma_controller *
+musb_dma_controller_create(struct musb *m, void __iomem *io)
 {
 	return NULL;
 }
 
-static inline void dma_controller_destroy(struct dma_controller *d) { }
+static inline void musb_dma_controller_destroy(struct dma_controller *d) { }
 
 #else
 
-extern struct dma_controller *dma_controller_create(struct musb *, void __iomem *);
+extern struct dma_controller *
+(*musb_dma_controller_create)(struct musb *, void __iomem *);
 
-extern void dma_controller_destroy(struct dma_controller *);
+extern void (*musb_dma_controller_destroy)(struct dma_controller *);
 #endif
 
+/* Platform specific DMA functions */
+extern struct dma_controller *
+musbhs_dma_controller_create(struct musb *musb, void __iomem *base);
+extern void musbhs_dma_controller_destroy(struct dma_controller *c);
+
+extern struct dma_controller *
+tusb_dma_controller_create(struct musb *musb, void __iomem *base);
+extern void tusb_dma_controller_destroy(struct dma_controller *c);
+
+extern struct dma_controller *
+cppi_dma_controller_create(struct musb *musb, void __iomem *base);
+extern void cppi_dma_controller_destroy(struct dma_controller *c);
+
+extern struct dma_controller *
+cppi41_dma_controller_create(struct musb *musb, void __iomem *base);
+extern void cppi41_dma_controller_destroy(struct dma_controller *c);
+
+extern struct dma_controller *
+ux500_dma_controller_create(struct musb *musb, void __iomem *base);
+extern void ux500_dma_controller_destroy(struct dma_controller *c);
+
 #endif	/* __MUSB_DMA_H__ */
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 63a8d5b..1334a3d 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -638,6 +638,10 @@ static struct musb_platform_ops dsps_ops = {
 	.init		= dsps_musb_init,
 	.exit		= dsps_musb_exit,
 
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+	.dma_init	= cppi41_dma_controller_create,
+	.dma_exit	= cppi41_dma_controller_destroy,
+#endif
 	.enable		= dsps_musb_enable,
 	.disable	= dsps_musb_disable,
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index ab7ec09..7539c31 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -357,7 +357,7 @@ done:
 	return retval;
 }
 
-void dma_controller_destroy(struct dma_controller *c)
+void musbhs_dma_controller_destroy(struct dma_controller *c)
 {
 	struct musb_dma_controller *controller = container_of(c,
 			struct musb_dma_controller, controller);
@@ -369,8 +369,10 @@ void dma_controller_destroy(struct dma_controller *c)
 
 	kfree(controller);
 }
+EXPORT_SYMBOL_GPL(musbhs_dma_controller_destroy);
 
-struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *base)
+struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
+						    void __iomem *base)
 {
 	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
@@ -398,7 +400,7 @@ struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *ba
 	if (request_irq(irq, dma_controller_irq, 0,
 			dev_name(musb->controller), &controller->controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
-		dma_controller_destroy(&controller->controller);
+		musb_dma_controller_destroy(&controller->controller);
 
 		return NULL;
 	}
@@ -407,3 +409,4 @@ struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *ba
 
 	return &controller->controller;
 }
+EXPORT_SYMBOL_GPL(musbhs_dma_controller_create);
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5546a22..70f2b8a 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -494,6 +494,10 @@ static int omap2430_musb_exit(struct musb *musb)
 
 static const struct musb_platform_ops omap2430_ops = {
 	.quirks		= MUSB_DMA_INVENTRA,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init	= musbhs_dma_controller_create,
+	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
 	.init		= omap2430_musb_init,
 	.exit		= omap2430_musb_exit,
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index af923de..df7c9f4 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1192,6 +1192,10 @@ static const struct musb_platform_ops tusb_ops = {
 	.writeb		= tusb_writeb,
 	.read_fifo	= tusb_read_fifo,
 	.write_fifo	= tusb_write_fifo,
+#ifdef CONFIG_USB_TUSB_OMAP_DMA
+	.dma_init	= tusb_dma_controller_create,
+	.dma_exit	= tusb_dma_controller_destroy,
+#endif
 	.enable		= tusb_musb_enable,
 	.disable	= tusb_musb_disable,
 
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 3ce152c..4c82077 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -625,7 +625,7 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 	channel = NULL;
 }
 
-void dma_controller_destroy(struct dma_controller *c)
+void tusb_dma_controller_destroy(struct dma_controller *c)
 {
 	struct tusb_omap_dma	*tusb_dma;
 	int			i;
@@ -644,8 +644,10 @@ void dma_controller_destroy(struct dma_controller *c)
 
 	kfree(tusb_dma);
 }
+EXPORT_SYMBOL_GPL(tusb_dma_controller_destroy);
 
-struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *base)
+struct dma_controller *
+tusb_dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	void __iomem		*tbase = musb->ctrl_base;
 	struct tusb_omap_dma	*tusb_dma;
@@ -701,7 +703,8 @@ struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *ba
 	return &tusb_dma->controller;
 
 cleanup:
-	dma_controller_destroy(&tusb_dma->controller);
+	musb_dma_controller_destroy(&tusb_dma->controller);
 out:
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(tusb_dma_controller_create);
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index c6582f1..2967b51 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -189,6 +189,10 @@ static int ux500_musb_exit(struct musb *musb)
 
 static const struct musb_platform_ops ux500_ops = {
 	.quirks		= MUSB_DMA_UX500 | MUSB_INDEXED_EP,
+#ifdef CONFIG_USB_UX500_DMA
+	.dma_init	= ux500_dma_controller_create,
+	.dma_exit	= ux500_dma_controller_destroy,
+#endif
 	.init		= ux500_musb_init,
 	.exit		= ux500_musb_exit,
 	.fifo_mode	= 5,
diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index e93845c..d0b6a1c 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -359,7 +359,7 @@ static int ux500_dma_controller_start(struct ux500_dma_controller *controller)
 	return 0;
 }
 
-void dma_controller_destroy(struct dma_controller *c)
+void ux500_dma_controller_destroy(struct dma_controller *c)
 {
 	struct ux500_dma_controller *controller = container_of(c,
 			struct ux500_dma_controller, controller);
@@ -367,9 +367,10 @@ void dma_controller_destroy(struct dma_controller *c)
 	ux500_dma_controller_stop(controller);
 	kfree(controller);
 }
+EXPORT_SYMBOL_GPL(ux500_dma_controller_destroy);
 
-struct dma_controller *dma_controller_create(struct musb *musb,
-					void __iomem *base)
+struct dma_controller *
+ux500_dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	struct ux500_dma_controller *controller;
 	struct platform_device *pdev = to_platform_device(musb->controller);
@@ -407,3 +408,4 @@ plat_get_fail:
 kzalloc_fail:
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ux500_dma_controller_create);
-- 
2.1.4

