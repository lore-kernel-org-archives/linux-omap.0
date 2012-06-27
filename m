From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: OMAP: EHCI: Fix the hub disconnect after resume
Date: Wed, 27 Jun 2012 16:45:19 +0530
Message-ID: <1340795719-28386-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Its observed that in Beagle XM , during suspend/resume the OMAP
EHCI controller losing the register contents. this is causing the
hub disconnect after the resume, this is causing failure of
device detection after the resume.
to avoid the hub disconnect , The ehci config flag register is
configured again , reset the phy and issue the port powers during
resume.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 4a54418..c9c34b7 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -46,6 +46,7 @@
 #include <linux/clk.h>
 
 /* EHCI Register Set */
+#define EHCI_CONFIGFLAG					(0x50)
 #define EHCI_INSNREG04					(0xA0)
 #define EHCI_INSNREG04_DISABLE_UNSUSPEND		(1 << 5)
 #define	EHCI_INSNREG05_ULPI				(0xA4)
@@ -72,9 +73,9 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
 }
 
 
-static void omap_ehci_soft_phy_reset(struct platform_device *pdev, u8 port)
+static void omap_ehci_soft_phy_reset(struct device *dev, u8 port)
 {
-	struct usb_hcd	*hcd = dev_get_drvdata(&pdev->dev);
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	unsigned reg = 0;
 
@@ -96,7 +97,7 @@ static void omap_ehci_soft_phy_reset(struct platform_device *pdev, u8 port)
 		cpu_relax();
 
 		if (time_after(jiffies, timeout)) {
-			dev_dbg(&pdev->dev, "phy reset operation timed out\n");
+			dev_dbg(dev, "phy reset operation timed out\n");
 			break;
 		}
 	}
@@ -223,9 +224,9 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	/* Soft reset the PHY using PHY reset command over ULPI */
 	if (pdata->port_mode[0] == OMAP_EHCI_PORT_MODE_PHY)
-		omap_ehci_soft_phy_reset(pdev, 0);
+		omap_ehci_soft_phy_reset(dev, 0);
 	if (pdata->port_mode[1] == OMAP_EHCI_PORT_MODE_PHY)
-		omap_ehci_soft_phy_reset(pdev, 1);
+		omap_ehci_soft_phy_reset(dev, 1);
 
 	omap_ehci = hcd_to_ehci(hcd);
 	omap_ehci->sbrn = 0x20;
@@ -328,6 +329,42 @@ static struct platform_driver ehci_hcd_omap_driver = {
 	}
 };
 
+static int omap_ehci_bus_resume(struct usb_hcd *hcd)
+{
+
+	struct device				*dev = hcd->self.controller;
+	struct ehci_hcd_omap_platform_data	*pdata = dev->platform_data;
+	struct resource				*regs = hcd->regs;
+
+	/* In case , ports are not powered and config flag not set */
+	if (~(ehci_read(regs, EHCI_CONFIGFLAG) & 0x01)) {
+		ehci_write(regs, EHCI_CONFIGFLAG, 0x1);
+
+		/*
+		 * An undocumented "feature" in the OMAP3 EHCI controller,
+		 * causes suspended ports to be taken out of suspend when
+		 * the USBCMD.Run/Stop bit is cleared (for example when
+		 * we do ehci_bus_suspend).
+		 * This breaks suspend-resume if the root-hub is allowed
+		 * to suspend. Writing 1 to this undocumented register bit
+		 * disables this feature and restores normal behavior.
+		 */
+		ehci_write(regs, EHCI_INSNREG04,
+			   EHCI_INSNREG04_DISABLE_UNSUSPEND);
+
+		/* Soft reset the PHY using PHY reset command over ULPI */
+		if (pdata->port_mode[0] == OMAP_EHCI_PORT_MODE_PHY)
+			omap_ehci_soft_phy_reset(dev, 0);
+		if (pdata->port_mode[1] == OMAP_EHCI_PORT_MODE_PHY)
+			omap_ehci_soft_phy_reset(dev, 1);
+
+		/* root ports should always stay powered */
+		ehci_port_power(hcd_to_ehci(hcd), 1);
+	}
+
+	return ehci_bus_resume(hcd);
+}
+
 /*-------------------------------------------------------------------------*/
 
 static const struct hc_driver ehci_omap_hc_driver = {
@@ -368,7 +405,7 @@ static const struct hc_driver ehci_omap_hc_driver = {
 	.hub_status_data	= ehci_hub_status_data,
 	.hub_control		= ehci_hub_control,
 	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
+	.bus_resume		= omap_ehci_bus_resume,
 
 	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
