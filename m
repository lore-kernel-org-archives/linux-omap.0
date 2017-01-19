From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 3/3] usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in dsps
Date: Thu, 19 Jan 2017 11:06:59 +0100
Message-ID: <20170119100659.11370-4-abailon@baylibre.com>
References: <20170119100659.11370-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119100659.11370-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Despite the CPPI 4.1 is a generic DMA, it is tied to USB.
On the dsps, CPPI 4.1 interrupt's registers are in USBSS (the MUSB glue).
Currently, to enable / disable and clear interrupts, the CPPI 4.1 driver
maps and accesses to USBSS's register, which making CPPI 4.1 driver not
really generic.
Move the interrupt management to dsps driver.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c         | 28 ++++------------
 drivers/usb/musb/musb_dsps.c | 77 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index d5ba43a..4999e7d 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -79,14 +79,6 @@
 #define QMGR_QUEUE_C(n)	(0x2008 + (n) * 0x10)
 #define QMGR_QUEUE_D(n)	(0x200c + (n) * 0x10)
 
-/* Glue layer specific */
-/* USBSS  / USB AM335x */
-#define USBSS_IRQ_STATUS	0x28
-#define USBSS_IRQ_ENABLER	0x2c
-#define USBSS_IRQ_CLEARR	0x30
-
-#define USBSS_IRQ_PD_COMP	(1 <<  2)
-
 /* Packet Descriptor */
 #define PD2_ZERO_LENGTH		(1 << 19)
 
@@ -288,14 +280,8 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 {
 	struct cppi41_dd *cdd = data;
 	struct cppi41_channel *c;
-	u32 status;
 	int i;
 
-	status = cppi_readl(cdd->usbss_mem + USBSS_IRQ_STATUS);
-	if (!(status & USBSS_IRQ_PD_COMP))
-		return IRQ_NONE;
-	cppi_writel(status, cdd->usbss_mem + USBSS_IRQ_STATUS);
-
 	for (i = QMGR_PENDING_SLOT_Q(FIST_COMPLETION_QUEUE); i < QMGR_NUM_PEND;
 			i++) {
 		u32 val;
@@ -599,6 +585,7 @@ static void cppi41_compute_td_desc(struct cppi41_desc *d)
 
 static int cppi41_tear_down_chan(struct cppi41_channel *c)
 {
+	struct dmaengine_result abort_result;
 	struct cppi41_dd *cdd = c->cdd;
 	struct cppi41_desc *td;
 	u32 reg;
@@ -682,6 +669,12 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
 	c->td_seen = 0;
 	c->td_desc_seen = 0;
 	cppi_writel(0, c->gcr_reg);
+
+	/* Invoke the callback to do the necessary clean-up */
+	abort_result.result = DMA_TRANS_ABORTED;
+	dma_cookie_complete(&c->txd);
+	dmaengine_desc_get_callback_invoke(&c->txd, &abort_result);
+
 	return 0;
 }
 
@@ -1044,8 +1037,6 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
-
 	ret = devm_request_irq(&pdev->dev, irq, glue_info->isr, IRQF_SHARED,
 			dev_name(dev), cdd);
 	if (ret)
@@ -1069,7 +1060,6 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&cdd->ddev);
 err_dma_reg:
 err_irq:
-	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	cleanup_chans(cdd);
 err_chans:
 	deinit_cppi41(dev, cdd);
@@ -1097,7 +1087,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&cdd->ddev);
 
-	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	devm_free_irq(&pdev->dev, cdd->irq, cdd);
 	cleanup_chans(cdd);
 	deinit_cppi41(&pdev->dev, cdd);
@@ -1116,7 +1105,6 @@ static int __maybe_unused cppi41_suspend(struct device *dev)
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
 
 	cdd->dma_tdfdq = cppi_readl(cdd->ctrl_mem + DMA_TDFDQ);
-	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	disable_sched(cdd);
 
 	return 0;
@@ -1142,8 +1130,6 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 	cppi_writel(QMGR_SCRATCH_SIZE, cdd->qmgr_mem + QMGR_LRAM_SIZE);
 	cppi_writel(0, cdd->qmgr_mem + QMGR_LRAM1_BASE);
 
-	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
-
 	return 0;
 }
 
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 9f125e1..9dad3a6 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -121,6 +121,7 @@ struct dsps_glue {
 	struct timer_list timer;	/* otg_workaround timer */
 	unsigned long last_timer;    /* last timer data for each instance */
 	bool sw_babble_enabled;
+	void __iomem *usbss_base;
 
 	struct dsps_context context;
 	struct debugfs_regset32 regset;
@@ -145,6 +146,13 @@ static const struct debugfs_reg32 dsps_musb_regs[] = {
 	{ "mode",		0xe8 },
 };
 
+/* USBSS  / USB AM335x */
+#define USBSS_IRQ_STATUS	0x28
+#define USBSS_IRQ_ENABLER	0x2c
+#define USBSS_IRQ_CLEARR	0x30
+
+#define USBSS_IRQ_PD_COMP	(1 <<  2)
+
 /**
  * dsps_musb_enable - enable interrupts
  */
@@ -619,14 +627,72 @@ static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 	}
 }
 
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+static void dsps_dma_controller_callback(struct dma_controller *c)
+{
+	struct musb *musb = c->musb;
+	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
+	void __iomem *usbss_base = glue->usbss_base;
+	u32 status;
+
+	status = musb_readl(usbss_base, USBSS_IRQ_STATUS);
+	if (status & USBSS_IRQ_PD_COMP)
+		musb_writel(usbss_base, USBSS_IRQ_STATUS, USBSS_IRQ_PD_COMP);
+}
+
+static struct dma_controller *
+dsps_dma_controller_create(struct musb *musb, void __iomem *base)
+{
+	struct dma_controller *controller;
+	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
+	void __iomem *usbss_base = glue->usbss_base;
+
+	controller = cppi41_dma_controller_create(musb, base);
+	if (IS_ERR_OR_NULL(controller))
+		return controller;
+
+	musb_writel(usbss_base, USBSS_IRQ_ENABLER, USBSS_IRQ_PD_COMP);
+	controller->dma_callback = dsps_dma_controller_callback;
+
+	return controller;
+}
+
+static void dsps_dma_controller_destroy(struct dma_controller *c)
+{
+	struct musb *musb = c->musb;
+	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
+	void __iomem *usbss_base = glue->usbss_base;
+
+	musb_writel(usbss_base, USBSS_IRQ_CLEARR, USBSS_IRQ_PD_COMP);
+	cppi41_dma_controller_destroy(c);
+}
+
+static void dsps_dma_controller_suspend(struct dsps_glue *glue)
+{
+	void __iomem *usbss_base = glue->usbss_base;
+
+	musb_writel(usbss_base, USBSS_IRQ_CLEARR, USBSS_IRQ_PD_COMP);
+}
+
+static void dsps_dma_controller_resume(struct dsps_glue *glue)
+{
+	void __iomem *usbss_base = glue->usbss_base;
+
+	musb_writel(usbss_base, USBSS_IRQ_ENABLER, USBSS_IRQ_PD_COMP);
+}
+#else
+static void dsps_dma_controller_suspend(struct dsps_glue *glue) {}
+static void dsps_dma_controller_resume(struct dsps_glue *glue) {}
+#endif
+
 static struct musb_platform_ops dsps_ops = {
 	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
 	.init		= dsps_musb_init,
 	.exit		= dsps_musb_exit,
 
 #ifdef CONFIG_USB_TI_CPPI41_DMA
-	.dma_init	= cppi41_dma_controller_create,
-	.dma_exit	= cppi41_dma_controller_destroy,
+	.dma_init	= dsps_dma_controller_create,
+	.dma_exit	= dsps_dma_controller_destroy,
 #endif
 	.enable		= dsps_musb_enable,
 	.disable	= dsps_musb_disable,
@@ -792,6 +858,9 @@ static int dsps_probe(struct platform_device *pdev)
 
 	glue->dev = &pdev->dev;
 	glue->wrp = wrp;
+	glue->usbss_base = of_iomap(pdev->dev.parent->of_node, 0);
+	if (!glue->usbss_base)
+		return -ENXIO;
 
 	platform_set_drvdata(pdev, glue);
 	pm_runtime_enable(&pdev->dev);
@@ -880,6 +949,8 @@ static int dsps_suspend(struct device *dev)
 	glue->context.tx_mode = musb_readl(mbase, wrp->tx_mode);
 	glue->context.rx_mode = musb_readl(mbase, wrp->rx_mode);
 
+	dsps_dma_controller_suspend(glue);
+
 	return 0;
 }
 
@@ -893,6 +964,8 @@ static int dsps_resume(struct device *dev)
 	if (!musb)
 		return 0;
 
+	dsps_dma_controller_resume(glue);
+
 	mbase = musb->ctrl_base;
 	musb_writel(mbase, wrp->control, glue->context.control);
 	musb_writel(mbase, wrp->epintr_set, glue->context.epintr);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
