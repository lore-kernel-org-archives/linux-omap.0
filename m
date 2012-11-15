From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 10/16] mfd: omap-usb-host: Intialize all available ports
Date: Thu, 15 Nov 2012 16:34:08 +0200
Message-ID: <1352990054-14680-11-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54703 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768031Ab2KOOea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:34:30 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

OMAPs till date can have upto 3 ports. We need to initialize
the port mode in HOSTCONFIG register for all of them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index c20234b..0d39bd7 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -67,12 +67,9 @@
 #define OMAP4_UHH_SYSCONFIG_NOSTDBY			(1 << 4)
 #define OMAP4_UHH_SYSCONFIG_SOFTRESET			(1 << 0)
 
-#define OMAP4_P1_MODE_CLEAR				(3 << 16)
+#define OMAP4_P1_MODE_MASK				(3 << 16)
 #define OMAP4_P1_MODE_TLL				(1 << 16)
 #define OMAP4_P1_MODE_HSIC				(3 << 16)
-#define OMAP4_P2_MODE_CLEAR				(3 << 18)
-#define OMAP4_P2_MODE_TLL				(1 << 18)
-#define OMAP4_P2_MODE_HSIC				(3 << 18)
 
 #define	OMAP_UHH_DEBUG_CSR				(0x44)
 
@@ -343,6 +340,7 @@ static void omap_usbhs_init(struct device *dev)
 	struct usbhs_omap_platform_data	*pdata = omap->pdata;
 	unsigned long			flags;
 	unsigned			reg;
+	int i;
 
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
 
@@ -403,21 +401,16 @@ static void omap_usbhs_init(struct device *dev)
 				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
 		}
 	} else if (is_omap_usbhs_rev2(omap)) {
-		/* Clear port mode fields for PHY mode*/
-		reg &= ~OMAP4_P1_MODE_CLEAR;
-		reg &= ~OMAP4_P2_MODE_CLEAR;
-
-		if (is_ehci_tll_mode(pdata->port_mode[0]) ||
-			(is_ohci_port(pdata->port_mode[0])))
-			reg |= OMAP4_P1_MODE_TLL;
-		else if (is_ehci_hsic_mode(pdata->port_mode[0]))
-			reg |= OMAP4_P1_MODE_HSIC;
-
-		if (is_ehci_tll_mode(pdata->port_mode[1]) ||
-			(is_ohci_port(pdata->port_mode[1])))
-			reg |= OMAP4_P2_MODE_TLL;
-		else if (is_ehci_hsic_mode(pdata->port_mode[1]))
-			reg |= OMAP4_P2_MODE_HSIC;
+		for (i = 0; i < omap->nports; i++) {
+			/* Clear port mode fields for PHY mode*/
+			reg &= ~(OMAP4_P1_MODE_MASK << 2*i);
+
+			if (is_ehci_tll_mode(pdata->port_mode[i]) ||
+				(is_ohci_port(pdata->port_mode[i])))
+				reg |= OMAP4_P1_MODE_TLL << 2*i;
+			else if (is_ehci_hsic_mode(pdata->port_mode[i]))
+				reg |= OMAP4_P1_MODE_HSIC << 2*i;
+		}
 	}
 
 	usbhs_write(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-- 
1.7.4.1

