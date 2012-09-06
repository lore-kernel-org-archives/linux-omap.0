From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH] musb: Kill __init from function that are called at other times as well.
Date: Thu,  6 Sep 2012 17:01:46 +0300
Message-ID: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:38152 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265Ab2IEQDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 12:03:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, Pantelis Antoniou <panto@antoniou-consulting.com>

Marking functions as __init or __devinit and calling them at other times
leads to predictable crashes (if you're lucky).

Remove them for now.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/usb/musb/musb_core.c    | 16 ++++++++--------
 drivers/usb/musb/musb_debugfs.c |  2 +-
 drivers/usb/musb/musb_dma.h     |  2 +-
 drivers/usb/musb/musb_gadget.c  |  6 +++---
 drivers/usb/musb/musbhsdma.c    |  2 +-
 drivers/usb/musb/omap2430.c     |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 26f1bef..215d2d5 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1160,7 +1160,7 @@ static struct musb_fifo_cfg __devinitdata mode_5_cfg[] = {
  *
  * returns negative errno or offset for next fifo.
  */
-static int __devinit
+static int
 fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		const struct musb_fifo_cfg *cfg, u16 offset)
 {
@@ -1235,7 +1235,7 @@ static struct musb_fifo_cfg __devinitdata ep0_cfg = {
 	.style = FIFO_RXTX, .maxpacket = 64,
 };
 
-static int __devinit ep_config_from_table(struct musb *musb)
+static int ep_config_from_table(struct musb *musb)
 {
 	const struct musb_fifo_cfg	*cfg;
 	unsigned		i, n;
@@ -1326,7 +1326,7 @@ done:
  * ep_config_from_hw - when MUSB_C_DYNFIFO_DEF is false
  * @param musb the controller
  */
-static int __devinit ep_config_from_hw(struct musb *musb)
+static int ep_config_from_hw(struct musb *musb)
 {
 	u8 epnum = 0;
 	struct musb_hw_ep *hw_ep;
@@ -1373,7 +1373,7 @@ enum { MUSB_CONTROLLER_MHDRC, MUSB_CONTROLLER_HDRC, };
 /* Initialize MUSB (M)HDRC part of the USB hardware subsystem;
  * configure endpoints, or take their config from silicon
  */
-static int __devinit musb_core_init(u16 musb_type, struct musb *musb)
+static int musb_core_init(u16 musb_type, struct musb *musb)
 {
 	u8 reg;
 	char *type;
@@ -1797,7 +1797,7 @@ static void musb_irq_work(struct work_struct *data)
  * Init support
  */
 
-static struct musb *__devinit
+static struct musb *
 allocate_instance(struct device *dev,
 		struct musb_hdrc_config *config, void __iomem *mbase)
 {
@@ -1873,7 +1873,7 @@ static void musb_free(struct musb *musb)
  * @mregs: virtual address of controller registers,
  *	not yet corrected for platform-specific offsets
  */
-static int __devinit
+static int
 musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 {
 	int			status;
@@ -2101,7 +2101,7 @@ fail0:
 static u64	*orig_dma_mask;
 #endif
 
-static int __devinit musb_probe(struct platform_device *pdev)
+static int musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	int		irq = platform_get_irq_byname(pdev, "mc");
@@ -2397,7 +2397,7 @@ static struct platform_driver musb_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init musb_init(void)
+static int /* __init */ musb_init(void)
 {
 	if (usb_disabled())
 		return 0;
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 40a37c9..8f8597d 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -235,7 +235,7 @@ static const struct file_operations musb_test_mode_fops = {
 	.release		= single_release,
 };
 
-int __devinit musb_init_debugfs(struct musb *musb)
+int musb_init_debugfs(struct musb *musb)
 {
 	struct dentry		*root;
 	struct dentry		*file;
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 3a97c4e..69254c8 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -178,7 +178,7 @@ struct dma_controller {
 extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit);
 
 
-extern struct dma_controller *__init
+extern struct dma_controller * /* __init */
 dma_controller_create(struct musb *, void __iomem *);
 
 extern void dma_controller_destroy(struct dma_controller *);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f7194cf..f3d9f4e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1795,7 +1795,7 @@ static void musb_gadget_release(struct device *dev)
 }
 
 
-static void __devinit
+static void
 init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 {
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
@@ -1832,7 +1832,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
  * Initialize the endpoints exposed to peripheral drivers, with backlinks
  * to the rest of the driver state.
  */
-static inline void __devinit musb_g_init_endpoints(struct musb *musb)
+static inline void musb_g_init_endpoints(struct musb *musb)
 {
 	u8			epnum;
 	struct musb_hw_ep	*hw_ep;
@@ -1865,7 +1865,7 @@ static inline void __devinit musb_g_init_endpoints(struct musb *musb)
 /* called once during driver setup to initialize and link into
  * the driver model; memory is zeroed.
  */
-int __devinit musb_gadget_setup(struct musb *musb)
+int musb_gadget_setup(struct musb *musb)
 {
 	int status;
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 57a6085..49b548f 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -380,7 +380,7 @@ void dma_controller_destroy(struct dma_controller *c)
 	kfree(controller);
 }
 
-struct dma_controller *__init
+struct dma_controller * /* __init */
 dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	struct musb_dma_controller *controller;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5fdb9da..d8c6aeb 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -435,7 +435,7 @@ static const struct musb_platform_ops omap2430_ops = {
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit omap2430_probe(struct platform_device *pdev)
+static int omap2430_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
-- 
1.7.12

