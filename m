From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 04/19] usb: otg: TWL4030: Update the last_event variable.
Date: Tue,  1 Mar 2011 17:15:25 +0200
Message-ID: <1298992540-5984-5-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59586 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100Ab1CAPQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:16:18 -0500
In-Reply-To: <1298992540-5984-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

Update the last_event variable of otg_transceiver. This will be used in
the musb platform glue driver for runtime idling the device.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/otg/twl4030-usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 2362d83..e01b073 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -275,6 +275,8 @@ static enum usb_xceiv_events twl4030_usb_linkstat(struct twl4030_usb *twl)
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
 			status, status, linkstat);
 
+	twl->otg.last_event = linkstat;
+
 	/* REVISIT this assumes host and peripheral controllers
 	 * are registered, and that both are active...
 	 */
-- 
1.7.4.rc2

