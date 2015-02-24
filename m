From: NeilBrown <neilb@suse.de>
Subject: [PATCH 4/4] usb: phy: twl4030: test ID resistance to see if charger
 is present.
Date: Tue, 24 Feb 2015 14:40:37 +1100
Message-ID: <20150224034037.31400.48003.stgit@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60629 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbbBXDmb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 22:42:31 -0500
In-Reply-To: <20150224033730.31400.78200.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>

If an 'A' plug is inserted, ID should be pulled to ground.
If a 'B' plug, then ID should be floating.

If an Accessory Charger Adapter is inserted, then ID will
be neither grounded nor floating.  In this case tell the
USB subsystem that it is an A plug, and the battery
charging subsystem that it is a charger.

Fortunately, this will treat the Openmoko charger (and
other similar chargers) as a charger.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/phy/phy-twl4030-usb.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 759950898df9..8a43080cdbd7 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -596,9 +596,31 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 	struct twl4030_usb *twl = _twl;
 	enum omap_musb_vbus_id_status status;
 	bool status_changed = false;
+	bool found_charger = false;
 
 	status = twl4030_usb_linkstat(twl);
 
+	if (status == OMAP_MUSB_ID_GROUND ||
+	    status == OMAP_MUSB_VBUS_VALID) {
+		/* We should check the resistance on the ID pin.
+		 * If not a Ground or Floating, then this is
+		 * likely a charger
+		 */
+		enum twl4030_id_status sts = twl4030_get_id(twl);
+		if (sts > TWL4030_GROUND &&
+		    sts < TWL4030_FLOATING) {
+			/*
+			 * This might be a charger, or an
+			 * Accessory Charger Adapter.
+			 * In either case we can charge, and it
+			 * makes sense to tell the USB system
+			 * that we might be acting as a HOST.
+			 */
+			status = OMAP_MUSB_ID_GROUND;
+			found_charger = true;
+		}
+	}
+
 	mutex_lock(&twl->lock);
 	if (status >= 0 && status != twl->linkstat) {
 		status_changed =
@@ -627,6 +649,12 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		}
 		omap_musb_mailbox(status);
 	}
+	if (found_charger && twl->phy.last_event != USB_EVENT_CHARGER) {
+		twl->phy.last_event = USB_EVENT_CHARGER;
+		atomic_notifier_call_chain(&twl->phy.notifier,
+					   USB_EVENT_CHARGER,
+					   NULL);
+	}
 
 	/* don't schedule during sleep - irq works right then */
 	if (status == OMAP_MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {


