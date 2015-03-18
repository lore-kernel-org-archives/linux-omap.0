From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH 4/9] usb: otg: hub: Notify OTG fsm when A device sets b_hnp_enable
Date: Wed, 18 Mar 2015 15:55:58 +0200
Message-ID: <1426686963-11613-5-git-send-email-rogerq@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is the a_set_b_hnp_enable flag in the OTG state machine
diagram and must be set when the A-Host has successfully set
the b_hnp_enable feature of the OTG-B-Peripheral attached to it.

When this bit changes we kick our OTG FSM to make note of the
change and act accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
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
