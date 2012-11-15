From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] mfd: fix spelling of OMAP in Kconfig
Date: Thu, 15 Nov 2012 14:10:23 +0100
Message-ID: <1352985023-26030-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49471 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767709Ab2KONLV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 08:11:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, tony@atomide.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/mfd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index acab3ef..a0fc8c0 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -941,7 +941,7 @@ config MFD_OMAP_USB_HOST
 	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
 	default y
 	help
-	  This is the core driver for the OAMP EHCI and OHCI drivers.
+	  This is the core driver for the OMAP EHCI and OHCI drivers.
 	  This MFD driver does the required setup functionalities for
 	  OMAP USB Host drivers.
 
-- 
1.7.9.5

