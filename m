From: Ruchika Kharwar <ruchika@ti.com>
Subject: [PATCH] usb: dwc3: fix the error returned with usb3_phy failure
Date: Thu, 4 Jul 2013 00:59:34 -0500
Message-ID: <1372917575-23069-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46301 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197Ab3GDGAJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jul 2013 02:00:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ruchika Kharwar <ruchika@ti.com>

When there is an error with the usb3_phy probe or absence, the error returned
is erroneously for usb2_phy.

Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
---
 drivers/usb/dwc3/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c35d49d..358375e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -450,7 +450,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
+		ret = PTR_ERR(dwc->usb3_phy);
 
 		/*
 		 * if -ENXIO is returned, it means PHY layer wasn't
-- 
1.7.9.5

