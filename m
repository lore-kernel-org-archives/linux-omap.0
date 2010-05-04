From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/2] usb: ehci-omap: fix compilation warning
Date: Tue,  4 May 2010 13:15:22 +0530
Message-ID: <1272959123-31362-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42497 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756658Ab0EDHpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 03:45:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes below compilation warning:
drivers/usb/host/ehci-hcd.c:425:
	warning: 'ehci_port_power' defined but not used

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 40a8583..e55fd58 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -659,6 +659,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_add_hcd;
 	}
 
+	ehci_port_power(omap->ehci, 0);
+
 	return 0;
 
 err_add_hcd:
-- 
1.6.2.4

