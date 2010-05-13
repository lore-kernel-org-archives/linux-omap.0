From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 2/2] usb: ehci-omap: add suspend/resume support
Date: Thu, 13 May 2010 20:30:22 +0530
Message-ID: <1273762822-23073-2-git-send-email-gadiyar@ti.com>
References: <1273762822-23073-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273762822-23073-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add support for suspend and resume to the ehci-omap driver.
Added routines for platform_driver suspend/resume and 
wrappers around ehci_bus_suspend/resume.

Disable the USB clocks after a bus_suspend and re-enable them
back before a bus_resume.

This allows the OMAP to enter low power modes when the driver
is loaded but no device is connected, or when all connected
devices are suspended and the root-hub autosuspends.

TODO:
- This patch breaks USB remote-wakeup after the root-hub
  autosuspends. This needs to be handled by enabling
  wakeup-detection on the IO pads, and is work-in-progress.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Tested against the linux-omap-pm tree at [1] which allows the chip
to hit low power modes after all the clocks are disabled.

Tested on OMAP3 SDPs (which use an NXP ISP1504 PHY). Suspend-resume
works great with or without any connected devices.

Tested on OMAP3EVM EHCI port which has SMSC3320 PHY. Suspend/resume
works fine when no devices are connected to EHCI port but if any
device is connected then it gets detected as full speed device after
resume and EHCI port becomes unusable. This is likely due to known
errata i542 on SMSC PHY interoperability with OMAP.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

 drivers/usb/host/ehci-omap.c |  134 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -49,7 +49,10 @@
 #define	OMAP_USBTLL_REVISION				(0x00)
 #define	OMAP_USBTLL_SYSCONFIG				(0x10)
 #define	OMAP_USBTLL_SYSCONFIG_CACTIVITY			(1 << 8)
-#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE			(1 << 3)
+#define	OMAP_USBTLL_SYSCONFIG_SMARTIDLE		(2 << 3)
+#define	OMAP_USBTLL_SYSCONFIG_NOIDLE			(1 << 3)
+#define	OMAP_USBTLL_SYSCONFIG_FORCEIDLE		(0 << 3)
+#define	OMAP_USBTLL_SYSCONFIG_SIDLEMASK			(3 << 3)
 #define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP			(1 << 2)
 #define	OMAP_USBTLL_SYSCONFIG_SOFTRESET			(1 << 1)
 #define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE			(1 << 0)
@@ -92,9 +95,15 @@
 /* UHH Register Set */
 #define	OMAP_UHH_REVISION				(0x00)
 #define	OMAP_UHH_SYSCONFIG				(0x10)
-#define	OMAP_UHH_SYSCONFIG_MIDLEMODE			(1 << 12)
+#define	OMAP_UHH_SYSCONFIG_SMARTSTDBY			(2 << 12)
+#define	OMAP_UHH_SYSCONFIG_NOSTDBY			(1 << 12)
+#define	OMAP_UHH_SYSCONFIG_FORCESTDBY			(0 << 12)
+#define	OMAP_UHH_SYSCONFIG_MIDLEMASK			(3 << 12)
 #define	OMAP_UHH_SYSCONFIG_CACTIVITY			(1 << 8)
-#define	OMAP_UHH_SYSCONFIG_SIDLEMODE			(1 << 3)
+#define	OMAP_UHH_SYSCONFIG_SMARTIDLE			(2 << 3)
+#define	OMAP_UHH_SYSCONFIG_NOIDLE			(1 << 3)
+#define	OMAP_UHH_SYSCONFIG_FORCEIDLE			(0 << 3)
+#define	OMAP_UHH_SYSCONFIG_SIDLEMASK			(3 << 3)
 #define	OMAP_UHH_SYSCONFIG_ENAWAKEUP			(1 << 2)
 #define	OMAP_UHH_SYSCONFIG_SOFTRESET			(1 << 1)
 #define	OMAP_UHH_SYSCONFIG_AUTOIDLE			(1 << 0)
@@ -159,6 +168,7 @@ struct ehci_hcd_omap {
 	struct clk		*usbhost1_48m_fck;
 	struct clk		*usbtll_fck;
 	struct clk		*usbtll_ick;
+	unsigned		suspended:1;
 
 	/* FIXME the following two workarounds are
 	 * board specific not silicon-specific so these
@@ -207,6 +217,35 @@ static void ehci_omap_clock_power(struct
 	}
 }
 
+static void ehci_omap_enable(struct ehci_hcd_omap *omap, int enable)
+{
+	u32 reg;
+
+	if (enable) {
+		ehci_omap_clock_power(omap, 1);
+
+		/* Enable NoIdle/NoStandby mode */
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
+		reg &= ~(OMAP_UHH_SYSCONFIG_SIDLEMASK
+				| OMAP_UHH_SYSCONFIG_MIDLEMASK);
+		reg |= OMAP_UHH_SYSCONFIG_NOIDLE
+				| OMAP_UHH_SYSCONFIG_NOSTDBY;
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
+		omap->suspended = 0;
+	} else {
+		/* Enable ForceIdle/ForceStandby mode */
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
+		reg &= ~(OMAP_UHH_SYSCONFIG_SIDLEMASK
+				| OMAP_UHH_SYSCONFIG_MIDLEMASK);
+		reg |= OMAP_UHH_SYSCONFIG_FORCEIDLE
+				| OMAP_UHH_SYSCONFIG_FORCESTDBY;
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
+
+		ehci_omap_clock_power(omap, 0);
+		omap->suspended = 1;
+	}
+}
+
 static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 {
 	unsigned reg;
@@ -340,20 +379,21 @@ static int omap_start_ehc(struct ehci_hc
 
 	dev_dbg(omap->dev, "TLL RESET DONE\n");
 
-	/* (1<<3) = no idle mode only for initial debugging */
-	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
-			OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
-			OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
-			OMAP_USBTLL_SYSCONFIG_CACTIVITY);
-
+	/* Enable smart-idle, wakeup */
+	reg = OMAP_USBTLL_SYSCONFIG_CACTIVITY
+			| OMAP_USBTLL_SYSCONFIG_AUTOIDLE
+			| OMAP_USBTLL_SYSCONFIG_ENAWAKEUP
+			| OMAP_USBTLL_SYSCONFIG_SMARTIDLE;
+	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG, reg);
 
 	/* Put UHH in NoIdle/NoStandby mode */
 	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
-	reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
-			| OMAP_UHH_SYSCONFIG_SIDLEMODE
-			| OMAP_UHH_SYSCONFIG_CACTIVITY
-			| OMAP_UHH_SYSCONFIG_MIDLEMODE);
-	reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
+	reg |= OMAP_UHH_SYSCONFIG_CACTIVITY
+			| OMAP_UHH_SYSCONFIG_AUTOIDLE
+			| OMAP_UHH_SYSCONFIG_ENAWAKEUP;
+	reg &= ~(OMAP_UHH_SYSCONFIG_SIDLEMASK | OMAP_UHH_SYSCONFIG_MIDLEMASK);
+	reg |= OMAP_UHH_SYSCONFIG_NOIDLE
+			| OMAP_UHH_SYSCONFIG_NOSTDBY;
 
 	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
 
@@ -555,7 +595,56 @@ static void omap_stop_ehc(struct ehci_hc
 	dev_dbg(omap->dev, "Clock to USB host has been disabled\n");
 }
 
+#ifdef CONFIG_PM
 /*-------------------------------------------------------------------------*/
+static int ehci_omap_dev_suspend(struct device *dev)
+{
+	struct ehci_hcd_omap *omap = dev_get_drvdata(dev);
+
+	if (!omap->suspended)
+		ehci_omap_enable(omap, 0);
+	return 0;
+}
+
+static int ehci_omap_dev_resume(struct device *dev)
+{
+	struct ehci_hcd_omap *omap = dev_get_drvdata(dev);
+
+	if (omap->suspended)
+		ehci_omap_enable(omap, 1);
+	return 0;
+}
+
+static int ehci_omap_bus_suspend(struct usb_hcd *hcd)
+{
+	struct usb_bus *bus = hcd_to_bus(hcd);
+	int ret;
+
+	ret = ehci_bus_suspend(hcd);
+
+	ehci_omap_dev_suspend(bus->controller);
+
+	return ret;
+}
+static int ehci_omap_bus_resume(struct usb_hcd *hcd)
+{
+	struct usb_bus *bus = hcd_to_bus(hcd);
+	int ret;
+
+	ehci_omap_dev_resume(bus->controller);
+
+	ret = ehci_bus_resume(hcd);
+
+	return ret;
+}
+static const struct dev_pm_ops ehci_omap_dev_pm_ops = {
+	.suspend	= ehci_omap_dev_suspend,
+	.resume_noirq	= ehci_omap_dev_resume,
+};
+#define EHCI_OMAP_DEV_PM_OPS (&ehci_omap_dev_pm_ops)
+#else
+#define EHCI_OMAP_DEV_PM_OPS NULL
+#endif
 
 static const struct hc_driver ehci_omap_hc_driver;
 
@@ -614,6 +703,7 @@ static int ehci_hcd_omap_probe(struct pl
 	omap->port_mode[2]		= pdata->port_mode[2];
 	omap->ehci		= hcd_to_ehci(hcd);
 	omap->ehci->sbrn	= 0x20;
+	omap->suspended = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
@@ -735,6 +825,9 @@ static int ehci_hcd_omap_remove(struct p
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
 	int i;
 
+	if (omap->suspended)
+		ehci_omap_enable(omap, 1);
+
 	usb_remove_hcd(hcd);
 	omap_stop_ehc(omap, hcd);
 	iounmap(hcd->regs);
@@ -757,6 +850,9 @@ static void ehci_hcd_omap_shutdown(struc
 	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
 
+	if (omap->suspended)
+		ehci_omap_enable(omap, 1);
+
 	if (hcd->driver->shutdown)
 		hcd->driver->shutdown(hcd);
 }
@@ -765,10 +861,9 @@ static struct platform_driver ehci_hcd_o
 	.probe			= ehci_hcd_omap_probe,
 	.remove			= ehci_hcd_omap_remove,
 	.shutdown		= ehci_hcd_omap_shutdown,
-	/*.suspend		= ehci_hcd_omap_suspend, */
-	/*.resume		= ehci_hcd_omap_resume, */
 	.driver = {
 		.name		= "ehci-omap",
+		.pm		= EHCI_OMAP_DEV_PM_OPS,
 	}
 };
 
@@ -811,9 +906,10 @@ static const struct hc_driver ehci_omap_
 	 */
 	.hub_status_data	= ehci_hub_status_data,
 	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
