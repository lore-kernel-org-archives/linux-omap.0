From: David Brownell <david-b@pacbell.net>
Subject: [patch] ehci-omap: (mostly) cosmetic cleanups
Date: Fri, 3 Oct 2008 00:03:33 -0700
Message-ID: <200810030003.34109.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:40007 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755282AbYJCHDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 03:03:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Various cleanups to the OMAP EHCI bus glue:

 - Whitespace fixes.

 - Busy-wait loops should really have timeouts, but lacking
   that ... at least cpu_relax() in the body.

 - Debug messages should end with newlines, so they don't
   break the next message; should not embed newlines; and
   should otherwise be clean and correctly spelled.

 - The probe() method should have initialized the SBRN value,
   so the driver didn't report "USB 0.0 started".

 - The MODULE_ALIAS() was missing its "platform:" prefix;
   doing it right means the module could hotplug/coldplug.

No real functional change except for the hotplug/coldplug thing.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/host/ehci-omap.c |   75 +++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -5,7 +5,7 @@
  * Tested on OMAP3430 ES2.0 SDP
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * 	Author: Vikram Pandita <vikram.pandita@ti.com>
+ *	Author: Vikram Pandita <vikram.pandita@ti.com>
  *
  * Based on "ehci-fsl.c" and "ehci-au1xxx.c" ehci glue layers
  *
@@ -42,10 +42,10 @@
 
 /* ISSUE1:
  *      ISP1504 for input clocking mode needs special reset handling
- * 	Hold the PHY in reset by asserting RESET_N signal
- * 	Then start the 60Mhz clock input to PHY
- * 	Release the reset after a delay -
- * 		to get the PHY state machine in working state
+ *	Hold the PHY in reset by asserting RESET_N signal
+ *	Then start the 60Mhz clock input to PHY
+ *	Release the reset after a delay -
+ *		to get the PHY state machine in working state
  */
 #define EXTERNAL_PHY_RESET
 #define	EXT_PHY_RESET_GPIO_PORT1	(57)
@@ -95,8 +95,9 @@ static void omap_usb_utmi_init(struct us
 			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Enusre bit is set */
-	while (!(omap_readl(OMAP_UHH_HOSTCONFIG) &
-		(1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)));
+	while (!(omap_readl(OMAP_UHH_HOSTCONFIG)
+			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)))
+		cpu_relax();
 
 	dev_dbg(hcd->self.controller, "\nEntered UTMI MODE: success\n");
 
@@ -150,13 +151,13 @@ static void omap_usb_utmi_init(struct us
 
 
 /* omap_start_ehc
- * 	- Start the TI USBHOST controller
+ *	- Start the TI USBHOST controller
  */
 static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 {
 	struct ehci_omap_clock_defs *ehci_clocks;
 
-	dev_dbg(hcd->self.controller, ": starting TI EHCI USB Controller\n");
+	dev_dbg(hcd->self.controller, "starting TI EHCI USB Controller\n");
 
 	ehci_clocks = (struct ehci_omap_clock_defs *)(
 				((char *)hcd_to_ehci(hcd)) +
@@ -250,17 +251,19 @@ static int omap_start_ehc(struct platfor
 				CORE_MOD, CM_AUTOIDLE3);
 
 	/* Wait for TLL to be Active */
-	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3) &
-		(1 << OMAP3430ES2_ST_USBTLL_SHIFT)));
+	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
+			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
+		cpu_relax();
 
 	/* perform TLL soft reset, and wait until reset is complete */
 	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
 			OMAP_USBTLL_SYSCONFIG);
 	/* Wait for TLL reset to complete */
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) &
-		(1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT)));
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS)
+			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT)))
+		cpu_relax();
 
-	dev_dbg(hcd->self.controller, "\n TLL RESET DONE\n");
+	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
 	/* (1<<3) = no idle mode only for initial debugging */
 	omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
@@ -286,10 +289,11 @@ static int omap_start_ehc(struct platfor
 			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Ensure that BYPASS is set */
-	while (omap_readl(OMAP_UHH_HOSTCONFIG) &
-		(1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT));
+	while (omap_readl(OMAP_UHH_HOSTCONFIG)
+			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT))
+		cpu_relax();
 
-	dev_dbg(hcd->self.controller, "Entered ULPI PHY MODE: success");
+	dev_dbg(hcd->self.controller, "Entered ULPI PHY MODE: success\n");
 
 #else
 	/* Enable UTMI mode for all 3 TLL channels */
@@ -313,7 +317,7 @@ static int omap_start_ehc(struct platfor
 	/* Refer ISSUE2: LINK assumes external charge pump */
 
 	/* use Port1 VBUS to charge externally Port2:
-	 * 	So for PHY mode operation use Port2 only
+	 *	So for PHY mode operation use Port2 only
 	 */
 	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
 			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
@@ -322,8 +326,9 @@ static int omap_start_ehc(struct platfor
 			(0x26),
 			EHCI_INSNREG05_ULPI);
 
-	while (!(omap_readl(EHCI_INSNREG05_ULPI) &
-		(1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
+	while (!(omap_readl(EHCI_INSNREG05_ULPI)
+			& (1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)))
+		cpu_relax();
 
 #endif
 
@@ -339,20 +344,24 @@ static void omap_stop_ehc(struct platfor
 	ehci_clocks = (struct ehci_omap_clock_defs *)
 			(((char *)hcd_to_ehci(hcd)) + sizeof(struct ehci_hcd));
 
-	dev_dbg(hcd->self.controller, ": stopping TI EHCI USB Controller\n");
+	dev_dbg(hcd->self.controller, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
 	omap_writel((1<<1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)));
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)));
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)))
+		cpu_relax();
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)))
+		cpu_relax();
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)))
+		cpu_relax();
 	dev_dbg(hcd->self.controller,
 		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
 			omap_readl(OMAP_UHH_SYSSTATUS));
 
 	omap_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)));
-	dev_dbg(hcd->self.controller, ":TLL RESEET DONE");
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)))
+		cpu_relax();
+	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
 	if (ehci_clocks->usbtll_fck_clk != NULL) {
 		clk_disable(ehci_clocks->usbtll_fck_clk);
@@ -391,7 +400,7 @@ static void omap_stop_ehc(struct platfor
 #endif
 
 	dev_dbg(hcd->self.controller,
-		": Clock to USB host has been disabled\n");
+		"Clock to USB host has been disabled\n");
 }
 
 static const struct hc_driver ehci_omap_hc_driver;
@@ -415,13 +424,13 @@ static int ehci_hcd_omap_drv_probe(struc
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
 
-	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_probe()");
+	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_probe()\n");
 
 	if (usb_disabled())
 		return -ENODEV;
 
 	if (dev->resource[1].flags != IORESOURCE_IRQ) {
-		dev_dbg(&dev->dev, "resource[1] is not IORESOURCE_IRQ");
+		dev_dbg(&dev->dev, "resource[1] is not IORESOURCE_IRQ\n");
 		retval = -ENOMEM;
 	}
 
@@ -447,6 +456,8 @@ static int ehci_hcd_omap_drv_probe(struc
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = hcd->regs;
 
+	ehci->sbrn = 0x20;
+
 	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
 	/* cache this readonly data; minimize chip reads */
 	ehci->hcs_params = readl(&ehci->caps->hcs_params);
@@ -459,7 +470,7 @@ static int ehci_hcd_omap_drv_probe(struc
 	if (retval == 0)
 		return retval;
 
-	dev_dbg(hcd->self.controller, "ERR: add_hcd");
+	dev_dbg(hcd->self.controller, "ERR: add_hcd\n");
 	omap_stop_ehc(dev, hcd);
 	iounmap(hcd->regs);
 	usb_put_hcd(hcd);
@@ -486,7 +497,7 @@ static int ehci_hcd_omap_drv_remove(stru
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
-	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_remove()");
+	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_remove()\n");
 
 	iounmap(hcd->regs);
 	usb_remove_hcd(hcd);
@@ -554,7 +565,7 @@ static const struct hc_driver ehci_omap_
 };
 
 /*-------------------------------------------------------------------------*/
-MODULE_ALIAS("omap-ehci");
+MODULE_ALIAS("platform:omap-ehci");
 static struct platform_driver ehci_hcd_omap_driver = {
 	.probe = ehci_hcd_omap_drv_probe,
 	.remove = ehci_hcd_omap_drv_remove,
