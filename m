From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 2/7] usb: phy: twl4030-usb: ignore duplicate events
Date: Sun, 17 Mar 2013 20:23:22 +0200
Message-ID: <1363544607-17634-3-git-send-email-notasas@gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363544607-17634-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In some rare cases we may get multiple interrupts that will generate
duplicate omap_musb_mailbox() calls. This is a problem because each
VBUS/ID event generates runtime_pm call in OMAP glue code, causing
unbalanced gets or puts and breaking PM.

The same goes for initial state, glue already defaults to "no cable"
state, so only bother it if we have VBUS or ID.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/phy-twl4030-usb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index 9e47118..305463b 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -491,9 +491,10 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
 	enum omap_musb_vbus_id_status status;
+	enum omap_musb_vbus_id_status status_prev = twl->linkstat;
 
 	status = twl4030_usb_linkstat(twl);
-	if (status > 0) {
+	if (status > 0 && status != status_prev) {
 		/* FIXME add a set_power() method so that B-devices can
 		 * configure the charger appropriately.  It's not always
 		 * correct to consume VBUS power, and how much current to
@@ -530,7 +531,7 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 	twl->asleep = 1;
 
 	status = twl4030_usb_linkstat(twl);
-	if (status > 0)
+	if (status == OMAP_MUSB_ID_GROUND || status == OMAP_MUSB_VBUS_VALID)
 		omap_musb_mailbox(twl->linkstat);
 
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
