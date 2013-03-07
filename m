From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 09/10] usb: ehci: tegra: check against CONFIG_USB_PHY
Date: Thu, 7 Mar 2013 11:36:08 +0200
Message-ID: <1362648969-13737-10-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874Ab3CGJgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 04:36:42 -0500
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
 drivers/usb/host/ehci-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 568aecc..fafbc81 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -768,7 +768,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (pdata->operating_mode == TEGRA_USB_OTG) {
 		tegra->transceiver =
 			devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
@@ -794,7 +794,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	return err;
 
 fail:
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(tegra->transceiver))
 		otg_set_host(tegra->transceiver->otg, NULL);
 #endif
@@ -815,7 +815,7 @@ static int tegra_ehci_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(tegra->transceiver))
 		otg_set_host(tegra->transceiver->otg, NULL);
 #endif
-- 
1.8.1.rc1.5.g7e0651a

