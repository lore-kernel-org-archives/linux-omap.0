From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/4] usb: phy: twl4030: allow charger to see usb current
 draw limits.
Date: Tue, 24 Feb 2015 14:40:37 +1100
Message-ID: <20150224034037.31400.26595.stgit@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60594 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbbBXDmQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 22:42:16 -0500
In-Reply-To: <20150224033730.31400.78200.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>

The charger needs to know when a USB gadget has been enumerated
and what the agreed maximum current was so that it can adjust
charging accordingly.

So define a "set_power()" function to record the permitted
draw, and pass a pointer to that when sending USB_EVENT_ENUMERATED
notification.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/phy/phy-twl4030-usb.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 97c59074233f..023fe150c7a1 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -163,6 +163,11 @@ struct twl4030_usb {
 	enum omap_musb_vbus_id_status linkstat;
 	bool			vbus_supplied;
 
+	/* Permitted vbus draw - only meaningful after
+	 * USB_EVENT_ENUMERATED
+	 */
+	unsigned		vbus_draw;
+
 	struct delayed_work	id_workaround_work;
 };
 
@@ -547,12 +552,7 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 	mutex_unlock(&twl->lock);
 
 	if (status_changed) {
-		/* FIXME add a set_power() method so that B-devices can
-		 * configure the charger appropriately.  It's not always
-		 * correct to consume VBUS power, and how much current to
-		 * consume is a function of the USB configuration chosen
-		 * by the host.
-		 *
+		/*
 		 * REVISIT usb_gadget_vbus_connect(...) as needed, ditto
 		 * its disconnect() sibling, when changing to/from the
 		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
@@ -625,6 +625,20 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
+static int twl4030_set_power(struct usb_phy *phy, unsigned mA)
+{
+	struct twl4030_usb *twl = phy_to_twl(phy);
+
+	if (twl->vbus_draw != mA) {
+		phy->last_event = USB_EVENT_ENUMERATED;
+		twl->vbus_draw = mA;
+		atomic_notifier_call_chain(&phy->notifier,
+					   USB_EVENT_ENUMERATED,
+					   &twl->vbus_draw);
+	}
+	return 0;
+}
+
 static const struct phy_ops ops = {
 	.init		= twl4030_phy_init,
 	.power_on	= twl4030_phy_power_on,
@@ -675,6 +689,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.label		= "twl4030";
 	twl->phy.otg		= otg;
 	twl->phy.type		= USB_PHY_TYPE_USB2;
+	twl->phy.set_power	= twl4030_set_power;
 
 	otg->usb_phy		= &twl->phy;
 	otg->set_host		= twl4030_set_host;


