From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] phy: phy-twl4030-usb: Fix cable state handling
Date: Sun, 24 Mar 2019 16:26:54 -0700
Message-ID: <20190324232654.60812-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, NeilBrown <neilb@suse.com>
List-Id: linux-omap@vger.kernel.org

With the recent regulator changes I noticed new warnings on doing rmmod of
phy-twl4030-usb:

WARNING: CPU: 0 PID: 1080 at drivers/regulator/core.c:2046 _regulator_put
...

Turns out we can currently miss disconnect at least for cases where status
is 0 and linkstat is 0. And in that case doing rmmod phy-twl4030-usb will
produce the regulator_put() warning.

This is because the missed disconnect causes unbalanced PM runtime calls
and the regulators will be on exit.

Let's fix the issue by using an atomic flag for the cable state to make
sure that PM runtime won't get out of sync with the cable state. That
way we can also simplify the code a bit.

Note that we can also drop the old comments, those relate to issues that
the battery charger driver and musb driver is dealing with rather than
the USB PHY driver.

Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/ti/phy-twl4030-usb.c | 35 ++++++++++++--------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -172,6 +172,7 @@ struct twl4030_usb {
 
 	int			irq;
 	enum musb_vbus_id_status linkstat;
+	atomic_t		connected;
 	bool			vbus_supplied;
 	bool			musb_mailbox_pending;
 
@@ -575,39 +576,29 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
 	enum musb_vbus_id_status status;
-	bool status_changed = false;
 	int err;
 
 	status = twl4030_usb_linkstat(twl);
 
 	mutex_lock(&twl->lock);
-	if (status >= 0 && status != twl->linkstat) {
-		status_changed =
-			cable_present(twl->linkstat) !=
-			cable_present(status);
-		twl->linkstat = status;
-	}
+	twl->linkstat = status;
 	mutex_unlock(&twl->lock);
 
-	if (status_changed) {
-		/* FIXME add a set_power() method so that B-devices can
-		 * configure the charger appropriately.  It's not always
-		 * correct to consume VBUS power, and how much current to
-		 * consume is a function of the USB configuration chosen
-		 * by the host.
-		 *
-		 * REVISIT usb_gadget_vbus_connect(...) as needed, ditto
-		 * its disconnect() sibling, when changing to/from the
-		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
-		 * starts to handle softconnect right.
-		 */
-		if (cable_present(status)) {
+	if (cable_present(status)) {
+		if (atomic_add_unless(&twl->connected, 1, 1)) {
+			dev_dbg(twl->dev, "%s: cable connected %i\n",
+				__func__, status);
 			pm_runtime_get_sync(twl->dev);
-		} else {
+			twl->musb_mailbox_pending = true;
+		}
+	} else {
+		if (atomic_add_unless(&twl->connected, -1, 0)) {
+			dev_dbg(twl->dev, "%s: cable disconnected %i\n",
+				__func__, status);
 			pm_runtime_mark_last_busy(twl->dev);
 			pm_runtime_put_autosuspend(twl->dev);
+			twl->musb_mailbox_pending = true;
 		}
-		twl->musb_mailbox_pending = true;
 	}
 	if (twl->musb_mailbox_pending) {
 		err = musb_mailbox(status);
-- 
2.21.0
