From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-omap] rest of dma_controller.private_data updates
Date: Fri, 12 Oct 2007 14:24:51 -0700
Message-ID: <200710121424.51639.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Finish getting rid of dma_controller.private data, fixing a bug
related to the previous DaVinci private_data fix.  Also get rid
of a compiler warning in the 2430 dma code.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/musb/musb_core.c     |    2 +-
 drivers/usb/musb/musb_dma.h      |    2 --
 drivers/usb/musb/musbhsdma.c     |   11 +++++------
 drivers/usb/musb/tusb6010_omap.c |    1 -
 4 files changed, 6 insertions(+), 10 deletions(-)

--- o26.orig/drivers/usb/musb/musb_dma.h	2007-10-12 14:06:08.000000000 -0700
+++ o26/drivers/usb/musb/musb_dma.h	2007-10-12 14:07:02.000000000 -0700
@@ -136,7 +136,6 @@ dma_channel_status(struct dma_channel *c
 
 /**
  * struct dma_controller - A DMA Controller.
- * @private_data: controller-private data;
  * @start: call this to start a DMA controller;
  *	return 0 on success, else negative errno
  * @stop: call this to stop a DMA controller
@@ -149,7 +148,6 @@ dma_channel_status(struct dma_channel *c
  * Controllers manage dma channels.
  */
 struct dma_controller {
-	void			*private_data;
 	int			(*start)(struct dma_controller *);
 	int			(*stop)(struct dma_controller *);
 	struct dma_channel	*(*channel_alloc)(struct dma_controller *,
--- o26.orig/drivers/usb/musb/musb_core.c	2007-10-12 14:06:08.000000000 -0700
+++ o26/drivers/usb/musb/musb_core.c	2007-10-12 14:07:02.000000000 -0700
@@ -1863,7 +1863,7 @@ static void musb_free(struct musb *musb)
 	if (is_dma_capable() && musb->dma_controller) {
 		struct dma_controller	*c = musb->dma_controller;
 
-		(void) c->stop(c->private_data);
+		(void) c->stop(c);
 		dma_controller_destroy(c);
 	}
 
--- o26.orig/drivers/usb/musb/musbhsdma.c	2007-10-12 14:06:08.000000000 -0700
+++ o26/drivers/usb/musb/musbhsdma.c	2007-10-12 14:07:02.000000000 -0700
@@ -326,6 +326,8 @@ static irqreturn_t dma_controller_irq(in
 				pImplChannel->Channel.status =
 					MUSB_DMA_STATUS_BUS_ABORT;
 			else {
+				u8 devctl;
+
 				dwAddress = musb_readl(mbase,
 						MUSB_HSDMA_CHANNEL_OFFSET(
 							bChannel,
@@ -341,8 +343,7 @@ static irqreturn_t dma_controller_irq(in
 						< pImplChannel->len) ?
 					"=> reconfig 0": "=> complete");
 
-				u8 devctl = musb_readb(mbase,
-						MUSB_DEVCTL);
+				devctl = musb_readb(mbase, MUSB_DEVCTL);
 
 				pChannel->status = MUSB_DMA_STATUS_FREE;
 
@@ -376,9 +377,9 @@ done:
 
 void dma_controller_destroy(struct dma_controller *c)
 {
-	struct musb_dma_controller *controller =
-		(struct musb_dma_controller *) c->private_data;
+	struct musb_dma_controller *controller;
 
+	controller = container_of(c, struct musb_dma_controller, Controller);
 	if (!controller)
 		return;
 
@@ -386,7 +387,6 @@ void dma_controller_destroy(struct dma_c
 		free_irq(controller->irq, c);
 
 	kfree(controller);
-	c->private_data = NULL;
 }
 
 struct dma_controller *__init
@@ -410,7 +410,6 @@ dma_controller_create(struct musb *musb,
 	controller->pDmaPrivate = musb;
 	controller->pCoreBase = pCoreBase;
 
-	controller->Controller.private_data = controller;
 	controller->Controller.start = dma_controller_start;
 	controller->Controller.stop = dma_controller_stop;
 	controller->Controller.channel_alloc = dma_channel_allocate;
--- o26.orig/drivers/usb/musb/tusb6010_omap.c	2007-10-12 14:13:12.000000000 -0700
+++ o26/drivers/usb/musb/tusb6010_omap.c	2007-10-12 14:13:40.000000000 -0700
@@ -708,7 +708,6 @@ dma_controller_create(struct musb *musb,
 	tusb_dma->controller.channel_release = tusb_omap_dma_release;
 	tusb_dma->controller.channel_program = tusb_omap_dma_program;
 	tusb_dma->controller.channel_abort = tusb_omap_dma_abort;
-	tusb_dma->controller.private_data = tusb_dma;
 
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel	*ch;
