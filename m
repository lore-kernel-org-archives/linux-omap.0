From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH 5/9] usb: hcd: adapt to OTG
Date: Wed, 18 Mar 2015 15:55:59 +0200
Message-ID: <1426686963-11613-6-git-send-email-rogerq@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Register with OTG core as part of usb_add_hcd() and
unregister from it in usb_remove_hcd().

For OTG device the HCD is actually started or stopped
from the OTG FSM.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/core/hcd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index e28bd9d..9e8ecc9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -46,6 +46,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/usb-otg.h>
 
 #include "usb.h"
 
@@ -2826,9 +2827,12 @@ int usb_add_hcd(struct usb_hcd *hcd,
 			goto err_request_irq;
 	}
 
-	retval = usb_start_hcd(hcd);
-	if (retval)
-		goto err_hcd_driver_start;
+	/* If OTG device, OTG core takes care of starting HCD */
+	if (usb_otg_register_hcd(hcd)) {
+		retval = usb_start_hcd(hcd);
+		if (retval)
+			goto err_hcd_driver_start;
+	}
 
 	return 0;
 
@@ -2936,7 +2940,9 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 {
 	dev_info(hcd->self.controller, "remove, state %x\n", hcd->state);
 
-	usb_stop_hcd(hcd);
+	/* If OTG device, OTG core takes care of stopping HCD */
+	if (usb_otg_unregister_hcd(hcd))
+		usb_stop_hcd(hcd);
 
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		if (hcd->irq > 0)
-- 
2.1.0
