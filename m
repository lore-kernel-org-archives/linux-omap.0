From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 11/11] usb: otg: hub: Notify OTG fsm when A device sets b_hnp_enable
Date: Wed, 8 Jul 2015 13:19:37 +0300
Message-ID: <1436350777-28056-12-git-send-email-rogerq@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is the a_set_b_hnp_enable flag in the OTG state machine
diagram and must be set when the A-Host has successfully set
the b_hnp_enable feature of the OTG-B-Peripheral attached to it.

When this bit changes we kick our OTG FSM to make note of the
change and act accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/core/hub.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 43cb2f2..c358419 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2271,6 +2271,9 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 						"can't set HNP mode: %d\n",
 						err);
 					bus->b_hnp_enable = 0;
+				} else {
+					/* notify OTG fsm about a_set_b_hnp_enable */
+					usb_otg_kick_fsm(udev->bus->controller);
 				}
 			}
 		}
@@ -4234,8 +4237,13 @@ hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
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
2.1.4
