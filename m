From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 4/8] usb: otg: palmas-usb: use mailbox API to send VBUS or
 ID events
Date: Fri, 25 Jan 2013 08:42:27 +0530
Message-ID: <1359083551-8524-5-git-send-email-kishon@ti.com>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359083551-8524-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Whenever palmas detects a VBUS or ID event, the mailbox API in dwc3 glue
is called. The mailbox API takes care of notifying it to the core.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/palmas-usb.c |   32 +++++++++++++++++++++-----------
 include/linux/mfd/palmas.h   |    4 +++-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/otg/palmas-usb.c b/drivers/usb/otg/palmas-usb.c
index be9d81c..1bd8b15 100644
--- a/drivers/usb/otg/palmas-usb.c
+++ b/drivers/usb/otg/palmas-usb.c
@@ -33,6 +33,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/phy_companion.h>
 #include <linux/usb/omap_usb.h>
+#include <linux/usb/dwc3-omap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/notifier.h>
@@ -85,13 +86,14 @@ static ssize_t palmas_usb_vbus_show(struct device *dev,
 	spin_lock_irqsave(&palmas_usb->lock, flags);
 
 	switch (palmas_usb->linkstat) {
-	case USB_EVENT_VBUS:
+	case OMAP_DWC3_VBUS_VALID:
 	       ret = snprintf(buf, PAGE_SIZE, "vbus\n");
 	       break;
-	case USB_EVENT_ID:
+	case OMAP_DWC3_ID_GROUND:
 	       ret = snprintf(buf, PAGE_SIZE, "id\n");
 	       break;
-	case USB_EVENT_NONE:
+	case OMAP_DWC3_ID_FLOAT:
+	case OMAP_DWC3_VBUS_OFF:
 	       ret = snprintf(buf, PAGE_SIZE, "none\n");
 	       break;
 	default:
@@ -106,7 +108,7 @@ static DEVICE_ATTR(vbus, 0444, palmas_usb_vbus_show, NULL);
 static irqreturn_t palmas_vbus_wakeup_irq(int irq, void *_palmas_usb)
 {
 	struct palmas_usb *palmas_usb = _palmas_usb;
-	int status = 0;
+	enum omap_dwc3_vbus_id_status status = OMAP_DWC3_UNKNOWN;
 	int slave;
 	unsigned int vbus_line_state, addr;
 
@@ -118,20 +120,24 @@ static irqreturn_t palmas_vbus_wakeup_irq(int irq, void *_palmas_usb)
 
 	if (vbus_line_state & PALMAS_INT3_LINE_STATE_VBUS) {
 		regulator_enable(palmas_usb->vbus_reg);
-		status = USB_EVENT_VBUS;
+		status = OMAP_DWC3_VBUS_VALID;
 	} else {
-		status = USB_EVENT_NONE;
+		status = OMAP_DWC3_VBUS_OFF;
 		regulator_disable(palmas_usb->vbus_reg);
 	}
 
 	palmas_usb->linkstat = status;
+	if (status != OMAP_DWC3_UNKNOWN) {
+		dwc3_omap_mailbox(status);
+		return IRQ_HANDLED;
+	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static irqreturn_t palmas_id_wakeup_irq(int irq, void *_palmas_usb)
 {
-	int			status = 0;
+	enum omap_dwc3_vbus_id_status status = OMAP_DWC3_UNKNOWN;
 	unsigned int		set;
 	struct palmas_usb	*palmas_usb = _palmas_usb;
 
@@ -145,7 +151,7 @@ static irqreturn_t palmas_id_wakeup_irq(int irq, void *_palmas_usb)
 		palmas_usb_write(palmas_usb->palmas,
 					PALMAS_USB_ID_INT_EN_HI_CLR,
 					PALMAS_USB_ID_INT_EN_HI_CLR_ID_GND);
-		status = USB_EVENT_ID;
+		status = OMAP_DWC3_ID_GROUND;
 	} else if (set & PALMAS_USB_ID_INT_SRC_ID_FLOAT) {
 		palmas_usb_write(palmas_usb->palmas,
 					PALMAS_USB_ID_INT_EN_HI_SET,
@@ -154,12 +160,16 @@ static irqreturn_t palmas_id_wakeup_irq(int irq, void *_palmas_usb)
 					PALMAS_USB_ID_INT_EN_HI_CLR,
 					PALMAS_USB_ID_INT_EN_HI_CLR_ID_FLOAT);
 		regulator_disable(palmas_usb->vbus_reg);
-		status = USB_EVENT_NONE;
+		status = OMAP_DWC3_ID_FLOAT;
 	}
 
 	palmas_usb->linkstat = status;
+	if (status != OMAP_DWC3_UNKNOWN) {
+		dwc3_omap_mailbox(status);
+		return IRQ_HANDLED;
+	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int palmas_enable_irq(struct palmas_usb *palmas_usb)
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index a557db6..d6c3bec 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -20,6 +20,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/usb/phy_companion.h>
+#include <linux/usb/dwc3-omap.h>
+#include <linux/platform_data/dwc3-omap.h>
 
 #define PALMAS_NUM_CLIENTS		3
 
@@ -361,7 +363,7 @@ struct palmas_usb {
 
 	int vbus_enable;
 
-	u8 linkstat;
+	enum omap_dwc3_vbus_id_status linkstat;
 };
 
 #define comparator_to_palmas(x) container_of((x), struct palmas_usb, comparator)
-- 
1.7.9.5
