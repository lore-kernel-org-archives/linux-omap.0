From: Hema HK <hemahk@ti.com>
Subject: [PATCH 1/5 v2] usb: otg: TWL4030: Update the last_event variable.
Date: Fri, 25 Feb 2011 18:54:02 +0530
Message-ID: <1298640246-21181-2-git-send-email-hemahk@ti.com>
References: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab1BYNYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 08:24:18 -0500
In-Reply-To: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

Update the last_event variable of otg_transceiver. This will be used in
the musb driver and gadget driver for runtime idling the device.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
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
1.7.0.4

