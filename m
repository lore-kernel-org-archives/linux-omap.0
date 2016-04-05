From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 11/12] usb: core: hub: Notify OTG fsm when A device sets b_hnp_enable
Date: Tue, 5 Apr 2016 17:05:16 +0300
Message-ID: <1459865117-7032-12-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is the a_set_b_hnp_enable flag in the OTG state machine
diagram and must be set when the A-Host has successfully set
the b_hnp_enable feature of the OTG-B-Peripheral attached to it.

When this bit changes we kick our OTG FSM to make note of the
change and act accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/core/hub.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 38cc4ba..27e3b4c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2273,6 +2273,7 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 			&& udev->parent == udev->bus->root_hub) {
 		struct usb_otg_descriptor	*desc = NULL;
 		struct usb_bus			*bus = udev->bus;
+		struct usb_hcd			*hcd = bus_to_hcd(bus);
 		unsigned			port1 = udev->portnum;
 
 		/* descriptor may appear anywhere in config */
@@ -2302,6 +2303,9 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 				dev_err(&udev->dev, "can't set HNP mode: %d\n",
 									err);
 				bus->b_hnp_enable = 0;
+			} else {
+				/* notify OTG fsm about a_set_b_hnp_enable */
+				usb_otg_kick_fsm(hcd->otg_dev);
 			}
 		} else if (desc->bLength == sizeof
 				(struct usb_otg_descriptor)) {
@@ -2312,10 +2316,14 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 				USB_DEVICE_A_ALT_HNP_SUPPORT,
 				0, NULL, 0,
 				USB_CTRL_SET_TIMEOUT);
-			if (err < 0)
+			if (err < 0) {
 				dev_err(&udev->dev,
 					"set a_alt_hnp_support failed: %d\n",
 					err);
+			} else {
+				/* notify OTG fsm about a_set_b_hnp_enable */
+				usb_otg_kick_fsm(hcd->otg_dev);
+			}
 		}
 	}
 #endif
@@ -4355,8 +4363,13 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	 */
 	if (!hdev->parent) {
 		delay = HUB_ROOT_RESET_TIME;
-		if (port1 == hdev->bus->otg_port)
+		if (port1 == hdev->bus->otg_port) {
 			hdev->bus->b_hnp_enable = 0;
+#ifdef CONFIG_USB_OTG
+			/* notify OTG fsm about a_set_b_hnp_enable change */
+			usb_otg_kick_fsm(hcd->otg_dev);
+#endif
+		}
 	}
 
 	/* Some low speed devices have problems with the quick delay, so */
-- 
2.5.0
