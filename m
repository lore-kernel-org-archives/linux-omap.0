From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/10] usb: gadget: mv_udc_core: check against CONFIG_USB_PHY
Date: Thu, 7 Mar 2013 11:36:06 +0200
Message-ID: <1362648969-13737-8-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36508 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107Ab3CGJgk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:40 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

CONFIG_USB_OTG_UTILS will be removed very
soon, so we should check CONFIG_USB_PHY
instead.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/mv_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index d278e8f..d550b21 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2127,7 +2127,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 	udc->dev = pdev;
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (pdata->mode == MV_USB_MODE_OTG) {
 		udc->transceiver = devm_usb_get_phy(&pdev->dev,
 					USB_PHY_TYPE_USB2);
-- 
1.8.1.rc1.5.g7e0651a

