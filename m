From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 6/8] usb: ehci-omap: add helpers for checking port mode
Date: Mon, 29 Nov 2010 22:55:35 +0530
Message-ID: <1291051537-23743-7-git-send-email-gadiyar@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291051537-23743-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Introduce helper functions to test port mode. These checks are
performed in several places in the driver, and these helpers
improve readability.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7a4682c..dd9d5c1 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -127,6 +127,9 @@
 #define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT		8
 #define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT		0
 
+#define is_ehci_phy_mode(x)	(x == EHCI_HCD_OMAP_MODE_PHY)
+#define is_ehci_tll_mode(x)	(x == EHCI_HCD_OMAP_MODE_TLL)
+
 /*-------------------------------------------------------------------------*/
 
 static inline void ehci_omap_writel(void __iomem *base, u32 reg, u32 val)
@@ -387,27 +390,27 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	/* Bypass the TLL module for PHY mode operation */
 	if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
 		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");
-		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
-			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
-				(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
+		if (is_ehci_phy_mode(omap->port_mode[0]) ||
+			is_ehci_phy_mode(omap->port_mode[1]) ||
+				is_ehci_phy_mode(omap->port_mode[2]))
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
 		else
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
 	} else {
 		dev_dbg(omap->dev, "OMAP3 ES version > ES2.1\n");
-		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+		if (is_ehci_phy_mode(omap->port_mode[0]))
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
-		else if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+		else if (is_ehci_tll_mode(omap->port_mode[0]))
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
 
-		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+		if (is_ehci_phy_mode(omap->port_mode[1]))
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
-		else if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+		else if (is_ehci_tll_mode(omap->port_mode[1]))
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
 
-		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY)
+		if (is_ehci_phy_mode(omap->port_mode[2]))
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
-		else if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
+		else if (is_ehci_tll_mode(omap->port_mode[2]))
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
 
 	}
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
