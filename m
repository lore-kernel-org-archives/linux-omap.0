From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [RFC][PATCH v2 08/13] usb: otg: hub: Notify OTG fsm when A device sets b_hnp_enable
Date: Tue, 14 Apr 2015 13:41:55 +0300
Message-ID: <1429008120-5395-9-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is the a_set_b_hnp_enable flag in the OTG state machine
diagram and must be set when the A-Host has successfully set
the b_hnp_enable feature of the OTG-B-Peripheral attached to it.

When this bit changes we kick our OTG FSM to make note of the
change and act accordingly.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/core/hub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d7c3d5a..ab0d498 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -22,6 +22,7 @@
 #include <linux/usb/hcd.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/quirks.h>
+#include <linux/usb/usb-otg.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
@@ -2270,6 +2271,9 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 						"can't set HNP mode: %d\n",
 						err);
 					bus->b_hnp_enable = 0;
+				} else {
+					/* notify OTG fsm about a_set_b_hnp_enable */
+					usb_otg_kick_fsm(udev->bus->controller);
 				}
 			}
 		}
@@ -4244,8 +4248,13 @@ hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
 	 */
 	if (!hdev->parent) {
 		delay = HUB_ROOT_RESET_TIME;
-		if (port1 == hdev->bus->otg_port)
+		if (port1 == hdev->bus->otg_port) {
 			hdev->bus->b_hnp_enable = 0;
+#ifdef CONFIG_USB_OTG
+			/* notify OTG fsm about a_set_b_hnp_enable change */
+			usb_otg_kick_fsm(hdev->bus->controller);
+#endif
+		}
 	}
 
 	/* Some low speed devices have problems with the quick delay, so */
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
