From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 11/12] usb: phy: tahvo: Replace the deprecated extcon API
Date: Wed, 30 Nov 2016 14:57:39 +0900
Message-ID: <1480485460-2663-12-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-reply-to: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_set_state_sync()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/usb/phy/phy-tahvo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index 1343bff004eb..9a7822e12156 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -121,7 +121,7 @@ static void check_vbus_state(struct tahvo_usb *tu)
 	prev_state = tu->vbus_state;
 	tu->vbus_state = reg & TAHVO_STAT_VBUS;
 	if (prev_state != tu->vbus_state) {
-		extcon_set_cable_state_(tu->extcon, EXTCON_USB, tu->vbus_state);
+		extcon_set_state_sync(tu->extcon, EXTCON_USB, tu->vbus_state);
 		sysfs_notify(&tu->pt_dev->dev.kobj, NULL, "vbus_state");
 	}
 }
@@ -130,7 +130,7 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
 {
 	struct retu_dev *rdev = dev_get_drvdata(tu->pt_dev->dev.parent);
 
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB_HOST, true);
+	extcon_set_state_sync(tu->extcon, EXTCON_USB_HOST, true);
 
 	/* Power up the transceiver in USB host mode */
 	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
@@ -149,7 +149,7 @@ static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
 {
 	struct retu_dev *rdev = dev_get_drvdata(tu->pt_dev->dev.parent);
 
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB_HOST, false);
+	extcon_set_state_sync(tu->extcon, EXTCON_USB_HOST, false);
 
 	/* Power up transceiver and set it in USB peripheral mode */
 	retu_write(rdev, TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT |
@@ -379,9 +379,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 	}
 
 	/* Set the initial cable state. */
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB_HOST,
+	extcon_set_state_sync(tu->extcon, EXTCON_USB_HOST,
 			       tu->tahvo_mode == TAHVO_MODE_HOST);
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB, tu->vbus_state);
+	extcon_set_state_sync(tu->extcon, EXTCON_USB, tu->vbus_state);
 
 	/* Create OTG interface */
 	tahvo_usb_power_off(tu);
-- 
1.9.1
