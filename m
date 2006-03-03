From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: IrDA: Update
Date: Fri, 3 Mar 2006 02:24:36 -0800 (PST)
Message-ID: <20060303102436.83739.qmail@web32906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-195062922-1141381476=:83737"
Content-Transfer-Encoding: 8bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-195062922-1141381476=:83737
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch moves dma related params to board-*.c files, and having
few cosmetic changes.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-195062922-1141381476=:83737
Content-Type: text/x-patch; name="irdac02.patch"
Content-Description: 3884758452-irdac02.patch
Content-Disposition: inline; filename="irdac02.patch"

Subject: [PATCH] IrDA: OMAP: Move dma related parameters to platform data and also

few more cosmetic changes.
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 arch/arm/mach-omap1/board-h2.c   |    7 +++
 arch/arm/mach-omap1/board-h3.c   |    7 +++
 arch/arm/mach-omap2/board-h4.c   |    7 +++
 drivers/net/irda/omap-ir.c       |   99 +++++++++++++++-----------------------
 include/asm-arm/arch-omap/irda.h |    8 +++
 5 files changed, 68 insertions(+), 60 deletions(-)

e0eb5aad630fd213c6f6582e2dd25b4f2668e214
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index cae3874..4364d51 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -40,6 +40,7 @@
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
+#include <asm/arch/dma.h>
 #include <asm/arch/common.h>
 
 extern int omap_gpio_init(void);
@@ -254,6 +255,12 @@ static int h2_transceiver_mode(struct de
 
 static struct omap_irda_config h2_irda_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+	.rx_channel		= OMAP_DMA_UART3_RX,
+	.tx_channel		= OMAP_DMA_UART3_TX,
+	.dest_start		= UART3_THR,
+	.src_start		= UART3_RHR,
+	.tx_trigger		= 0,
+	.rx_trigger		= 0,
 };
 
 static struct resource h2_irda_resources[] = {
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 9652822..4b8d0ec 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -43,6 +43,7 @@
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
+#include <asm/arch/dma.h>
 #include <asm/arch/common.h>
 
 extern int omap_gpio_init(void);
@@ -329,6 +330,12 @@ static struct omap_irda_config h3_irda_d
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
 	.transceiver_mode	= h3_transceiver_mode,
 	.select_irda	 	= h3_select_irda,
+	.rx_channel		= OMAP_DMA_UART3_RX,
+	.tx_channel		= OMAP_DMA_UART3_TX,
+	.dest_start		= UART3_THR,
+	.src_start		= UART3_RHR,
+	.tx_trigger		= 0,
+	.rx_trigger		= 0,
 };
 
 static struct resource h3_irda_resources[] = {
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 913ab3d..4933fce 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -35,6 +35,7 @@
 #include <asm/arch/common.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/menelaus.h>
+#include <asm/arch/dma.h>
 #include "prcm-regs.h"
 
 #include <asm/io.h>
@@ -214,6 +215,12 @@ static struct omap_irda_config h4_irda_d
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
 	.transceiver_mode	= h4_transceiver_mode,
 	.select_irda	 	= h4_select_irda,
+	.rx_channel		= OMAP24XX_DMA_UART3_RX,
+	.tx_channel		= OMAP24XX_DMA_UART3_TX,
+	.dest_start		= OMAP_UART3_BASE,
+	.src_start		= OMAP_UART3_BASE,
+	.tx_trigger		= OMAP24XX_DMA_UART3_TX,
+	.rx_trigger		= OMAP24XX_DMA_UART3_RX,
 };
 
 static struct resource h4_irda_resources[] = {
diff --git a/drivers/net/irda/omap-ir.c b/drivers/net/irda/omap-ir.c
index de1d27a..f8235c0 100644
--- a/drivers/net/irda/omap-ir.c
+++ b/drivers/net/irda/omap-ir.c
@@ -157,21 +157,9 @@ static int omap_irda_set_speed(struct ne
 
 static void omap_irda_start_rx_dma(struct omap_irda *si)
 {
-	/* default for h2/h3 */
-	unsigned long src_start = 0xfffb9800;
-	unsigned int trigger = 0;
-
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-		src_start = UART3_RHR;
-		trigger = 0;
-	}
-	if (machine_is_omap_h4()) {
-		src_start = OMAP_UART3_BASE;
-		trigger = OMAP24XX_DMA_UART3_RX;
-	}
-
 	/* Configure DMA */
-    	omap_set_dma_src_params(si->rx_dma_channel, 0x3, 0x0, src_start,
+    	omap_set_dma_src_params(si->rx_dma_channel, 0x3, 0x0,
+				si->pdata->src_start,
 				0, 0);
 
 	omap_enable_dma_irq(si->rx_dma_channel, 0x01);
@@ -182,29 +170,17 @@ static void omap_irda_start_rx_dma(struc
 
 	omap_set_dma_transfer_params(si->rx_dma_channel, 0x0,
 				IRDA_FRAME_SIZE_LIMIT, 0x1,
-				0x0, trigger, 0);
+				0x0, si->pdata->rx_trigger, 0);
 
 	omap_start_dma(si->rx_dma_channel);
 }
 
 static void omap_start_tx_dma(struct omap_irda *si, int size)
 {
-	/* default for h2/h3 */
-	unsigned long dest_start = 0xfffb9800;
-	unsigned int trigger = 0;
-
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-		dest_start = UART3_THR;
-		trigger = 0;
-	}
-	if (machine_is_omap_h4()) {
-		dest_start = OMAP_UART3_BASE;
-		trigger = OMAP24XX_DMA_UART3_TX;
-	}
-
 	/* Configure DMA */
 	omap_set_dma_dest_params(si->tx_dma_channel, 0x03, 0x0,
-				dest_start, 0, 0);
+				si->pdata->dest_start, 0, 0);
+
 	omap_enable_dma_irq(si->tx_dma_channel, 0x01);
 
 	omap_set_dma_src_params(si->tx_dma_channel, 0x0, 0x1,
@@ -212,7 +188,7 @@ static void omap_start_tx_dma(struct oma
 				0, 0);
 
 	omap_set_dma_transfer_params(si->tx_dma_channel, 0x0, size, 0x1,
-				0x0, trigger, 0);
+				0x0, si->pdata->tx_trigger, 0);
 
 	/* Start DMA */
 	omap_start_dma(si->tx_dma_channel);
@@ -454,10 +430,8 @@ static int omap_irda_hard_xmit(struct sk
 	if (speed != si->speed && speed != -1)
 		si->newspeed = speed;
 
-	if (xbofs) {
-		/* Set number of addtional BOFS */
+	if (xbofs) /* Set number of addtional BOFS */
 		uart_reg_out(UART3_EBLR, xbofs + 1);
-	}
 
 	/*
 	 * If this is an empty frame, we can bypass a lot.
@@ -514,10 +488,10 @@ omap_irda_ioctl(struct net_device *dev, 
 			 * We are unable to set the speed if the
 			 * device is not running.
 			 */
-			if (si->open) {
+			if (si->open) 
 				ret = omap_irda_set_speed(dev,
 						rq->ifr_baudrate);
-			} else {
+			else {
 				printk(KERN_ERR "omap_irda_ioctl: SIOCSBANDWIDTH: !netif_running\n");
 				ret = 0;
 			}
@@ -553,8 +527,6 @@ static int omap_irda_start(struct net_de
 {
 	struct omap_irda *si = dev->priv;
 	int err;
-	int rx_channel = OMAP_DMA_NO_DEVICE;
-	int tx_channel = OMAP_DMA_NO_DEVICE;
 
 	si->speed = 9600;
 
@@ -567,27 +539,15 @@ static int omap_irda_start(struct net_de
 	 */
 	disable_irq(dev->irq);
 
-	/* FIXME: These info can come from board-* files, if no one
-	 * objects
-	 */
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-		rx_channel = OMAP_DMA_UART3_RX;
-		tx_channel = OMAP_DMA_UART3_TX;
-	}
-	if (machine_is_omap_h4()) {
-		rx_channel = OMAP24XX_DMA_UART3_RX;
-		tx_channel = OMAP24XX_DMA_UART3_TX;
-	}
-
 	/*  Request DMA channels for IrDA hardware */
-	if (omap_request_dma(rx_channel, "IrDA Rx DMA",
+	if (omap_request_dma(si->pdata->rx_channel, "IrDA Rx DMA",
 			(void *)omap_irda_rx_dma_callback,
 			dev, &(si->rx_dma_channel))) {
 		printk(KERN_ERR "Failed to request IrDA Rx DMA\n");
 		goto err_irq;
 	}
 
-	if (omap_request_dma(tx_channel, "IrDA Tx DMA",
+	if (omap_request_dma(si->pdata->tx_channel, "IrDA Tx DMA",
 			(void *)omap_irda_tx_dma_callback,
 			dev, &(si->tx_dma_channel))) {
 		printk(KERN_ERR "Failed to request IrDA Tx DMA\n");
@@ -599,12 +559,22 @@ static int omap_irda_start(struct net_de
 		dma_alloc_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
 				&(si->rx_buf_dma_phys),
 				GFP_KERNEL);
+	
+	if (!si->rx_buf_dma_virt) {
+		printk(KERN_ERR "Unable to allocate memory for rx_buf_dma\n");
+		goto err_irq;
+	}
 
 	si->tx_buf_dma_virt =
 		dma_alloc_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
 				&(si->tx_buf_dma_phys),
 				GFP_KERNEL);
 
+	if (!si->tx_buf_dma_virt) {
+		printk(KERN_ERR "Unable to allocate memory for tx_buf_dma\n");
+		goto err_mem1;
+	}
+
 	/*
 	 * Setup the serial port for the specified config.
 	 */
@@ -642,6 +612,11 @@ err_irlap:
 	si->open = 0;
 	omap_irda_shutdown(si);
 err_startup:
+	dma_free_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
+			si->tx_buf_dma_virt, si->tx_buf_dma_phys);
+err_mem1:
+	dma_free_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
+			si->rx_buf_dma_virt, si->rx_buf_dma_phys);
 err_irq:
 	free_irq(dev->irq, dev);
 	return err;
@@ -819,18 +794,20 @@ static int omap_irda_probe(struct platfo
 {
 	struct net_device *dev;
 	struct omap_irda *si;
+	struct omap_irda_config *pdata = pdev->dev.platform_data;
 	unsigned int baudrate_mask;
 	int err = 0;
 	int irq = NO_IRQ;
 
-	if (!pdev->dev.platform_data) {
+	if (!pdata) {
 		printk(KERN_ERR "IrDA Platform data not supplied\n");
 		return -ENOENT;
 	}
 
-	dev = alloc_irdadev(sizeof(struct omap_irda));
-	if (!dev)
-		goto err_mem_1;
+	if (!pdata->rx_channel || !pdata->tx_channel) {
+		printk(KERN_ERR "IrDA invalid rx/tx channel value\n");
+		return -ENOENT;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
@@ -838,9 +815,14 @@ static int omap_irda_probe(struct platfo
 		return -ENOENT;
 	}
 
+	dev = alloc_irdadev(sizeof(struct omap_irda));
+	if (!dev)
+		goto err_mem_1;
+
+
 	si = dev->priv;
 	si->dev = &pdev->dev;
-	si->pdata = pdev->dev.platform_data;
+	si->pdata = pdata;
 
 	dev->hard_start_xmit	= omap_irda_hard_xmit;
 	dev->open		= omap_irda_start;
@@ -865,9 +847,8 @@ static int omap_irda_probe(struct platfo
 	irda_qos_bits_to_value(&si->qos);
 
 	/* Any better way to avoid this? No. */
-	if (machine_is_omap_h3() || machine_is_omap_h4()) {
+	if (machine_is_omap_h3() || machine_is_omap_h4()) 
 		INIT_WORK(&si->pdata->gpio_expa, NULL, NULL);
-	}
 
 	err = register_netdev(dev);
 	if (!err)
@@ -900,7 +881,7 @@ static struct platform_driver omapir_dri
 	},
 };
 
-static char __initdata banner[] = KERN_INFO "OMAP IrDA driver\n";
+static char __initdata banner[] = KERN_INFO "OMAP IrDA driver initializing\n";
 
 static int __init omap_irda_init(void)
 {
diff --git a/include/asm-arm/arch-omap/irda.h b/include/asm-arm/arch-omap/irda.h
index ad71e4b..805ae35 100644
--- a/include/asm-arm/arch-omap/irda.h
+++ b/include/asm-arm/arch-omap/irda.h
@@ -1,7 +1,7 @@
 /*
  *  linux/include/asm-arm/arch-omap/irda.h
  *
- *  Copyright (C) 2005 Komal Shah <komal_shah802003@yahoo.com>
+ *  Copyright (C) 2005-2006 Komal Shah <komal_shah802003@yahoo.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -25,6 +25,12 @@ struct omap_irda_config {
 	 * having calls which can sleep in irda_set_speed.
 	 */
 	struct work_struct gpio_expa;
+	int rx_channel;
+	int tx_channel;
+	unsigned long dest_start;
+	unsigned long src_start;
+	int tx_trigger;
+	int rx_trigger;
 };
 
 #endif
-- 
1.1.6

--0-195062922-1141381476=:83737
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-195062922-1141381476=:83737--
