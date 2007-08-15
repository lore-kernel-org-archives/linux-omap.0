From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH] MUSB_HDRC: Get rid of pr_*() and printk() clauses
Date: Wed, 15 Aug 2007 10:08:07 -0400
Message-ID: <1187186887430-git-send-email-felipe.lima@indt.org.br>
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
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Code cleanup:
	* Convert pr_*() to dev_*() macros
	* Convert printk() to dev_*() macros
	* Convert missing pr_*() to {info, err, dbg}() macros

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/usb/musb/cppi_dma.c    |    2 +-
 drivers/usb/musb/davinci.c     |    2 +-
 drivers/usb/musb/g_ep0.c       |    8 +++---
 drivers/usb/musb/musb_gadget.c |    7 ++---
 drivers/usb/musb/musb_procfs.c |    4 +-
 drivers/usb/musb/omap2430.c    |    2 +-
 drivers/usb/musb/plat_uds.c    |   50 ++++++++++++++++------------------------
 drivers/usb/musb/tusb6010.c    |    6 ++--
 drivers/usb/musb/virthub.c     |   12 ++++----
 9 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 25941b5..75000c1 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -430,7 +430,7 @@ cppi_rndis_update(struct cppi_channel *c, int is_rx,
 
 static void cppi_dump_rxbd(const char *tag, struct cppi_descriptor *bd)
 {
-	pr_debug("RXBD/%s %08x: "
+	dbg("RXBD/%s %08x: "
 			"nxt %08x buf %08x off.blen %08x opt.plen %08x\n",
 			tag, bd->dma,
 			bd->hNext, bd->buffPtr, bd->bOffBLen, bd->hOptions);
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 3324543..2fa68f1 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -415,7 +415,7 @@ int __init musb_platform_init(struct musb *musb)
 	msleep(5);
 
 	/* NOTE:  irqs are in mixed mode, not bypass to pure-musb */
-	pr_debug("DaVinci OTG revision %08x phy %03x control %02x\n",
+	dbg("DaVinci OTG revision %08x phy %03x control %02x\n",
 		revision,
 		__raw_readl((void *__iomem) IO_ADDRESS(USBPHY_CTL_PADDR)),
 		musb_readb(tibase, DAVINCI_USB_CTRL_REG));
diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index e1cbf18..3690297 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -304,26 +304,26 @@ __acquires(musb->lock)
 
 					switch (ctrlrequest->wIndex >> 8) {
 					case 1:
-						pr_debug("TEST_J\n");
+						dbg("TEST_J\n");
 						/* TEST_J */
 						musb->test_mode_nr =
 							MGC_M_TEST_J;
 						break;
 					case 2:
 						/* TEST_K */
-						pr_debug("TEST_K\n");
+						dbg("TEST_K\n");
 						musb->test_mode_nr =
 							MGC_M_TEST_K;
 						break;
 					case 3:
 						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
+						dbg("TEST_SE0_NAK\n");
 						musb->test_mode_nr =
 							MGC_M_TEST_SE0_NAK;
 						break;
 					case 4:
 						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
+						dbg("TEST_PACKET\n");
 						musb->test_mode_nr =
 							MGC_M_TEST_PACKET;
 						break;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 4aa82fe..cadc9ee 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -974,8 +974,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	musb_ep->busy = 0;
 	status = 0;
 
-	pr_debug("%s periph: enabled %s for %s %s, %smaxpacket %d\n",
-			musb_driver_name, musb_ep->end_point.name,
+	dev_dbg(musb->controller, "periph: enabled %s for %s %s, %smaxpacket %d\n",
+			musb_ep->end_point.name,
 			({ char *s; switch (musb_ep->type) {
 			case USB_ENDPOINT_XFER_BULK:	s = "bulk"; break;
 			case USB_ENDPOINT_XFER_INT:	s = "int"; break;
@@ -1704,8 +1704,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	spin_lock_irqsave(&musb->lock, flags);
 
 	if (musb->gadget_driver) {
-		DBG(1, "%s is already bound to %s\n",
-				musb_driver_name,
+		dev_dbg(musb->controller, "is already bound to %s\n",
 				musb->gadget_driver->driver.name);
 		retval = -EBUSY;
 	} else {
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index b141a73..f46f50a 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -846,9 +846,9 @@ musb_debug_create(char *name, struct musb *data)
 
 		pde->size = 0;
 
-		pr_debug("Registered /proc/%s\n", name);
+		dbg("Registered /proc/%s\n", name);
 	} else {
-		pr_debug("Cannot create a valid proc file entry");
+		dbg("Cannot create a valid proc file entry");
 	}
 
 	return pde;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 65f2c22..55e9b4a 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -111,7 +111,7 @@ int __init musb_platform_init(struct musb *musb)
 
 	OTG_INTERFSEL_REG |= ULPI_12PIN;
 
-	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
+	dbg("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
 			OTG_REVISION_REG, OTG_SYSCONFIG_REG, OTG_SYSSTATUS_REG,
 			OTG_INTERFSEL_REG, OTG_SIMENABLE_REG);
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index b87c587..089486e 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -114,7 +114,6 @@
 #endif
 
 
-
 #if MUSB_DEBUG > 0
 unsigned debug = MUSB_DEBUG;
 module_param(debug, uint, 0);
@@ -1128,8 +1127,7 @@ static int __init ep_config_from_table(struct musb *musb)
 		break;
 	}
 
-	printk(KERN_DEBUG "%s: setup fifo_mode %d\n",
-			musb_driver_name, fifo_mode);
+	dev_dbg(musb->controller, "setup fifo_mode %d\n", fifo_mode);
 
 
 	offset = fifo_setup(musb, hw_ep, &ep0_cfg, 0);
@@ -1143,28 +1141,25 @@ static int __init ep_config_from_table(struct musb *musb)
 		u8	epn = cfg->hw_ep_num;
 
 		if (epn >= MUSB_C_NUM_EPS) {
-			pr_debug( "%s: invalid ep %d\n",
-					musb_driver_name, epn);
+			dev_dbg(musb->controller, "invalid ep %d\n", epn);
 			continue;
 		}
 		offset = fifo_setup(musb, hw_ep + epn, cfg++, offset);
 		if (offset < 0) {
-			pr_debug( "%s: mem overrun, ep %d\n",
-					musb_driver_name, epn);
+			dev_dbg(musb->controller, "mem overrun, ep %d\n", epn);
 			return -EINVAL;
 		}
 		epn++;
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
@@ -1231,7 +1226,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (!musb->bulk_ep) {
-		pr_debug( "%s: missing bulk\n", musb_driver_name);
+		dev_dbg(musb->controller, "missing bulk\n");
 		return -EINVAL;
 	}
 #endif
@@ -1293,8 +1288,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 		strcat(aInfo, ", SoftConn");
 	}
 
-	printk(KERN_DEBUG "%s: ConfigData=0x%02x (%s)\n",
-			musb_driver_name, reg, aInfo);
+	dev_dbg(musb->controller, "ConfigData=0x%02x (%s)\n", reg, aInfo);
 
 #ifdef MUSB_AHB_ID
 	dwData = musb_readl(mbase, 0x404);
@@ -1318,9 +1312,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
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
@@ -1331,8 +1323,8 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	wRelMinor = wRelease & 0x3ff;
 	snprintf(aRevision, 32, "%d.%d%s", wRelMajor,
 		wRelMinor, (wRelease & 0x8000) ? "RC" : "");
-	printk(KERN_DEBUG "%s: %sHDRC RTL version %s %s\n",
-			musb_driver_name, type, aRevision, aDate);
+	dev_dbg(musb->controller, "%sHDRC RTL version %s %s\n",
+			type, aRevision, aDate);
 
 	/* configure ep0 */
 	musb->endpoints[0].max_packet_sz_tx = MGC_END0_FIFOSIZE;
@@ -1386,19 +1378,18 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
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
@@ -1953,8 +1944,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (enable_irq_wake(nIrq) == 0)
 		device_init_wakeup(dev, 1);
 
-	pr_info("%s: USB %s mode controller at %p using %s, IRQ %d\n",
-			musb_driver_name,
+	dev_info(musb->controller, "USB %s mode controller at %p using %s, IRQ %d\n",
 			({char *s;
 			switch (musb->board_mode) {
 			case MUSB_HOST:		s = "Host"; break;
@@ -2178,7 +2168,7 @@ static int __init musb_init(void)
 		return 0;
 #endif
 
-	pr_info("%s: version " MUSB_VERSION ", "
+	info("musb_hdrc: version " MUSB_VERSION ", "
 #ifdef CONFIG_USB_INVENTRA_FIFO
 		"pio"
 #elif defined(CONFIG_USB_TI_CPPI_DMA)
@@ -2199,7 +2189,7 @@ static int __init musb_init(void)
 		"host"
 #endif
 		", debug=%d\n",
-		musb_driver_name, debug);
+		debug);
 	return platform_driver_probe(&musb_driver, musb_probe);
 }
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index d43b5cc..9b11e10 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -57,7 +57,7 @@ static int __init tusb_print_revision(struct musb *musb)
 
 	rev = tusb_get_revision(musb);
 
-	pr_info("tusb: %s%i.%i %s%i.%i %s%i.%i %s%i.%i %s%i %s%i.%i\n",
+	info("tusb: %s%i.%i %s%i.%i %s%i.%i %s%i.%i %s%i %s%i.%i\n",
 		"prcm",
 		TUSB_REV_MAJOR(musb_readl(base, TUSB_PRCM_REV)),
 		TUSB_REV_MINOR(musb_readl(base, TUSB_PRCM_REV)),
@@ -1089,14 +1089,14 @@ int __init musb_platform_init(struct musb *musb)
 	/* dma address for sync dma */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!mem) {
-		pr_debug("no sync dma resource?\n");
+		dbg("no sync dma resource?\n");
 		return -ENODEV;
 	}
 	musb->sync = mem->start;
 
 	sync = ioremap(mem->start, mem->end - mem->start + 1);
 	if (!sync) {
-		pr_debug("ioremap for sync failed\n");
+		dbg("ioremap for sync failed\n");
 		return -ENOMEM;
 	}
 	musb->sync_va = sync;
diff --git a/drivers/usb/musb/virthub.c b/drivers/usb/musb/virthub.c
index 5ad1614..8ba8162 100644
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -367,31 +367,31 @@ int musb_hub_control(
 			wIndex >>= 8;
 			switch (wIndex) {
 			case 1:
-				pr_debug("TEST_J\n");
+				dbg("TEST_J\n");
 				temp = MGC_M_TEST_J;
 				break;
 			case 2:
-				pr_debug("TEST_K\n");
+				dbg("TEST_K\n");
 				temp = MGC_M_TEST_K;
 				break;
 			case 3:
-				pr_debug("TEST_SE0_NAK\n");
+				dbg("TEST_SE0_NAK\n");
 				temp = MGC_M_TEST_SE0_NAK;
 				break;
 			case 4:
-				pr_debug("TEST_PACKET\n");
+				dbg("TEST_PACKET\n");
 				temp = MGC_M_TEST_PACKET;
 				musb_load_testpacket(musb);
 				break;
 			case 5:
-				pr_debug("TEST_FORCE_ENABLE\n");
+				dbg("TEST_FORCE_ENABLE\n");
 				temp = MGC_M_TEST_FORCE_HOST
 					| MGC_M_TEST_FORCE_HS;
 
 				musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
 				break;
 			case 6:
-				pr_debug("TEST_FIFO_ACCESS\n");
+				dbg("TEST_FIFO_ACCESS\n");
 				temp = MGC_M_TEST_FIFO_ACCESS;
 				break;
 			default:
-- 
1.5.3.rc4.67.gf9286
