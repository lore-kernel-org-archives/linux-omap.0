From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] musb_hdrc: Search and replace USB_INVENTRA_FIFO with
	USB_MUSB_DISABLE_DMA
Date: Mon, 20 Aug 2007 02:10:19 -0700
Message-ID: <11876010292224-git-send-email-tony@atomide.com>
References: <11876010273160-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11876010273160-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace USB_INVENTRA_FIFO with USB_MUSB_DISABLE_DMA

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/Kconfig       |    8 ++++----
 drivers/usb/musb/Makefile      |    2 +-
 drivers/usb/musb/dma.h         |    2 +-
 drivers/usb/musb/musb_gadget.c |    2 +-
 drivers/usb/musb/musb_procfs.c |    2 +-
 drivers/usb/musb/plat_uds.c    |   12 ++++++------
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index a9bcd7e..8e5430a 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -129,7 +129,7 @@ config USB_MUSB_HDRC_HCD
 	default y
 
 
-config USB_INVENTRA_FIFO
+config USB_MUSB_DISABLE_DMA
 	bool 'Disable DMA (always use PIO)'
 	depends on USB_MUSB_HDRC
 	default y if USB_TUSB6010
@@ -144,21 +144,21 @@ config USB_INVENTRA_FIFO
 
 config USB_INVENTRA_DMA
 	bool
-	depends on USB_MUSB_HDRC && !USB_INVENTRA_FIFO
+	depends on USB_MUSB_HDRC && !USB_MUSB_DISABLE_DMA
 	default ARCH_OMAP2430 || ARCH_OMAP343X
 	help
 	  Enable DMA transfers using Mentor's engine.
 
 config USB_TI_CPPI_DMA
 	bool
-	depends on USB_MUSB_HDRC && !USB_INVENTRA_FIFO
+	depends on USB_MUSB_HDRC && !USB_MUSB_DISABLE_DMA
 	default ARCH_DAVINCI
 	help
 	  Enable DMA transfers when TI CPPI DMA is available.
 
 config USB_TUSB_OMAP_DMA
 	bool
-	depends on USB_MUSB_HDRC && !USB_INVENTRA_FIFO
+	depends on USB_MUSB_HDRC && !USB_MUSB_DISABLE_DMA
 	depends on USB_TUSB6010
 	depends on ARCH_OMAP
 	default y
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 535ba40..fbff415 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -31,7 +31,7 @@ endif
 # PIO (INVENTRA_FIFO), or DMA (several potential schemes).
 # though PIO is always there to back up DMA, and for ep0
 
-ifneq ($(CONFIG_USB_INVENTRA_FIFO),y)
+ifneq ($(CONFIG_USB_MUSB_DISABLE_DMA),y)
 
   ifeq ($(CONFIG_USB_INVENTRA_DMA),y)
     musb_hdrc-objs		+= musbhsdma.o
diff --git a/drivers/usb/musb/dma.h b/drivers/usb/musb/dma.h
index 701d312..deef0c2 100644
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -62,7 +62,7 @@ struct musb_hw_ep;
 
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
-#ifndef CONFIG_USB_INVENTRA_FIFO
+#ifndef CONFIG_USB_MUSB_DISABLE_DMA
 #define	is_dma_capable()	(1)
 #else
 #define	is_dma_capable()	(0)
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 88757ce..5a4227e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -291,7 +291,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			epnum, musb_ep->packet_sz, fifo_count,
 			csr);
 
-#ifndef	CONFIG_USB_INVENTRA_FIFO
+#ifndef	CONFIG_USB_MUSB_DISABLE_DMA
 	if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->dma_controller;
 
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index 1bc5c79..3144f34 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -508,7 +508,7 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 
 	code = sprintf(buffer,
 			"Options: "
-#ifdef CONFIG_USB_INVENTRA_FIFO
+#ifdef CONFIG_USB_MUSB_DISABLE_DMA
 			"pio"
 #elif defined(CONFIG_USB_TI_CPPI_DMA)
 			"cppi-dma"
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index dacf930..e544339 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1536,7 +1536,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 }
 
 
-#ifndef CONFIG_USB_INVENTRA_FIFO
+#ifndef CONFIG_USB_MUSB_DISABLE_DMA
 static int __initdata use_dma = 1;
 
 /* "modprobe ... use_dma=0" etc */
@@ -1918,7 +1918,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		goto fail2;
 	}
 
-#ifndef CONFIG_USB_INVENTRA_FIFO
+#ifndef CONFIG_USB_MUSB_DISABLE_DMA
 	if (use_dma && dev->dma_mask) {
 		struct dma_controller	*c;
 
@@ -2047,7 +2047,7 @@ fail2:
  * bridge to a platform device; this driver then suffices.
  */
 
-#ifndef CONFIG_USB_INVENTRA_FIFO
+#ifndef CONFIG_USB_MUSB_DISABLE_DMA
 static u64	*orig_dma_mask;
 #endif
 
@@ -2068,7 +2068,7 @@ static int __init musb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-#ifndef CONFIG_USB_INVENTRA_FIFO
+#ifndef CONFIG_USB_MUSB_DISABLE_DMA
 	/* clobbered by use_dma=n */
 	orig_dma_mask = dev->dma_mask;
 #endif
@@ -2094,7 +2094,7 @@ static int __devexit musb_remove(struct platform_device *pdev)
 	musb_free(musb);
 	iounmap(ctrl_base);
 	device_init_wakeup(&pdev->dev, 0);
-#ifndef CONFIG_USB_INVENTRA_FIFO
+#ifndef CONFIG_USB_MUSB_DISABLE_DMA
 	pdev->dev.dma_mask = orig_dma_mask;
 #endif
 	return 0;
@@ -2180,7 +2180,7 @@ static int __init musb_init(void)
 #endif
 
 	pr_info("%s: version " MUSB_VERSION ", "
-#ifdef CONFIG_USB_INVENTRA_FIFO
+#ifdef CONFIG_USB_MUSB_DISABLE_DMA
 		"pio"
 #elif defined(CONFIG_USB_TI_CPPI_DMA)
 		"cppi-dma"
-- 
1.5.2.3
