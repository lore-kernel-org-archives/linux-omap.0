From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH] MUSB_HDRC: Convert printk() to dev_* macros
Date: Wed, 15 Aug 2007 13:23:23 -0400
Message-ID: <11871986091227-git-send-email-felipe.lima@indt.org.br>
References: <200708150944.28365.david-b@pacbell.net>
	<11871986031263-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871986031263-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Code cleanup on musb_hdrc driver converting plain printk to dev_*

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/usb/musb/davinci.c       |    2 +-
 drivers/usb/musb/g_ep0.c         |    5 +--
 drivers/usb/musb/plat_uds.c      |   45 ++++++++++++++++----------------------
 drivers/usb/musb/tusb6010.c      |   12 +++++-----
 drivers/usb/musb/tusb6010_omap.c |    5 ++-
 5 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 3324543..ff9acba 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -91,7 +91,7 @@ void musb_platform_enable(struct musb *musb)
 	musb_writel(musb->ctrl_base, DAVINCI_USB_INT_MASK_SET_REG, tmp);
 
 	if (is_dma_capable() && !dma_off)
-		printk(KERN_WARNING "%s %s: dma not reactivated\n",
+		dev_warn(musb->controller, "%s %s: dma not reactivated\n",
 				__FILE__, __FUNCTION__);
 	else
 		dma_off = 0;
diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index e1cbf18..a0faca2 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -707,9 +707,8 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			if (unlikely(musb->g.speed == USB_SPEED_UNKNOWN)) {
 				u8	power;
 
-				printk(KERN_NOTICE "%s: peripheral reset "
-						"irq lost!\n",
-						musb_driver_name);
+				dev_notice(musb->controller, "peripheral reset "
+						"irq lost!\n");
 				power = musb_readb(mbase, MGC_O_HDRC_POWER);
 				musb->g.speed = (power & MGC_M_POWER_HSMODE)
 					? USB_SPEED_HIGH : USB_SPEED_FULL;
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index b87c587..86d3477 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -114,7 +114,6 @@
 #endif
 
 
-
 #if MUSB_DEBUG > 0
 unsigned debug = MUSB_DEBUG;
 module_param(debug, uint, 0);
@@ -678,7 +677,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 			// eliminate duplicated StartUrb logic
 			if (ep->dwWaitFrame >= wFrame) {
 				ep->dwWaitFrame = 0;
-				printk("SOF --> periodic TX%s on %d\n",
+				dev_info(musb->controller, "SOF --> periodic TX%s on %d\n",
 					ep->tx_channel ? " DMA" : "",
 					epnum);
 				if (!ep->tx_channel)
@@ -1128,8 +1127,7 @@ static int __init ep_config_from_table(struct musb *musb)
 		break;
 	}
 
-	printk(KERN_DEBUG "%s: setup fifo_mode %d\n",
-			musb_driver_name, fifo_mode);
+	dev_dbg(musb->controller, "setup fifo_mode %d\n", fifo_mode);
 
 
 	offset = fifo_setup(musb, hw_ep, &ep0_cfg, 0);
@@ -1157,14 +1155,13 @@ static int __init ep_config_from_table(struct musb *musb)
 		musb->nr_endpoints = max(epn, musb->nr_endpoints);
 	}
 
-	printk(KERN_DEBUG "%s: %d/%d max ep, %d/%d memory\n",
-			musb_driver_name,
+	dev_dbg(musb->controller, "%d/%d max ep, %d/%d memory\n",
 			n + 1, MUSB_C_NUM_EPS * 2 - 1,
 			offset, DYN_FIFO_SIZE);
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (!musb->bulk_ep) {
-		pr_debug( "%s: missing bulk\n", musb_driver_name);
+		dev_dbg(musb->controller, "missing bulk\n");
 		return -EINVAL;
 	}
 #endif
@@ -1293,8 +1290,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 		strcat(aInfo, ", SoftConn");
 	}
 
-	printk(KERN_DEBUG "%s: ConfigData=0x%02x (%s)\n",
-			musb_driver_name, reg, aInfo);
+	dev_dbg(musb->controller, "ConfigData=0x%02x (%s)\n", reg, aInfo);
 
 #ifdef MUSB_AHB_ID
 	dwData = musb_readl(mbase, 0x404);
@@ -1302,9 +1298,9 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 		(dwData >> 16) & 0xff, (dwData >> 24) & 0xff);
 	/* FIXME ID2 and ID3 are unused */
 	dwData = musb_readl(mbase, 0x408);
-	printk("ID2=%lx\n", (long unsigned)dwData);
+	dev_info(musb->controller, "ID2=%lx\n", (long unsigned)dwData);
 	dwData = musb_readl(mbase, 0x40c);
-	printk("ID3=%lx\n", (long unsigned)dwData);
+	dev_info(musb->controller, "ID3=%lx\n", (long unsigned)dwData);
 	reg = musb_readb(mbase, 0x400);
 	wType = ('M' == reg) ? MUSB_CONTROLLER_MHDRC : MUSB_CONTROLLER_HDRC;
 #else
@@ -1318,9 +1314,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 		type = "";
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 #ifndef	CONFIG_USB_OTG_BLACKLIST_HUB
-		printk(KERN_ERR
-			"%s: kernel must blacklist external hubs\n",
-			musb_driver_name);
+		dev_err(musb->controller, "kernel must blacklist external hubs\n");
 #endif
 #endif
 	}
@@ -1331,8 +1325,8 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	wRelMinor = wRelease & 0x3ff;
 	snprintf(aRevision, 32, "%d.%d%s", wRelMajor,
 		wRelMinor, (wRelease & 0x8000) ? "RC" : "");
-	printk(KERN_DEBUG "%s: %sHDRC RTL version %s %s\n",
-			musb_driver_name, type, aRevision, aDate);
+	dev_dbg(musb->controller, "%sHDRC RTL version %s %s\n",
+			type, aRevision, aDate);
 
 	/* configure ep0 */
 	musb->endpoints[0].max_packet_sz_tx = MGC_END0_FIFOSIZE;
@@ -1386,19 +1380,18 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 #endif
 
 		if (hw_ep->max_packet_sz_tx) {
-			printk(KERN_DEBUG
-				"%s: hw_ep %d%s, %smax %d\n",
-				musb_driver_name, i,
-				hw_ep->is_shared_fifo ? "shared" : "tx",
+			dev_dbg(musb->controller,
+				"hw_ep %d%s, %smax %d\n",
+				i, hw_ep->is_shared_fifo
+					? "shared" : "tx",
 				hw_ep->tx_double_buffered
 					? "doublebuffer, " : "",
 				hw_ep->max_packet_sz_tx);
 		}
 		if (hw_ep->max_packet_sz_rx && !hw_ep->is_shared_fifo) {
-			printk(KERN_DEBUG
-				"%s: hw_ep %d%s, %smax %d\n",
-				musb_driver_name, i,
-				"rx",
+			dev_dbg(musb->controller,
+				"hw_ep %d%s, %smax %d\n",
+				i, "rx",
 				hw_ep->rx_double_buffered
 					? "doublebuffer, " : "",
 				hw_ep->max_packet_sz_rx);
@@ -1676,7 +1669,7 @@ musb_vbus_store(struct device *dev, struct device_attribute *attr,
 
 	spin_lock_irqsave(&musb->lock, flags);
 	if (sscanf(buf, "%lu", &val) < 1) {
-		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
+		dev_err(dev, "Invalid VBUS timeout ms value\n");
 		return -EINVAL;
 	}
 	musb->a_wait_bcon = val;
@@ -1713,7 +1706,7 @@ musb_srp_store(struct device *dev, struct device_attribute *attr,
 
 	if (sscanf(buf, "%hu", &srp) != 1
 			|| (srp != 1)) {
-		printk (KERN_ERR "SRP: Value must be 1\n");
+		dev_err(dev, "SRP: Value must be 1\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index d43b5cc..29b27a6 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -943,7 +943,7 @@ void musb_platform_enable(struct musb * musb)
 				TUSB_INT_SRC_ID_STATUS_CHNG);
 
 	if (is_dma_capable() && dma_off)
-		printk(KERN_WARNING "%s %s: dma not reactivated\n",
+		dev_warn(musb->controller, "%s %s: dma not reactivated\n",
 				__FILE__, __FUNCTION__);
 	else
 		dma_off = 1;
@@ -967,7 +967,7 @@ void musb_platform_disable(struct musb *musb)
 	del_timer(&musb_idle_timer);
 
 	if (is_dma_capable() && !dma_off) {
-		printk(KERN_WARNING "%s %s: dma still active\n",
+		dev_warn(musb->controller, "%s %s: dma still active\n",
 				__FILE__, __FUNCTION__);
 		dma_off = 1;
 	}
@@ -1014,7 +1014,7 @@ static int __init tusb_start(struct musb *musb)
 	if (musb->board_set_power)
 		ret = musb->board_set_power(1);
 	if (ret != 0) {
-		printk(KERN_ERR "tusb: Cannot enable TUSB6010\n");
+		dev_err(musb->controller, "tusb: Cannot enable TUSB6010\n");
 		return ret;
 	}
 
@@ -1022,13 +1022,13 @@ static int __init tusb_start(struct musb *musb)
 
 	if (musb_readl(base, TUSB_PROD_TEST_RESET) !=
 		TUSB_PROD_TEST_RESET_VAL) {
-		printk(KERN_ERR "tusb: Unable to detect TUSB6010\n");
+		dev_err(musb->controller, "tusb: Unable to detect TUSB6010\n");
 		goto err;
 	}
 
 	ret = tusb_print_revision(musb);
 	if (ret < 2) {
-		printk(KERN_ERR "tusb: Unsupported TUSB6010 revision %i\n",
+		dev_err(musb->controller, "tusb: Unsupported TUSB6010 revision %i\n",
 				ret);
 		goto err;
 	}
@@ -1108,7 +1108,7 @@ int __init musb_platform_init(struct musb *musb)
 
 	ret = tusb_start(musb);
 	if (ret) {
-		printk(KERN_ERR "Could not start tusb6010 (%d)\n",
+		dev_err(musb->controller, "Could not start tusb6010 (%d)\n",
 				ret);
 		return -ENODEV;
 	}
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 9359028..91704ff 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -119,9 +119,10 @@ static inline int tusb_omap_use_shared_dmareq(struct tusb_omap_dma_ch *chdat)
 static inline void tusb_omap_free_shared_dmareq(struct tusb_omap_dma_ch *chdat)
 {
 	u32		reg = musb_readl(chdat->tusb_base, TUSB_DMA_EP_MAP);
+	struct device	*dev = chdat->musb->controller;
 
 	if ((reg & 0xf) != chdat->epnum) {
-		printk(KERN_ERR "ep%i trying to release dmareq0 for ep%i\n",
+		dev_err(dev, "ep%i trying to release dmareq0 for ep%i\n",
 			chdat->epnum, reg & 0xf);
 		return;
 	}
@@ -157,7 +158,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		ch = tusb_dma->ch;
 
 	if (ch_status != OMAP_DMA_BLOCK_IRQ)
-		printk(KERN_ERR "TUSB DMA error status: %i\n", ch_status);
+		dev_err(musb->controller, "TUSB DMA error status: %i\n", ch_status);
 
 	DBG(2, "ep%i %s dma callback ch: %i status: %x\n",
 		chdat->epnum, chdat->tx ? "tx" : "rx",
-- 
1.5.3.rc4.67.gf9286
