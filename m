From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] usb: phy: omap: remove redundant dev_err call in omap_control_usb_probe()
Date: Sat, 12 Oct 2013 14:11:31 +0800
Message-ID: <CAPgLHd83P9YG4ryEGcuxr8k9UPhiVz5L+AQzivpD+H_nzZ4pZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:43923 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab3JLGLc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Oct 2013 02:11:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/usb/phy/phy-omap-control.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index 09c5ace..1321e3f 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -253,10 +253,8 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 				"power");
 		control_usb->power = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(control_usb->power)) {
-			dev_err(&pdev->dev, "Couldn't get power register\n");
+		if (IS_ERR(control_usb->power))
 			return PTR_ERR(control_usb->power);
-		}
 	}
 
 	if (control_usb->type == OMAP_CTRL_TYPE_PIPE3) {

