From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v9 11/13] usb: musb: dsps: get the PHY using phandle api
Date: Fri, 31 Aug 2012 16:39:57 +0530
Message-ID: <1346411399-23964-12-git-send-email-ravibabu@ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab2HaLKL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 07:10:11 -0400
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: Santhapuri, Damodar <damodar.santhapuri@ti.com>

AM33xx has two PHY of same type used by each musb controller so
use phandle of phy nodes to get the phy pointer.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 .../devicetree/bindings/usb/am33xx-usb.txt         |    2 ++
 drivers/usb/musb/musb_dsps.c                       |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index ca8fa56..b0caac3 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -12,3 +12,5 @@ AM33XX MUSB GLUE
    represents PERIPHERAL.
  - power : Should be "250". This signifies the controller can supply upto
    500mA when operating in host mode.
+ - usb0-phy : phandle for usb0 NOP PHY
+ - usb1-phy : phandle for usb1 NOP PHY
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index eb6bfec..992cd50 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -409,9 +409,11 @@ static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *parent_pdev = to_platform_device(dev->parent);
 	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	void __iomem *reg_base = musb->ctrl_base;
+	char name[10];
 	u32 rev, val;
 	int status;
 
@@ -419,7 +421,8 @@ static int dsps_musb_init(struct musb *musb)
 	musb->mregs += wrp->musb_core_offset;
 
 	/* Get the NOP PHY */
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	sprintf(name, "usb%d-phy", pdev->id);
+	musb->xceiv = devm_usb_get_phy_by_phandle(&parent_pdev->dev, name);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
 
-- 
1.7.0.4

