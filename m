From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 4/7] usb: phy: twl4030-usb: poll for ID disconnect
Date: Sun, 17 Mar 2013 20:23:24 +0200
Message-ID: <1363544607-17634-5-git-send-email-notasas@gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363544607-17634-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On pandora, STS_USB interrupt doesn't arrive on USB host cable disconnect
for some reason while VBUS is driven by twl itself, but STS_HW_CONDITIONS
is updated correctly. It does work fine when PHY is powered down though.
To work around that we have to poll.

This patch also moves twl->linkstat update code to callers so that
changes can be handled in thread safe way (as polling work can trigger
at the same time as real irq now).

TI PSP kernels have similar workarounds, so (many?) more boards are likely
affected.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/phy/phy-twl4030-usb.c |   64 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index b53a2a2..425c18a 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -163,6 +163,8 @@ struct twl4030_usb {
 	bool			vbus_supplied;
 	u8			asleep;
 	bool			irq_enabled;
+
+	struct delayed_work	id_workaround_work;
 };
 
 /* internal define on top of container_of */
@@ -287,10 +289,6 @@ static enum omap_musb_vbus_id_status
 	 * are registered, and that both are active...
 	 */
 
-	spin_lock_irq(&twl->lock);
-	twl->linkstat = linkstat;
-	spin_unlock_irq(&twl->lock);
-
 	return linkstat;
 }
 
@@ -412,6 +410,16 @@ static void twl4030_phy_resume(struct twl4030_usb *twl)
 	__twl4030_phy_resume(twl);
 	twl->asleep = 0;
 	dev_dbg(twl->dev, "%s\n", __func__);
+
+	/*
+	 * XXX When VBUS gets driven after musb goes to A mode,
+	 * ID_PRES related interrupts no longer arrive, why?
+	 * Register itself is updated fine though, so we must poll.
+	 */
+	if (twl->linkstat == OMAP_MUSB_ID_GROUND) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+	}
 }
 
 static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
@@ -491,10 +499,18 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
 	enum omap_musb_vbus_id_status status;
-	enum omap_musb_vbus_id_status status_prev = twl->linkstat;
+	bool status_changed = false;
 
 	status = twl4030_usb_linkstat(twl);
-	if (status > 0 && status != status_prev) {
+
+	spin_lock_irq(&twl->lock);
+	if (status >= 0 && status != twl->linkstat) {
+		twl->linkstat = status;
+		status_changed = true;
+	}
+	spin_unlock_irq(&twl->lock);
+
+	if (status_changed) {
 		/* FIXME add a set_power() method so that B-devices can
 		 * configure the charger appropriately.  It's not always
 		 * correct to consume VBUS power, and how much current to
@@ -506,13 +522,42 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
 		 * starts to handle softconnect right.
 		 */
-		omap_musb_mailbox(twl->linkstat);
+		omap_musb_mailbox(status);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 
 	return IRQ_HANDLED;
 }
 
+static void twl4030_id_workaround_work(struct work_struct *work)
+{
+	struct twl4030_usb *twl = container_of(work, struct twl4030_usb,
+		id_workaround_work.work);
+	enum omap_musb_vbus_id_status status;
+	bool status_changed = false;
+
+	status = twl4030_usb_linkstat(twl);
+
+	spin_lock_irq(&twl->lock);
+	if (status >= 0 && status != twl->linkstat) {
+		twl->linkstat = status;
+		status_changed = true;
+	}
+	spin_unlock_irq(&twl->lock);
+
+	if (status_changed) {
+		dev_dbg(twl->dev, "handle missing status change to %d\n",
+			status);
+		omap_musb_mailbox(status);
+	}
+
+	/* don't schedule during sleep - irq works right then */
+	if (status == OMAP_MUSB_ID_GROUND && !twl->asleep) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+	}
+}
+
 static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 {
 	enum omap_musb_vbus_id_status status;
@@ -525,6 +570,8 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 	twl->asleep = 1;
 
 	status = twl4030_usb_linkstat(twl);
+	twl->linkstat = status;
+
 	if (status == OMAP_MUSB_ID_GROUND || status == OMAP_MUSB_VBUS_VALID)
 		omap_musb_mailbox(twl->linkstat);
 
@@ -613,6 +660,8 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
 
+	INIT_DELAYED_WORK(&twl->id_workaround_work, twl4030_id_workaround_work);
+
 	err = twl4030_usb_ldo_init(twl);
 	if (err) {
 		dev_err(&pdev->dev, "ldo init failed\n");
@@ -656,6 +705,7 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 	struct twl4030_usb *twl = platform_get_drvdata(pdev);
 	int val;
 
+	cancel_delayed_work(&twl->id_workaround_work);
 	free_irq(twl->irq, twl);
 	device_remove_file(twl->dev, &dev_attr_vbus);
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
