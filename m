From: David Brownell <david-b@pacbell.net>
Subject: Re: Undefined usb_disconnect
Date: Sat, 27 May 2006 08:43:54 -0700
Message-ID: <200605270843.54940.david-b@pacbell.net>
References: <4452384E.7080409@gmail.com>
	<20060505110852.66e6f39d.Hiroshi.DOYU@nokia.com>
	<4477F3E1.4000301@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6OHeEh/8iW2Cfas"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4477F3E1.4000301@gmail.com>
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
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_6OHeEh/8iW2Cfas
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 26 May 2006 11:38 pm, Dirk Behme wrote:
> Hi,
> 
> with recent git I still get
> 
> WARNING: "usb_disconnect" [drivers/usb/host/ohci-hcd.ko] 
> undefined!

Try the attached patch instead ... it fixes some other glitches
in the OMAP bus glue, as well as those.

- Dave





--Boundary-00=_6OHeEh/8iW2Cfas
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ohci-omap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ohci-omap.patch"

Various fixes for the OHCI OMAP glue:

 - Properly use the usbcore HCD lifecycle entry points

 - Remove calls to non-exported usbcore routines.

 - Stop inappropriate export of some bus glue calls

Plus remove some extra whitespace.

Index: osk/drivers/usb/host/ohci-omap.c
===================================================================
--- osk.orig/drivers/usb/host/ohci-omap.c	2006-05-12 17:53:41.000000000 -0700
+++ osk/drivers/usb/host/ohci-omap.c	2006-05-12 17:53:55.000000000 -0700
@@ -4,7 +4,7 @@
  * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
  * (C) Copyright 2000-2005 David Brownell
  * (C) Copyright 2002 Hewlett-Packard Company
- * 
+ *
  * OMAP Bus Glue
  *
  * Modified for OMAP by Tony Lindgren <tony@atomide.com>
@@ -92,14 +92,14 @@ static int omap_ohci_transceiver_power(i
 	if (on) {
 		if (machine_is_omap_innovator() && cpu_is_omap1510())
 			fpga_write(fpga_read(INNOVATOR_FPGA_CAM_USB_CONTROL)
-				| ((1 << 5/*usb1*/) | (1 << 3/*usb2*/)), 
+				| ((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
 			       INNOVATOR_FPGA_CAM_USB_CONTROL);
 		else if (machine_is_omap_osk())
 			tps65010_set_gpio_out_value(GPIO1, LOW);
 	} else {
 		if (machine_is_omap_innovator() && cpu_is_omap1510())
 			fpga_write(fpga_read(INNOVATOR_FPGA_CAM_USB_CONTROL)
-				& ~((1 << 5/*usb1*/) | (1 << 3/*usb2*/)), 
+				& ~((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
 			       INNOVATOR_FPGA_CAM_USB_CONTROL);
 		else if (machine_is_omap_osk())
 			tps65010_set_gpio_out_value(GPIO1, HIGH);
@@ -127,8 +127,8 @@ static int omap_1510_local_bus_power(int
 /*
  * OMAP-1510 specific Local Bus initialization
  * NOTE: This assumes 32MB memory size in OMAP1510LB_MEMSIZE.
- *       See also arch/mach-omap/memory.h for __virt_to_dma() and 
- *       __dma_to_virt() which need to match with the physical 
+ *       See also arch/mach-omap/memory.h for __virt_to_dma() and
+ *       __dma_to_virt() which need to match with the physical
  *       Local Bus address below.
  */
 static int omap_1510_local_bus_init(void)
@@ -136,7 +136,7 @@ static int omap_1510_local_bus_init(void
 	unsigned int tlb;
 	unsigned long lbaddr, physaddr;
 
-	omap_writel((omap_readl(OMAP1510_LB_CLOCK_DIV) & 0xfffffff8) | 0x4, 
+	omap_writel((omap_readl(OMAP1510_LB_CLOCK_DIV) & 0xfffffff8) | 0x4,
 	       OMAP1510_LB_CLOCK_DIV);
 
 	/* Configure the Local Bus MMU table */
@@ -144,7 +144,7 @@ static int omap_1510_local_bus_init(void
 		lbaddr = tlb * 0x00100000 + OMAP1510_LB_OFFSET;
 		physaddr = tlb * 0x00100000 + PHYS_OFFSET;
 		omap_writel((lbaddr & 0x0fffffff) >> 22, OMAP1510_LB_MMU_CAM_H);
-		omap_writel(((lbaddr & 0x003ffc00) >> 6) | 0xc, 
+		omap_writel(((lbaddr & 0x003ffc00) >> 6) | 0xc,
 		       OMAP1510_LB_MMU_CAM_L);
 		omap_writel(physaddr >> 16, OMAP1510_LB_MMU_RAM_H);
 		omap_writel((physaddr & 0x0000fc00) | 0x300, OMAP1510_LB_MMU_RAM_L);
@@ -183,13 +183,14 @@ static void start_hnp(struct ohci_hcd *o
 
 /*-------------------------------------------------------------------------*/
 
-static int omap_start_hc(struct ohci_hcd *ohci, struct platform_device *pdev)
+static int ohci_omap_init(struct usb_hcd *hcd)
 {
-	struct omap_usb_config	*config = pdev->dev.platform_data;
+	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
+	struct omap_usb_config	*config = hcd->self.controller->platform_data;
 	int			need_transceiver = (config->otg != 0);
 	int			ret;
 
-	dev_dbg(&pdev->dev, "starting USB Controller\n");
+	dev_dbg(hcd->self.controller, "starting USB Controller\n");
 
 	if (config->otg) {
 		ohci_to_hcd(ohci)->self.otg_port = config->otg;
@@ -210,7 +211,7 @@ static int omap_start_hc(struct ohci_hcd
 		if (ohci->transceiver) {
 			int	status = otg_set_host(ohci->transceiver,
 						&ohci_to_hcd(ohci)->self);
-			dev_dbg(&pdev->dev, "init %s transceiver, status %d\n",
+			dev_dbg(hcd->self.controller, "init %s transceiver, status %d\n",
 					ohci->transceiver->label, status);
 			if (status) {
 				if (ohci->transceiver)
@@ -218,7 +219,7 @@ static int omap_start_hc(struct ohci_hcd
 				return status;
 			}
 		} else {
-			dev_err(&pdev->dev, "can't find transceiver\n");
+			dev_err(hcd->self.controller, "can't find transceiver\n");
 			return -ENODEV;
 		}
 	}
@@ -270,58 +271,15 @@ static int omap_start_hc(struct ohci_hcd
 	return 0;
 }
 
-static void omap_stop_hc(struct platform_device *pdev)
+static void ohci_omap_stop(struct usb_hcd *hcd)
 {
-	dev_dbg(&pdev->dev, "stopping USB Controller\n");
+	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
 	omap_ohci_clock_power(0);
 }
 
 
 /*-------------------------------------------------------------------------*/
 
-void usb_hcd_omap_remove (struct usb_hcd *, struct platform_device *);
-
-/* configure so an HC device and id are always provided */
-/* always called with process context; sleeping is OK */
-
-
-int ohci_omap_host_enable(struct usb_bus *host, int enable)
-{
-	struct usb_hcd *hcd;
-	struct ohci_hcd *ohci;
-	int retval;
-
-	if (host_enabled == enable)
-		return 0;
-
-	host_enabled = enable;
-
-	if (!host_initialized)
-		return 0;
-
-	hcd = (struct usb_hcd *)host->hcpriv;
-	ohci = hcd_to_ohci(hcd);
-	if (enable) {
-		omap_ohci_clock_power(1);
-		if ((retval = ohci_init(ohci)) < 0) {
-			dev_err(hcd->self.controller, "init error %d\n",
-				retval);
-			return retval;
-		}
-		if ((retval = hcd->driver->start(hcd)) < 0) {
-			dev_err(hcd->self.controller, "startup error %d\n",
-				retval);
-			return retval;
-		}
-	} else {
-		usb_disconnect(&hcd->self.root_hub);
-		hcd->driver->stop(hcd);
-		omap_ohci_clock_power(0);
-	}
-
-	return 0;
-}
-
 /**
  * usb_hcd_omap_probe - initialize OMAP-based HCDs
  * Context: !in_interrupt()
@@ -330,7 +288,7 @@ int ohci_omap_host_enable(struct usb_bus
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
  */
-int usb_hcd_omap_probe (const struct hc_driver *driver,
+static int usb_hcd_omap_probe (const struct hc_driver *driver,
 			  struct platform_device *pdev)
 {
 	int retval, irq;
@@ -338,12 +296,12 @@ int usb_hcd_omap_probe (const struct hc_
 	struct ohci_hcd *ohci;
 
 	if (pdev->num_resources != 2) {
-		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n", 
+		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n",
 		       pdev->num_resources);
 		return -ENODEV;
 	}
 
-	if (pdev->resource[0].flags != IORESOURCE_MEM 
+	if (pdev->resource[0].flags != IORESOURCE_MEM
 			|| pdev->resource[1].flags != IORESOURCE_IRQ) {
 		printk(KERN_ERR "hcd probe: invalid resource type\n");
 		return -ENODEV;
@@ -386,10 +344,6 @@ int usb_hcd_omap_probe (const struct hc_
 	host_initialized = 0;
 	host_enabled = 1;
 
-	retval = omap_start_hc(ohci, pdev);
-	if (retval < 0)
-		goto err2;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		retval = -ENXIO;
@@ -397,7 +351,7 @@ int usb_hcd_omap_probe (const struct hc_
 	}
 	retval = usb_add_hcd(hcd, irq, SA_INTERRUPT);
 	if (retval)
-		goto err3;
+		goto err2;
 
 	host_initialized = 1;
 
@@ -405,8 +359,6 @@ int usb_hcd_omap_probe (const struct hc_
 		omap_ohci_clock_power(0);
 
 	return 0;
-err3:
-	omap_stop_hc(pdev);
 err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err1:
@@ -428,14 +380,19 @@ err0:
  * Reverses the effect of usb_hcd_omap_probe(), first invoking
  * the HCD's stop() method.  It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
- *
  */
-void usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
+static inline void
+usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 {
+	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
+
 	usb_remove_hcd(hcd);
+	if (ohci->transceiver) {
+		(void) otg_set_host(ohci->transceiver, 0);
+		put_device(ohci->transceiver->dev);
+	}
 	if (machine_is_omap_osk())
 		omap_free_gpio(9);
-	omap_stop_hc(pdev);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 	clk_put(usb_dc_ck);
@@ -481,8 +438,9 @@ static const struct hc_driver ohci_omap_
 	/*
 	 * basic lifecycle operations
 	 */
+	.reset =		ohci_omap_init,
 	.start =		ohci_omap_start,
-	.stop =			ohci_stop,
+	.stop =			ohci_omap_stop,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -519,13 +477,8 @@ static int ohci_hcd_omap_drv_probe(struc
 static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
 {
 	struct usb_hcd		*hcd = platform_get_drvdata(dev);
-	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
 	usb_hcd_omap_remove(hcd, dev);
-	if (ohci->transceiver) {
-		(void) otg_set_host(ohci->transceiver, 0);
-		put_device(ohci->transceiver->dev);
-	}
 	platform_set_drvdata(dev, NULL);
 
 	return 0;

--Boundary-00=_6OHeEh/8iW2Cfas
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_6OHeEh/8iW2Cfas--
