From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/2] isp1704_charger: allow board specific powering routine
Date: Mon, 28 Mar 2011 09:33:04 +0300
Message-ID: <1301293985-21687-2-git-send-email-kalle.jokiniemi@nokia.com>
References: <1301293985-21687-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:30187 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab1C1Gdu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 02:33:50 -0400
In-Reply-To: <1301293985-21687-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
Cc: heikki.krogerus@nokia.com, jhnikula@gmail.com, khilman@ti.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

The ISP1704/1707 chip can be put to full power down
state by asserting the CHIP_SEL line. This patch enables
platform or board specific hooks to put the device into
power down mode in case not needed.

These patches are preparatio for enabling this powering
routine in n900 (rx-51) devices.

Thanks to Heikki Krogerus for helping out with the patch.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
---
 drivers/power/isp1704_charger.c       |   23 +++++++++++++++++++++++
 include/linux/power/isp1704_charger.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/power/isp1704_charger.h

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index 2ad9b14..06f69c7 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -33,6 +33,7 @@
 #include <linux/usb/ulpi.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/power/isp1704_charger.h>
 
 /* Vendor specific Power Control register */
 #define ISP1704_PWR_CTRL		0x3d
@@ -71,6 +72,18 @@ struct isp1704_charger {
 };
 
 /*
+ * Disable/enable the power from the isp1704 if a function for it
+ * has been provided with platform data.
+ */
+static void isp1704_charger_set_power(struct isp1704_charger *isp, bool on)
+{
+	struct isp1704_charger_data	*board = isp->dev->platform_data;
+
+	if (board->set_power)
+		board->set_power(on);
+}
+
+/*
  * Determine is the charging port DCP (dedicated charger) or CDP (Host/HUB
  * chargers).
  *
@@ -222,6 +235,9 @@ static void isp1704_charger_work(struct work_struct *data)
 
 	mutex_lock(&lock);
 
+	if (event != USB_EVENT_NONE)
+		isp1704_charger_set_power(isp, 1);
+
 	switch (event) {
 	case USB_EVENT_VBUS:
 		isp->online = true;
@@ -269,6 +285,8 @@ static void isp1704_charger_work(struct work_struct *data)
 		 */
 		if (isp->otg->gadget)
 			usb_gadget_disconnect(isp->otg->gadget);
+		/* As last thing, disable the power from the charger */
+		isp1704_charger_set_power(isp, 0);
 		break;
 	case USB_EVENT_ENUMERATED:
 		if (isp->present)
@@ -394,6 +412,8 @@ static int __devinit isp1704_charger_probe(struct platform_device *pdev)
 	isp->dev = &pdev->dev;
 	platform_set_drvdata(pdev, isp);
 
+	isp1704_charger_set_power(isp, 1);
+
 	ret = isp1704_test_ulpi(isp);
 	if (ret < 0)
 		goto fail1;
@@ -437,6 +457,8 @@ static int __devinit isp1704_charger_probe(struct platform_device *pdev)
 	if ((ret & ULPI_INT_VBUS_VALID) && !isp->otg->default_a) {
 		isp->event = USB_EVENT_VBUS;
 		schedule_work(&isp->work);
+	} else {
+		isp1704_charger_set_power(isp, 0);
 	}
 
 	return 0;
@@ -459,6 +481,7 @@ static int __devexit isp1704_charger_remove(struct platform_device *pdev)
 	otg_unregister_notifier(isp->otg, &isp->nb);
 	power_supply_unregister(&isp->psy);
 	otg_put_transceiver(isp->otg);
+	isp1704_charger_set_power(isp, 0);
 	kfree(isp);
 
 	return 0;
diff --git a/include/linux/power/isp1704_charger.h b/include/linux/power/isp1704_charger.h
new file mode 100644
index 0000000..68096a6
--- /dev/null
+++ b/include/linux/power/isp1704_charger.h
@@ -0,0 +1,29 @@
+/*
+ * ISP1704 USB Charger Detection driver
+ *
+ * Copyright (C) 2011 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+
+#ifndef __ISP1704_CHARGER_H
+#define __ISP1704_CHARGER_H
+
+struct isp1704_charger_data {
+	void		(*set_power)(bool on);
+};
+
+#endif
-- 
1.7.1

