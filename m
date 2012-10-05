From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 15/32 v2] USB: ohci: merge ohci_finish_controller_resume with ohci_resume
Date: Fri,  5 Oct 2012 18:20:47 +0200
Message-ID: <1349454064-11606-16-git-send-email-florian@openwrt.org>
References: <1349454064-11606-1-git-send-email-florian@openwrt.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349454064-11606-1-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Merge ohci_finish_controller_resume with ohci_resume as suggested by Alan
Stern. Since ohci_finish_controller_resume no longer exists, update the
various OHCI drivers to call ohci_resume() instead. Some drivers used to set
themselves the bit HCD_FLAG_HW_ACCESSIBLE, which is now handled by
ohci_resume().

Acked-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
Changes since v1:
- added Nicolas and Jingoo's Acked-by

 drivers/usb/host/ohci-at91.c     |    2 +-
 drivers/usb/host/ohci-ep93xx.c   |    2 +-
 drivers/usb/host/ohci-exynos.c   |    5 +----
 drivers/usb/host/ohci-hcd.c      |   41 +++++++++++++++++++++++++++++++++++--
 drivers/usb/host/ohci-hub.c      |   42 --------------------------------------
 drivers/usb/host/ohci-omap.c     |    2 +-
 drivers/usb/host/ohci-platform.c |    2 +-
 drivers/usb/host/ohci-pxa27x.c   |    2 +-
 drivers/usb/host/ohci-s3c2410.c  |    3 +--
 drivers/usb/host/ohci-spear.c    |    2 +-
 drivers/usb/host/ohci-tmio.c     |    2 +-
 11 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 0bf72f9..908d84a 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -705,7 +705,7 @@ static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
 	if (!clocked)
 		at91_start_clock();
 
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 	return 0;
 }
 #else
diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index dbfbd1d..a982f04 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -194,7 +194,7 @@ static int ohci_hcd_ep93xx_drv_resume(struct platform_device *pdev)
 
 	ep93xx_start_hc(&pdev->dev);
 
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 	return 0;
 }
 #endif
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index fc3091b..53c5a989 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -252,10 +252,7 @@ static int exynos_ohci_resume(struct device *dev)
 	if (pdata && pdata->phy_init)
 		pdata->phy_init(pdev, S5P_USB_PHY_HOST);
 
-	/* Mark hardware accessible again as we are out of D3 state by now */
-	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
-
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 
 	return 0;
 }
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index acf8c83..d97dc48 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1005,13 +1005,50 @@ static int __maybe_unused ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 
 static int __maybe_unused ohci_resume(struct usb_hcd *hcd, bool hibernated)
 {
+	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
+	int			port;
+	bool			need_reinit = false;
+
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 
 	/* Make sure resume from hibernation re-enumerates everything */
 	if (hibernated)
-		ohci_usb_reset(hcd_to_ohci(hcd));
+		ohci_usb_reset(ohci);
+
+	/* See if the controller is already running or has been reset */
+	ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
+	if (ohci->hc_control & (OHCI_CTRL_IR | OHCI_SCHED_ENABLES)) {
+		need_reinit = true;
+	} else {
+		switch (ohci->hc_control & OHCI_CTRL_HCFS) {
+		case OHCI_USB_OPER:
+		case OHCI_USB_RESET:
+			need_reinit = true;
+		}
+	}
+
+	/* If needed, reinitialize and suspend the root hub */
+	if (need_reinit) {
+		spin_lock_irq(&ohci->lock);
+		ohci_rh_resume(ohci);
+		ohci_rh_suspend(ohci, 0);
+		spin_unlock_irq(&ohci->lock);
+	}
+
+	/* Normally just turn on port power and enable interrupts */
+	else {
+		ohci_dbg(ohci, "powerup ports\n");
+		for (port = 0; port < ohci->num_ports; port++)
+			ohci_writel(ohci, RH_PS_PPS,
+					&ohci->regs->roothub.portstatus[port]);
+
+		ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
+		ohci_readl(ohci, &ohci->regs->intrenable);
+		msleep(20);
+	}
+
+	usb_hcd_resume_root_hub(hcd);
 
-	ohci_finish_controller_resume(hcd);
 	return 0;
 }
 
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 2f3619e..db09dae 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -316,48 +316,6 @@ static int ohci_bus_resume (struct usb_hcd *hcd)
 	return rc;
 }
 
-/* Carry out the final steps of resuming the controller device */
-static void __maybe_unused ohci_finish_controller_resume(struct usb_hcd *hcd)
-{
-	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
-	int			port;
-	bool			need_reinit = false;
-
-	/* See if the controller is already running or has been reset */
-	ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
-	if (ohci->hc_control & (OHCI_CTRL_IR | OHCI_SCHED_ENABLES)) {
-		need_reinit = true;
-	} else {
-		switch (ohci->hc_control & OHCI_CTRL_HCFS) {
-		case OHCI_USB_OPER:
-		case OHCI_USB_RESET:
-			need_reinit = true;
-		}
-	}
-
-	/* If needed, reinitialize and suspend the root hub */
-	if (need_reinit) {
-		spin_lock_irq(&ohci->lock);
-		ohci_rh_resume(ohci);
-		ohci_rh_suspend(ohci, 0);
-		spin_unlock_irq(&ohci->lock);
-	}
-
-	/* Normally just turn on port power and enable interrupts */
-	else {
-		ohci_dbg(ohci, "powerup ports\n");
-		for (port = 0; port < ohci->num_ports; port++)
-			ohci_writel(ohci, RH_PS_PPS,
-					&ohci->regs->roothub.portstatus[port]);
-
-		ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
-		ohci_readl(ohci, &ohci->regs->intrenable);
-		msleep(20);
-	}
-
-	usb_hcd_resume_root_hub(hcd);
-}
-
 /* Carry out polling-, autostop-, and autoresume-related state changes */
 static int ohci_root_hub_state_changes(struct ohci_hcd *ohci, int changed,
 		int any_connected, int rhsc_status)
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f8b2d91..9fab4d8 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -530,7 +530,7 @@ static int ohci_omap_resume(struct platform_device *dev)
 	ohci->next_statechange = jiffies;
 
 	omap_ohci_clock_power(1);
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 	return 0;
 }
 
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 1caaf65..99d1755 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -203,7 +203,7 @@ static int ohci_platform_resume(struct device *dev)
 			return err;
 	}
 
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 	return 0;
 }
 
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 77f4402..8bffde3 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -591,7 +591,7 @@ static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
 	/* Select Power Management Mode */
 	pxa27x_ohci_select_pmm(ohci, inf->port_mode);
 
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 	return 0;
 }
 
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 664c869..8af53c6 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -524,8 +524,7 @@ static int ohci_hcd_s3c2410_drv_resume(struct device *dev)
 
 	s3c2410_start_hc(pdev, hcd);
 
-	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 
 	return 0;
 }
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index fc7305e..d607be3 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -231,7 +231,7 @@ static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
 	ohci->next_statechange = jiffies;
 
 	spear_start_ohci(ohci_p);
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 	return 0;
 }
 #endif
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 60c2b07..2c9ab8f 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -352,7 +352,7 @@ static int ohci_hcd_tmio_drv_resume(struct platform_device *dev)
 
 	spin_unlock_irqrestore(&tmio->lock, flags);
 
-	ohci_finish_controller_resume(hcd);
+	ohci_resume(hcd, false);
 
 	return 0;
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
