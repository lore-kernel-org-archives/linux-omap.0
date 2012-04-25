From: NeilBrown <neilb@suse.de>
Subject: [PATCH 6/6] twl4030-usb: Don't report EVENT_ID when there is VBUS.
Date: Wed, 25 Apr 2012 17:33:11 +1000
Message-ID: <20120425073311.20124.58619.stgit@notabene.brown>
References: <20120425072931.20124.56635.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120425072931.20124.56635.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

Some USB chargers tie the ID pin low via various resistors.
So they can cause VBUS to be high and ID to be low.

The 'A' end of an OTG cable never receives VBUS, it only ever generates it.

So if we see VBUS and are not generating it, this must be a charger,
not the A end of an OTG cable, so in that case, ignore the fact that
ID is low.

This assumes that VBUS_PRES isn't asserted when the charge pump is
providing VBUS.  The document isn't clear on this and some experiments
suggest that it isn't.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 drivers/usb/otg/twl4030-usb.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index bd8fe9b..990400f 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -268,15 +268,16 @@ static enum usb_phy_events twl4030_usb_linkstat(struct twl4030_usb *twl)
 			STS_HW_CONDITIONS);
 	if (status < 0)
 		dev_err(twl->dev, "USB link status err %d\n", status);
-	else if (status & (BIT(7) | BIT(2))) {
-		if (status & (BIT(7)))
-                        twl->vbus_supplied = true;
-
-		if (status & BIT(2))
-			linkstat = USB_EVENT_ID;
-		else
-			linkstat = USB_EVENT_VBUS;
-	} else
+	else if (status & (BIT(7))) {
+		/* We have VBUS so ignore ID_PRES - it is only meaningful
+		 * as an indicator of an A plug when there is no
+		 * VBUS.
+		 */
+		twl->vbus_supplied = true;
+		linkstat = USB_EVENT_VBUS;
+	} else if (status & BIT(2))
+		linkstat = USB_EVENT_ID;
+	else
 		linkstat = USB_EVENT_NONE;
 
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
