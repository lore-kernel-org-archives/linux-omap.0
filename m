From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 12/13] USB: ehci-omap: Fix detection in HSIC mode
Date: Wed, 13 Mar 2013 15:14:43 +0200
Message-ID: <1363180483-10612-1-git-send-email-rogerq@ti.com>
References: <1363086540-30567-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363086540-30567-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: balbi@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Move PHY initialization until after EHCI initialization is
complete, instead of initializing the PHYs first, shutting
them down again, and then initializing them a second time.

This fixes HSIC device detection.

Signed-off-by: Roger Quadros <rogerq@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-omap.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1ba1df8..755b428 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -90,26 +90,13 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
 static int omap_ehci_init(struct usb_hcd *hcd)
 {
 	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
-	struct omap_hcd	*omap = (struct omap_hcd *)ehci->priv;
-	int rc, i;
-
-	/* Hold PHYs in reset while initializing EHCI controller */
-	for (i = 0; i < omap->nports; i++) {
-		if (omap->phy[i])
-			usb_phy_shutdown(omap->phy[i]);
-	}
+	int rc;
 
 	/* we know this is the memory we want, no need to ioremap again */
 	ehci->caps = hcd->regs;
 
 	rc = ehci_setup(hcd);
 
-	/* Bring PHYs out of reset */
-	for (i = 0; i < omap->nports; i++) {
-		if (omap->phy[i])
-			usb_phy_init(omap->phy[i]);
-	}
-
 	return rc;
 }
 
@@ -219,9 +206,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		}
 
 		omap->phy[i] = phy;
-		usb_phy_init(omap->phy[i]);
-		/* bring PHY out of suspend */
-		usb_phy_set_suspend(omap->phy[i], 0);
 	}
 
 	pm_runtime_enable(dev);
@@ -245,6 +229,20 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_pm_runtime;
 	}
 
+	/*
+	 * Bring PHYs out of reset.
+	 * Even though HSIC mode is a PHY-less mode, the reset
+	 * line exists between the chips and can be modelled
+	 * as a PHY device for reset control.
+	 */
+	for (i = 0; i < omap->nports; i++) {
+		if (!omap->phy[i])
+			continue;
+
+		usb_phy_init(omap->phy[i]);
+		/* bring PHY out of suspend */
+		usb_phy_set_suspend(omap->phy[i], 0);
+	}
 
 	return 0;
 
-- 
1.7.4.1
