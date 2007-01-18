From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.20-rc5-omap] musb_hdrc, more runtime code shrinkage
Date: Thu, 18 Jan 2007 04:04:37 -0800
Message-ID: <20070118120437.8578520E7F7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Remove the annoying "singleton object" dma controller factory in favor
of a simpler scheme of direct calls to routines creating and destroying
those controller objects.  Init routines now live in the init section,
shrinking the runtime footprint by a bit.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: d26/drivers/usb/musb/dma.h
===================================================================
--- d26.orig/drivers/usb/musb/dma.h	2007-01-18 03:29:43.000000000 -0800
+++ d26/drivers/usb/musb/dma.h	2007-01-18 03:45:00.000000000 -0800
@@ -178,21 +178,9 @@ struct dma_controller {
 extern void musb_dma_completion(struct musb *musb, u8 bLocalEnd, u8 bTransmit);
 
 
-/**
- * struct dma_controller_factory - DMA controller factory
- * @create: create a DMA controller
- * @destroy: destroy a DMA controller
- *
- * To allow for multi-core implementations and different
- * types of cores and DMA controllers to co-exist,
- * (only at the source level; no runtime coexistence supported)
- * it is necessary to create them from factories.
- */
-struct dma_controller_factory {
-	struct dma_controller	*(*create)(struct musb *, void __iomem *);
-	void			(*destroy)(struct dma_controller *);
-};
+extern struct dma_controller *__init
+dma_controller_create(struct musb *, void __iomem *);
 
-extern const struct dma_controller_factory dma_controller_factory;
+extern void dma_controller_destroy(struct dma_controller *);
 
 #endif	/* __MUSB_DMA_H__ */
Index: d26/drivers/usb/musb/plat_uds.c
===================================================================
--- d26.orig/drivers/usb/musb/plat_uds.c	2007-01-18 03:44:25.000000000 -0800
+++ d26/drivers/usb/musb/plat_uds.c	2007-01-18 03:56:29.000000000 -0800
@@ -1616,7 +1616,7 @@ static void musb_free(struct musb *musb)
 		struct dma_controller	*c = musb->pDmaController;
 
 		(void) c->stop(c->pPrivateData);
-		dma_controller_factory.destroy(c);
+		dma_controller_destroy(c);
 	}
 
 	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
@@ -1710,10 +1710,7 @@ musb_init_controller(struct device *dev,
 	if (use_dma && dev->dma_mask) {
 		struct dma_controller	*c;
 
-// FIXME get rid of dma_controller_factory and just call the methods
-// directly ... then create() can be in the init section, etc
-
-		c = dma_controller_factory.create(pThis, pThis->pRegs);
+		c = dma_controller_create(pThis, pThis->pRegs);
 		pThis->pDmaController = c;
 		if (c)
 			(void) c->start(c->pPrivateData);
Index: d26/drivers/usb/musb/tusb6010_omap.c
===================================================================
--- d26.orig/drivers/usb/musb/tusb6010_omap.c	2007-01-18 03:29:43.000000000 -0800
+++ d26/drivers/usb/musb/tusb6010_omap.c	2007-01-18 03:45:00.000000000 -0800
@@ -600,7 +600,7 @@ static void tusb_omap_dma_release(struct
 	channel = NULL;
 }
 
-static void tusb_omap_dma_cleanup(struct dma_controller *c)
+void dma_controller_destroy(struct dma_controller *c)
 {
 	struct tusb_omap_dma	*tusb_dma;
 	int			i;
@@ -621,8 +621,8 @@ static void tusb_omap_dma_cleanup(struct
 	kfree(tusb_dma);
 }
 
-static struct dma_controller *
-tusb_omap_dma_init(struct musb *musb, void __iomem *base)
+struct dma_controller *__init
+dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	void __iomem		*tusb_base = musb->ctrl_base;
 	struct tusb_omap_dma	*tusb_dma;
@@ -678,12 +678,7 @@ tusb_omap_dma_init(struct musb *musb, vo
 	return &tusb_dma->controller;
 
 cleanup:
-	tusb_omap_dma_cleanup(&tusb_dma->controller);
+	dma_controller_destroy(&tusb_dma->controller);
 
 	return NULL;
 }
-
-const struct dma_controller_factory dma_controller_factory = {
-	.create =	tusb_omap_dma_init,
-	.destroy =	tusb_omap_dma_cleanup,
-};
Index: d26/drivers/usb/musb/musbhsdma.c
===================================================================
--- d26.orig/drivers/usb/musb/musbhsdma.c	2007-01-18 03:45:00.000000000 -0800
+++ d26/drivers/usb/musb/musbhsdma.c	2007-01-18 03:51:38.000000000 -0800
@@ -346,18 +346,16 @@ static irqreturn_t hsdma_irq(int irq, vo
 	return IRQ_HANDLED;
 }
 
-static void hsdma_controller_destroy(struct dma_controller *pController)
+void dma_controller_destroy(struct dma_controller *pController)
 {
 	struct hsdma *pHsController = pController->pPrivateData;
 
-	if (pHsController) {
-		pHsController->Controller.pPrivateData = NULL;
-		kfree(pHsController);
-	}
+	pHsController->Controller.pPrivateData = NULL;
+	kfree(pHsController);
 }
 
-static struct dma_controller *
-hsdma_controller_new(struct musb *pThis, void __iomem *pCoreBase)
+struct dma_controller *__init
+dma_controller_create(struct musb *pThis, void __iomem *pCoreBase)
 {
 	struct hsdma *pController;
 	struct device *dev = pThis->controller;
@@ -387,14 +385,9 @@ hsdma_controller_new(struct musb *pThis,
 	if (request_irq(irq, hsdma_irq, SA_INTERRUPT,
 			pThis->controller->bus_id, &pController->Controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
-		hsdma_controller_destroy(&pController->Controller);
+		kfree(pController);
 		return NULL;
 	}
 
 	return &pController->Controller;
 }
-
-const struct dma_controller_factory dma_controller_factory = {
-	.create =	hsdma_controller_new,
-	.destroy =	hsdma_controller_destroy,
-};
Index: d26/drivers/usb/musb/cppi_dma.c
===================================================================
--- d26.orig/drivers/usb/musb/cppi_dma.c	2007-01-18 03:44:25.000000000 -0800
+++ d26/drivers/usb/musb/cppi_dma.c	2007-01-18 03:50:32.000000000 -0800
@@ -1304,8 +1304,8 @@ void cppi_completion(struct musb *pThis,
 }
 
 /* Instantiate a software object representing a DMA controller. */
-static struct dma_controller *
-cppi_controller_new(struct musb *musb, void __iomem *pCoreBase)
+struct dma_controller *__init
+dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 {
 	struct cppi		*pController;
 
@@ -1344,7 +1344,7 @@ cppi_controller_new(struct musb *musb, v
 /*
  *  Destroy a previously-instantiated DMA controller.
  */
-static void cppi_controller_destroy(struct dma_controller *c)
+void dma_controller_destroy(struct dma_controller *c)
 {
 	struct cppi	*cppi;
 
@@ -1356,11 +1356,6 @@ static void cppi_controller_destroy(stru
 	kfree(cppi);
 }
 
-const struct dma_controller_factory dma_controller_factory = {
-	.create =	cppi_controller_new,
-	.destroy =	cppi_controller_destroy,
-};
-
 /*
  * Context: controller irqlocked, endpoint selected
  */
