From: Hema HK <hemahk@ti.com>
Subject: [PATCH 1/7] mfd: TWL6030: USBOTG VBUS event generation on
Date: Tue,  7 Dec 2010 19:10:47 -0500
Message-ID: <1291767047-10041-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44327 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab0LGNiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 08:38:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb-owner@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Balaji TK <balajitk@ti.com>, Felipe Balbi <balbi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

With TWL6030-usb, VBUS SESS_VLD and SESS_END events are not generated
as expected. When these interrupts are enabled, charger VBUS detection
interrupt does not get generated. So USBOTG has to be dependent on charger
VBUS interrupts.
So added one bit for USBOTG and changed the handler to call the 
USBOTG handler whenever there is a charger VBUS interrpt.

VBUS SESS_VLD and SESS_END event generation issue is under debug with
HW team. This fix might not be required once after fixing the issue.

Signed-off-by: Balaji TK <balajitk@ti.com>
Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
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
