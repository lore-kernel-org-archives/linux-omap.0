From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 11/11] usb: dwc3: core: stray statements are removed
Date: Fri, 25 Jan 2013 08:30:55 +0530
Message-ID: <1359082855-7404-12-git-send-email-kishon@ti.com>
References: <1359082855-7404-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47820 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841Ab3AYDBK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 22:01:10 -0500
In-Reply-To: <1359082855-7404-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, gregkh@linuxfoundation.org, kishon@ti.com

No functional change. Stray statements where removed from dwc3 core.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/core.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index af189d5..ee1fa18 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -558,9 +558,6 @@ err0:
 static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
-	struct resource	*res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-- 
1.7.9.5

