From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 12/12] usb: renesas_usbhs: Replace the deprecated extcon API
Date: Wed, 30 Nov 2016 14:57:40 +0900
Message-ID: <1480485460-2663-13-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-reply-to: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

This patch replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
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
