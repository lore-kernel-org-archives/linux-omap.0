From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 08/10] usb: ehci: marvel: check against CONFIG_USB_PHY
Date: Thu, 7 Mar 2013 11:36:07 +0200
Message-ID: <1362648969-13737-9-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362648969-13737-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CONFIG_USB_OTG_UTILS will be removed very
soon, so we should check CONFIG_USB_PHY
instead.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-mv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 3065809..9751823 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -240,7 +240,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 
 	ehci_mv->mode = pdata->mode;
 	if (ehci_mv->mode == MV_USB_MODE_OTG) {
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 		ehci_mv->otg = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
 		if (IS_ERR_OR_NULL(ehci_mv->otg)) {
 			dev_err(&pdev->dev,
@@ -260,7 +260,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		mv_ehci_disable(ehci_mv);
 #else
 		dev_info(&pdev->dev, "MV_USB_MODE_OTG "
-			 "must have CONFIG_USB_OTG_UTILS enabled\n");
+			 "must have CONFIG_USB_PHY enabled\n");
 		goto err_disable_clk;
 #endif
 	} else {
-- 
1.8.1.rc1.5.g7e0651a

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
