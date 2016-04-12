From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/3] usb: dwc3: gadget: Fix suspend/resume during device mode
Date: Tue, 12 Apr 2016 11:33:29 +0300
Message-ID: <570CB2D9.2060300@ti.com>
References: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Gadget controller might not be always active during system
suspend/resume as gadget driver might not have yet been loaded or
might have been unloaded prior to system suspend.

Check if we're active and only then perform
necessary actions during suspend/resume.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3ac170f..efbb801 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2931,6 +2931,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	if (!dwc->gadget_driver)
+		return 0;
+
 	if (dwc->pullups_connected) {
 		dwc3_gadget_disable_irq(dwc);
 		dwc3_gadget_run_stop(dwc, true, true);
@@ -2949,6 +2952,9 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
-- 
2.5.0
