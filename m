From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 4/9] ehci: fix phy_reset init in ehci probe
Date: Thu,  6 Aug 2009 17:37:35 +0530
Message-ID: <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46426 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbZHFMIS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 08:08:18 -0400
In-Reply-To: <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

phy_reset is not getting updated from platform_data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 0058f03..55e5259 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -33,7 +33,6 @@
  *	- add suspend/resume
  *	- move workarounds to board-files
  *	- differentiate between ES2.x and ES3.x
- *	- make it enumerate devices
  */
 
 #include <linux/platform_device.h>
@@ -590,6 +589,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, omap);
 	omap->dev		= &pdev->dev;
+	omap->phy_reset		= pdata->phy_reset;
 	omap->reset_gpio_port1	= pdata->reset_gpio_port1;
 	omap->reset_gpio_port2	= pdata->reset_gpio_port2;
 	omap->phy_mode		= pdata->phy_mode;
-- 
1.6.2.4

