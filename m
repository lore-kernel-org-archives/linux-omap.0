From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 6/6] usb: renesas_usbhs: Replace the deprecated extcon API
Date: Fri, 30 Dec 2016 13:08:15 +0900
Message-ID: <1483070895-8213-7-git-send-email-cw00.choi@samsung.com>
References: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161230040817epcas5p48322c725a69442bebf3a36b3ba069c33@epcas5p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-omap@vger.kernel.org

This patch replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 012a37aa3e0d..623c51300393 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -389,7 +389,7 @@ static void usbhsc_hotplug(struct usbhs_priv *priv)
 
 	if (enable && !mod) {
 		if (priv->edev) {
-			cable = extcon_get_cable_state_(priv->edev, EXTCON_USB_HOST);
+			cable = extcon_get_state(priv->edev, EXTCON_USB_HOST);
 			if ((cable > 0 && id != USBHS_HOST) ||
 			    (!cable && id != USBHS_GADGET)) {
 				dev_info(&pdev->dev,
-- 
1.9.1
