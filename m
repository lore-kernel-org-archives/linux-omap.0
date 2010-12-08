From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/7] mfd: TWL6030: USBOTG VBUS event generation on
Date: Wed,  8 Dec 2010 13:59:32 +0530
Message-ID: <1291796972-23526-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With TWL6030-usb, VBUS SESS_VLD and SESS_END events are not generated
as expected. When these interrupts are enabled, charger VBUS detection
interrupt does not get generated. So USBOTG has to be dependent on charger
VBUS interrupts.
So added one bit for USBOTG and changed the handler to call the 
USBOTG handler whenever there is a charger VBUS interrupt.

VBUS SESS_VLD and SESS_END event generation issue is under debug with
HW team. This fix might not be required once after fixing the issue.

Signed-off-by: Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/mfd/twl6030-irq.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/mfd/twl6030-irq.c
===================================================================
--- linux-2.6.orig/drivers/mfd/twl6030-irq.c
+++ linux-2.6/drivers/mfd/twl6030-irq.c
@@ -74,7 +74,7 @@ static int twl6030_interrupt_mapping[24]
 	USBOTG_INTR_OFFSET,	/* Bit 16	ID_WKUP			*/
 	USBOTG_INTR_OFFSET,	/* Bit 17	VBUS_WKUP		*/
 	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
-	USBOTG_INTR_OFFSET,	/* Bit 19	VBUS			*/
+	USB_PRES_INTR_OFFSET,	/* Bit 19	VBUS			*/
 	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
 	CHARGER_INTR_OFFSET,	/* Bit 21	EXT_CHRG		*/
 	CHARGER_INTR_OFFSET,	/* Bit 22	INT_CHRG		*/
@@ -128,6 +128,13 @@ static int twl6030_irq_thread(void *data
 
 		sts.bytes[3] = 0; /* Only 24 bits are valid*/
 
+		/*
+		 * Since VBUS status bit is not reliable for VBUS disconnect
+		 * use CHARGER VBUS detection status bit instead.
+		 */
+		if (sts.bytes[2] & 0x10)
+			sts.bytes[2] |= 0x08;
+
 		for (i = 0; sts.int_sts; sts.int_sts >>= 1, i++) {
 			local_irq_disable();
 			if (sts.int_sts & 0x1) {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
