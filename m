From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: [PATCH 1/1] twl4030_charger: Make the driver atomic notifier safe
Date: Fri, 25 Feb 2011 13:56:36 +0200
Message-ID: <1298634996-25722-2-git-send-email-heikki.krogerus@nokia.com>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.153]:18516 "EHLO mgw-sa03.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932090Ab1BYMaJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 07:30:09 -0500
In-Reply-To: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, notasas@gmail.com, cbouatmailru@gmail.com

This queues work from the otg notification where the
i2c operations can be safely made. Needed for atomic otg
notifiers.

Signed-off-by: Heikki Krogerus <heikki.krogerus@nokia.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/power/twl4030_charger.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index ff1f423..92c16e1 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -71,8 +71,11 @@ struct twl4030_bci {
 	struct power_supply	usb;
 	struct otg_transceiver	*transceiver;
 	struct notifier_block	otg_nb;
+	struct work_struct	work;
 	int			irq_chg;
 	int			irq_bci;
+
+	unsigned long		event;
 };
 
 /*
@@ -258,14 +261,11 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
-			       void *priv)
+static void twl4030_bci_usb_work(struct work_struct *data)
 {
-	struct twl4030_bci *bci = container_of(nb, struct twl4030_bci, otg_nb);
+	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
 
-	dev_dbg(bci->dev, "OTG notify %lu\n", val);
-
-	switch (val) {
+	switch (bci->event) {
 	case USB_EVENT_VBUS:
 	case USB_EVENT_CHARGER:
 		twl4030_charger_enable_usb(bci, true);
@@ -274,6 +274,17 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 		twl4030_charger_enable_usb(bci, false);
 		break;
 	}
+}
+
+static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
+			       void *priv)
+{
+	struct twl4030_bci *bci = container_of(nb, struct twl4030_bci, otg_nb);
+
+	dev_dbg(bci->dev, "OTG notify %lu\n", val);
+
+	bci->event = val;
+	schedule_work(&bci->work);
 
 	return NOTIFY_OK;
 }
@@ -466,6 +477,8 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 		goto fail_bci_irq;
 	}
 
+	INIT_WORK(&bci->work, twl4030_bci_usb_work);
+
 	bci->transceiver = otg_get_transceiver();
 	if (bci->transceiver != NULL) {
 		bci->otg_nb.notifier_call = twl4030_bci_usb_ncb;
-- 
1.7.1

