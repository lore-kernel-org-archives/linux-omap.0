From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] usb: phy: twl4030-usb: Fix lost interrupts after ID pin goes
 down
Date: Thu, 21 Aug 2014 09:48:04 -0700
Message-ID: <20140821164803.GB10066@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 249751f22380 ("usb: phy: twl4030-usb: poll for ID disconnect")
added twl4030_id_workaround_work() to deal with lost interrupts
after ID pin goes down. However, this currently only works for the
insertion. The PHY interrupts are not working after disconnecting
an USB-A device from the board, and the deeper idle states for
omap are blocked as the USB controller stays busy.

The issue can be solved by calling delayed work from twl4030_usb_irq()
when ID pin is down and the PHY is not asleep like we already do
in twl4030_id_workaround_work().

But as both twl4030_usb_irq() and twl4030_id_workaround_work()
already do pretty much the same thing, let's call twl4030_usb_irq()
from twl4030_id_workaround_work() instead of adding some more
duplicate code.

Fixes: 249751f22380 ("usb: phy: twl4030-usb: poll for ID disconnect")
Cc: stable@vger.kernel.org # v3.12+
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

This too is intended for the v3.17-rc cycle if no objections.

--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -589,6 +589,13 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		}
 		omap_musb_mailbox(status);
 	}
+
+	/* don't schedule during sleep - irq works right then */
+	if (status == OMAP_MUSB_ID_GROUND && !twl->asleep) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+	}
+
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 
 	return IRQ_HANDLED;
@@ -598,29 +605,8 @@ static void twl4030_id_workaround_work(struct work_struct *work)
 {
 	struct twl4030_usb *twl = container_of(work, struct twl4030_usb,
 		id_workaround_work.work);
-	enum omap_musb_vbus_id_status status;
-	bool status_changed = false;
-
-	status = twl4030_usb_linkstat(twl);
 
-	spin_lock_irq(&twl->lock);
-	if (status >= 0 && status != twl->linkstat) {
-		twl->linkstat = status;
-		status_changed = true;
-	}
-	spin_unlock_irq(&twl->lock);
-
-	if (status_changed) {
-		dev_dbg(twl->dev, "handle missing status change to %d\n",
-				status);
-		omap_musb_mailbox(status);
-	}
-
-	/* don't schedule during sleep - irq works right then */
-	if (status == OMAP_MUSB_ID_GROUND && !twl->asleep) {
-		cancel_delayed_work(&twl->id_workaround_work);
-		schedule_delayed_work(&twl->id_workaround_work, HZ);
-	}
+	twl4030_usb_irq(0, twl);
 }
 
 static int twl4030_phy_init(struct phy *phy)
