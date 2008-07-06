From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 3/4] Hook start_hnp into ohci struct
Date: Sun, 6 Jul 2008 14:26:30 +0400
Message-ID: <20080706102630.GA29934__27356.4112875194$1215345144$gmane$org@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:46457 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYGFLvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2008 07:51:04 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1054826fkq.5
        for <linux-omap@vger.kernel.org>; Sun, 06 Jul 2008 04:51:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/usb/host/ohci-hub.c  |    4 +---
 drivers/usb/host/ohci-omap.c |    1 +
 drivers/usb/host/ohci.h      |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 79a7802..6a4e5b6 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -581,8 +581,6 @@ static int ohci_start_port_reset (struct usb_hcd *hcd, unsigned port)
 	return 0;
 }
 
-static void start_hnp(struct ohci_hcd *ohci);
-
 #else
 
 #define	ohci_start_port_reset		NULL
@@ -769,7 +767,7 @@ static int ohci_hub_control (
 #ifdef	CONFIG_USB_OTG
 			if (hcd->self.otg_port == (wIndex + 1)
 					&& hcd->self.b_hnp_enable)
-				start_hnp(ohci);
+				ohci->start_hnp(ohci);
 			else
 #endif
 			ohci_writel (ohci, RH_PS_PSS,
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 4f21646..8b92532 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -222,6 +222,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 			dev_err(hcd->self.controller, "can't find transceiver\n");
 			return -ENODEV;
 		}
+		ohci->start_hnp = start_hnp;
 	}
 #endif
 
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 4e3d9b2..90e17b0 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -371,6 +371,7 @@ struct ohci_hcd {
 	 * other external transceivers should be software-transparent
 	 */
 	struct otg_transceiver	*transceiver;
+	void (*start_hnp)(struct ohci_hcd *ohci);
 
 	/*
 	 * memory management for queue data structures
-- 
1.5.6


-- 
With best wishes
Dmitry

