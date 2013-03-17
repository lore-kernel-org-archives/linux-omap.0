From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 1/7] usb: phy: twl4030-usb: don't enable PHY during init
Date: Sun, 17 Mar 2013 20:23:21 +0200
Message-ID: <1363544607-17634-2-git-send-email-notasas@gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363544607-17634-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

There is no need to do it, otg.set_suspend(false) (which itself
comes from runtime_pm OMAP glue calls) will enable it later anyway.
This used to be the place where things were enabled if booted with
cable connected before runtime_pm conversion, but now can be dropped.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/phy/phy-twl4030-usb.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index a994715..9e47118 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -522,19 +522,17 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 {
 	enum omap_musb_vbus_id_status status;
 
-	status = twl4030_usb_linkstat(twl);
-	if (status > 0) {
-		if (status == OMAP_MUSB_VBUS_OFF ||
-				status == OMAP_MUSB_ID_FLOAT) {
-			__twl4030_phy_power(twl, 0);
-			twl->asleep = 1;
-		} else {
-			__twl4030_phy_resume(twl);
-			twl->asleep = 0;
-		}
+	/*
+	 * Start in sleep state, we'll get called through set_suspend()
+	 * callback when musb is runtime resumed and it's time to start.
+	 */
+	__twl4030_phy_power(twl, 0);
+	twl->asleep = 1;
 
+	status = twl4030_usb_linkstat(twl);
+	if (status > 0)
 		omap_musb_mailbox(twl->linkstat);
-	}
+
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 }
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
