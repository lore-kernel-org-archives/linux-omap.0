From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] ehci: omap: fix kernel panic with rmmod
Date: Thu, 18 Mar 2010 16:58:35 +0530
Message-ID: <1268911715-10279-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57034 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab0CRL2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 07:28:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

Sets the regulator values to NULL if they are not defined. This
is required to fix the kernel panic in exit path when EHCI module
is removed on the platforms where EHCI regulator are not set.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f0282d6..c45ee0b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -628,11 +628,13 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		}
 		snprintf(supply, sizeof(supply), "hsusb%d", i);
 		omap->regulator[i] = regulator_get(omap->dev, supply);
-		if (IS_ERR(omap->regulator[i]))
+		if (IS_ERR(omap->regulator[i])) {
+			omap->regulator[i] = NULL;
 			dev_dbg(&pdev->dev,
 			"failed to get ehci port%d regulator\n", i);
-		else
+		} else {
 			regulator_enable(omap->regulator[i]);
+		}
 	}
 
 	ret = omap_start_ehc(omap, hcd);
-- 
1.6.2.4

