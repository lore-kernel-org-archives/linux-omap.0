From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] extcon: palmas: Don't spam console
Date: Tue, 24 Jan 2017 16:54:07 +0200
Message-ID: <1485269647-552-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

User is not interested in USB cable events appearing on the
console. Use dev_dbg() instead of dev_info() for these events.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/extcon/extcon-palmas.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 634ba70..1d52065 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -62,7 +62,7 @@ static irqreturn_t palmas_vbus_irq_handler(int irq, void *_palmas_usb)
 		if (palmas_usb->linkstat != PALMAS_USB_STATE_VBUS) {
 			palmas_usb->linkstat = PALMAS_USB_STATE_VBUS;
 			extcon_set_state_sync(edev, EXTCON_USB, true);
-			dev_info(palmas_usb->dev, "USB cable is attached\n");
+			dev_dbg(palmas_usb->dev, "USB cable is attached\n");
 		} else {
 			dev_dbg(palmas_usb->dev,
 				"Spurious connect event detected\n");
@@ -71,7 +71,7 @@ static irqreturn_t palmas_vbus_irq_handler(int irq, void *_palmas_usb)
 		if (palmas_usb->linkstat == PALMAS_USB_STATE_VBUS) {
 			palmas_usb->linkstat = PALMAS_USB_STATE_DISCONNECT;
 			extcon_set_state_sync(edev, EXTCON_USB, false);
-			dev_info(palmas_usb->dev, "USB cable is detached\n");
+			dev_dbg(palmas_usb->dev, "USB cable is detached\n");
 		} else {
 			dev_dbg(palmas_usb->dev,
 				"Spurious disconnect event detected\n");
@@ -99,7 +99,7 @@ static irqreturn_t palmas_id_irq_handler(int irq, void *_palmas_usb)
 			PALMAS_USB_ID_INT_EN_HI_CLR_ID_GND);
 		palmas_usb->linkstat = PALMAS_USB_STATE_ID;
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, true);
-		dev_info(palmas_usb->dev, "USB-HOST cable is attached\n");
+		dev_dbg(palmas_usb->dev, "USB-HOST cable is attached\n");
 	} else if ((set & PALMAS_USB_ID_INT_SRC_ID_FLOAT) &&
 				(id_src & PALMAS_USB_ID_INT_SRC_ID_FLOAT)) {
 		palmas_write(palmas_usb->palmas, PALMAS_USB_OTG_BASE,
@@ -107,17 +107,17 @@ static irqreturn_t palmas_id_irq_handler(int irq, void *_palmas_usb)
 			PALMAS_USB_ID_INT_EN_HI_CLR_ID_FLOAT);
 		palmas_usb->linkstat = PALMAS_USB_STATE_DISCONNECT;
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, false);
-		dev_info(palmas_usb->dev, "USB-HOST cable is detached\n");
+		dev_dbg(palmas_usb->dev, "USB-HOST cable is detached\n");
 	} else if ((palmas_usb->linkstat == PALMAS_USB_STATE_ID) &&
 				(!(set & PALMAS_USB_ID_INT_SRC_ID_GND))) {
 		palmas_usb->linkstat = PALMAS_USB_STATE_DISCONNECT;
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, false);
-		dev_info(palmas_usb->dev, "USB-HOST cable is detached\n");
+		dev_dbg(palmas_usb->dev, "USB-HOST cable is detached\n");
 	} else if ((palmas_usb->linkstat == PALMAS_USB_STATE_DISCONNECT) &&
 				(id_src & PALMAS_USB_ID_INT_SRC_ID_GND)) {
 		palmas_usb->linkstat = PALMAS_USB_STATE_ID;
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, true);
-		dev_info(palmas_usb->dev, " USB-HOST cable is attached\n");
+		dev_dbg(palmas_usb->dev, " USB-HOST cable is attached\n");
 	}
 
 	return IRQ_HANDLED;
@@ -138,10 +138,10 @@ static void palmas_gpio_id_detect(struct work_struct *work)
 
 	if (id) {
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, false);
-		dev_info(palmas_usb->dev, "USB-HOST cable is detached\n");
+		dev_dbg(palmas_usb->dev, "USB-HOST cable is detached\n");
 	} else {
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, true);
-		dev_info(palmas_usb->dev, "USB-HOST cable is attached\n");
+		dev_dbg(palmas_usb->dev, "USB-HOST cable is attached\n");
 	}
 }
 
-- 
2.7.4
