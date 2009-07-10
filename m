From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 4/8] ehci: fix phy_reset init in ehci probe
Date: Fri, 10 Jul 2009 14:47:10 +0530
Message-ID: <1247217434-6309-4-git-send-email-ajay.gupta@ti.com>
References: <1247217434-6309-1-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-2-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbZGJJRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jul 2009 05:17:30 -0400
In-Reply-To: <1247217434-6309-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

phy_reset is not getting updated from platform_data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 0058f03..8f8f022 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -590,6 +590,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, omap);
 	omap->dev		= &pdev->dev;
+	omap->phy_reset		= pdata->phy_reset;
 	omap->reset_gpio_port1	= pdata->reset_gpio_port1;
 	omap->reset_gpio_port2	= pdata->reset_gpio_port2;
 	omap->phy_mode		= pdata->phy_mode;
-- 
1.6.2.4

